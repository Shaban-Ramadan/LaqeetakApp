import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:laqeetak/coure/services/network/firebase_keys(1).dart';
import 'package:laqeetak/feature/model/loser_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'loser_states.dart';

class LoserCubit extends Cubit<LoserState> {
  LoserCubit() : super(LoserInitial());

  static LoserCubit get(context) => BlocProvider.of<LoserCubit>(context);

  final TextEditingController loserNameController = TextEditingController();

  final TextEditingController loserDateController = TextEditingController();

  final TextEditingController loserDiscretionController =
      TextEditingController();

  // باستخدام Google Maps

  List<File?> loserImages = [null, null, null];
  String? selectedCategory;

  final List<String> categories = [
    'مفاتيح',
    'موبايلات',
    'محافظ',
    'ساعات',
  ];
  final picker = ImagePicker();

  // pick image for specific index
  Future<void> loserPicImage(int index) async {
    final pickFile = await picker.pickImage(source: ImageSource.camera);
    if (pickFile != null) {
      loserImages[index] = File(pickFile.path);
      emit(LoserPickImageState());
    }
  }

  void changeCategory(String? value) {
    selectedCategory = value;
    emit(CategoryChangedState());
  }

  TextEditingController loserLocationSearchController = TextEditingController();
  LatLng? loserLocation;
  late double latitude;
  late double longitude;
  List<Map<String, dynamic>> searchResults = [];
  bool isSearching = false;

  Future<void> searchLoserLocations(String query) async {
    if (query.isEmpty) {
      searchResults = [];
      emit(LoserLocationPickedState());
      return;
    }

    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search'
      '?q=$query&format=json&addressdetails=1&limit=5',
    );

    final response = await http.get(
      url,
      headers: {'User-Agent': 'laqeetak-app'},
    );

    if (response.statusCode == 200) {
      searchResults =
          List<Map<String, dynamic>>.from(jsonDecode(response.body));

      emit(LoserLocationPickedState());
    }
  }

  void selectSearchedLocation(Map<String, dynamic> place) {
    final lat = double.parse(place['lat']);
    final lon = double.parse(place['lon']);

    loserLocation = LatLng(lat, lon);
    latitude = lat;
    longitude = lon;

    searchResults.clear();
    loserLocationSearchController.text = place['display_name'];

    emit(LoserLocationPickedState()); // مرة واحدة بس

    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.move(loserLocation!, 15);
    });
  }

  final MapController mapController = MapController();

  void loserPickLocation(LatLng location) {
    loserLocation = location;
    longitude = loserLocation!.longitude;
    latitude = loserLocation!.latitude;
    emit(LoserLocationPickedState());
    print(" longitude =$longitude");
    print(" latitude =$latitude");
  }

  void clearSearchResults() {
    searchResults.clear();
    emit(LoserLocationPickedState());
  }

  void updateCenter(LatLng center) {
    loserLocation = center;
    latitude = center.latitude;
    longitude = center.longitude;
  }

  void saveLocation() {
    if (loserLocation != null) {
      // هنا ممكن تحفظ البيانات في قاعدة بيانات أو SharedPreferences
      print("تم حفظ الموقع:");
      print("Latitude: $latitude");
      print("Longitude: $longitude");
    } else {
      print("لا يوجد موقع ليتم حفظه");
    }
  }

  ///upload to cloudinary storage

  Future<void> uploadLoserImages() async {
    emit(LoserUploadLoadingState());

    try {
      List<File> imagesToUpload = loserImages.whereType<File>().toList();

      if (imagesToUpload.isEmpty) {
        emit(LoserUploadErrorState('لا توجد صور للرفع'));
        return;
      }

      await uploadMultipleImages(imagesToUpload);

      emit(LoserUploadSuccessState());
    } catch (e) {
      emit(LoserUploadErrorState(e.toString()));
    }
  }

  List<String> uploadedImageUrls = []; // قائمة روابط الصور
  Future<File?> compressImage(File file) async {
    final compressed = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      "${file.path}_compressed.jpg",
      quality: 60,
    );

    if (compressed == null) return null;
    return File(compressed.path);
  }
  Future<void> uploadMultipleImages(List<File> images) async {
    uploadedImageUrls.clear(); // نظف القائمة قبل كل رفع
    for (var image in images) {
      File? compressedImage = await compressImage(image);
      String? url = await upLoadLoserImage(compressedImage?? image);
      if (url != null) {
        uploadedImageUrls.add(url);
      }
    }
    print('All uploaded images: $uploadedImageUrls');
  }


  /// up رفع صوره الى cloudinary
  Future<String?> upLoadLoserImage(File imageFile) async {
    try {
      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dvg8vso0u/upload',
      );

      final request = http.MultipartRequest('POST', url);

      // اسم الـ Upload Preset مش Cloud Name
      request.fields['upload_preset'] = 'loser_upload';

      // (اختياري) فولدر جوه Cloudinary
      request.fields['folder'] = 'losers';

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
        ),
      );

      final response = await request.send();
      final resStr = await response.stream.bytesToString();
      final data = json.decode(resStr);

      if (response.statusCode == 200) {
        return data['secure_url'];
      } else {
        print('Upload failed: $resStr');
        return null;
      }
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }

  Future<void> storeLoserData() async {
    emit(LoserUploadLoadingState());

    try {
      // تحقق من وجود البيانات الأساسية
      if (loserNameController.text.trim().isEmpty || selectedCategory == null) {
        emit(LoserUploadErrorState("الاسم أو التصنيف غير موجود"));
        return;
      }

      // تحضير الصور: تجاهل الصور الفاضية
      List<String> safeUploadedImages = uploadedImageUrls
          .where((url) => url != null && url.isNotEmpty)
          .cast<String>()
          .toList();
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      final docRef = FirebaseFirestore.instance
          .collection(FirebaseKeys.items)
          .doc(); // auto id
      print(" item id =${docRef.id}");
      final loserItemModel = LoserItemModel(
        itemId: docRef.id,
        ownerId: currentUserId,
        title: loserNameController.text.trim(),
        description: loserDiscretionController.text.trim(),
        category: selectedCategory!.trim(),
        date: loserDateController.text.trim(),
        latitude: latitude ?? 0.0,
        longitude: longitude ?? 0.0,
        locationName: loserLocationSearchController.text.trim(),
        images: safeUploadedImages,
      );

      // رفع البيانات في Firestore

      await docRef.set(loserItemModel.toMap());

      emit(LoserUploadSuccessState());

      // مسح البيانات بعد النجاح
      loserNameController.clear();
      loserDiscretionController.clear();
      loserDateController.clear();
      selectedCategory = null;
      uploadedImageUrls.clear();
      loserLocationSearchController.clear();
      latitude = 0;
      longitude = 0;
    } catch (e) {
      print('Error storing data: $e');
      emit(LoserUploadErrorState(e.toString()));
    }
  }
  final List<LoserItemModel> allItems = [];
  final List<LoserItemModel> mobiles = [];
  final List<LoserItemModel> wallets = [];
  final List<LoserItemModel> clocks = [];
  final List<LoserItemModel> keys = [];
  List<LoserItemModel> displayedItems = [];

  void filterItemsByTab(int selectedTabIndex) {
    switch (selectedTabIndex) {
      case 0:
        displayedItems = List.from(allItems); // clone علشان تتجنب المشاكل
        break;
      case 1:
        displayedItems = List.from(mobiles);
        break;
      case 2:
        displayedItems = List.from(wallets);
        break;
      case 3:
        displayedItems = List.from(clocks);
        break;
      case 4:
        displayedItems = List.from(keys);
        break;
      default:
        displayedItems = [];
    }

    emit(LoserFilterChanged());
  }

  Future<void> fetchLoserData() async {
    print("fatchLoserDataCalled");
    try {
      emit(FetchLoserDataLoadingState());
      // مسح القوائم قبل أي إضافة
      allItems.clear();
      mobiles.clear();
      clocks.clear();
      keys.clear();
      wallets.clear();

      // جلب البيانات من Firebase
      final querySnapshot =
          await FirebaseFirestore.instance.collection(FirebaseKeys.items).get();

      for (var doc in querySnapshot.docs) {
        final item = LoserItemModel.fromMap(doc.data());
        print("item id:${item.itemId}");
        allItems.add(item);
        if (allItems.length <= 5) {
          print("allItems length=${allItems.length}");
          print("first Item =${allItems.first.title}");
        }
        // توزيع العناصر حسب التصنيف
        switch (item.category) {
          case FirebaseKeys.mobiles:
            mobiles.add(item);
            break;
          case FirebaseKeys.clocks:
            clocks.add(item);
            break;
          case FirebaseKeys.keys:
            keys.add(item);
            break;
          case FirebaseKeys.wallets:
            wallets.add(item);
            break;
          default:
            print('Unknown category: ${item.category}');
        }
      }

      // تحديث displayedItems مرة واحدة بعد ما كله يتحمل
      displayedItems = List.from(allItems);

      emit(FetchLoserDataSuccessState());
    } catch (e) {
      emit(FetchLoserDataErrorState(e.toString()));
    }
  }

  void homeSearchItems(String query) {
    emit(LoserSearchLoad());
    if (query.isEmpty) {
      displayedItems = allItems;
    } else {
      displayedItems = allItems.where((item) {
        return item.title.toLowerCase().contains(query.toLowerCase()) ||
            item.category.toLowerCase().contains(query.toLowerCase()) ||
            item.locationName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    emit(LoserSearchSuccess());
  }

  List<LoserItemModel> searchViewResults = [];

  void initSearch() {
    searchViewResults = List.from(allItems);
    emit(LoserSearchInit());
  }

  void viewSearchItem(String query) {
    if (query.isEmpty) {
      searchViewResults = List.from(allItems);
    } else {
      searchViewResults = allItems.where((item) {
        return item.title.toLowerCase().contains(query.toLowerCase()) ||
            item.category.toLowerCase().contains(query.toLowerCase()) ||
            item.locationName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    emit(LoserSearchUpdated());
  }

  List<LoserItemModel> myPosts = [];

  void getMyPosts() {
    print(' getMyPosts called');
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    myPosts = allItems.where((item) => item.ownerId == currentUserId).toList();

    emit(LoserMyPostsLoaded());
    print('تم تحميل عرض منشوراتي');
  }
  List<bool> isClickList = [];

  void initClickList(int length) {
    isClickList = List.generate(length, (index) => false);
    emit(ToGallSuccessState());
  }

  void toGallClick(int index) {
    isClickList[index] = !isClickList[index];
    emit(ToGallSuccessState());
  }

  void deletePost(int index) async {
    try {
      // أولًا، احصل على الـ itemId عشان نحذفه من Firestore
      final itemId = myPosts[index].itemId;

      // احذف المستند من Firestore
      await FirebaseFirestore.instance
          .collection(FirebaseKeys.items)
          .doc(itemId)
          .delete();

      // بعد ما يتحذف من Firestore، احذف من القائمة المحلية
      myPosts.removeAt(index);
      isClickList.removeAt(index);

      emit(RemovePostSuccessState());
    } catch (e) {
      print("Error deleting post from Firebase: $e");
      emit(LoserUploadErrorState("فشل حذف البوست من Firebase"));
    }
  }
}
