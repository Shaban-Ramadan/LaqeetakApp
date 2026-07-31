import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laqeetak/coure/services/local/shared_helper(1).dart';
import 'package:laqeetak/coure/services/local/shared_keys(1).dart';
import 'package:laqeetak/coure/services/network/firebase_keys(1).dart';
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import 'package:laqeetak/feature/model/user_model.dart';
import 'package:laqeetak/feature/view/auth/sign_in.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_states.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of<UserCubit>(context);

  // ===================== Controllers =====================
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController = TextEditingController();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  /// OTP Controllers
  List<TextEditingController> otpControllers =
  List.generate(4, (_) => TextEditingController());
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> sinUpFormKey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;
  bool obscureSignUp = true;
  bool obscureLogin = true;
  bool isSelected = false;
  bool rememberMe = false;

  void togglePasswordVisibilityLogin() {
    obscureLogin = !obscureLogin;
    emit(TogglePasswordVisibilityLogin());
  }

  void togglePasswordVisibilitSignUp() {
    obscureSignUp = !obscureSignUp;
    emit(TogglePasswordVisibilitySignUp());
  }

  void swapRememberMe() {
    rememberMe = !rememberMe;
    emit(RememberMeSuccessState());
  }

  void swapPolicy() {
    isSelected = !isSelected;
    emit(PolicySuccessState());
  }

  String? validateName(String? value) {
    if ((value ?? '').isEmpty) {
      return "ادخل الاسم ";
    } else if ((value?.length ?? 0) < 4) {
      return "  يجب ان ان لا يقل عن 4 احرف  ";
    }
    return null;
  }

  String? validateNumber(String? value) {
    // التحقق من أن القيمة ليست فارغة
    if (value == null || value.isEmpty) {
      return "يرجى إدخال رقم الهاتف";
    }
    // التحقق من أن الرقم يتكون من أرقام فقط
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "يجب إدخال أرقام فقط";
    }
    // التحقق من طول الرقم (يجب أن يكون 11 رقمًا)
    if (value.length != 11) {
      return "رقم الهاتف يجب أن يكون 11 رقمًا";
    }

    // التحقق من أن الرقم يبدأ بـ 01 ثم 0 أو 1 أو 2 أو 5
    if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(value)) {
      return "رقم الهاتف غير صحيح، تأكد من إدخال رقم مصري صحيح";
    }
    //  إذا مر بكل الشروط، فالإرجاع يكون null (أي لا يوجد خطأ)
    return null;
  }

  // التحقق من البريد الإلكتروني
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "البريد الإلكتروني مطلوب";
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value)) {
      return "أدخل بريد إلكتروني صحيح";
    }
    return null;
  }

  // التحقق من الرقم السري
  String? validatePassword(String? value) {
    if ((value ?? '').isEmpty) {
      return "ادخل الرقم السري";
    } else if ((value?.length ?? 0) < 8) {
      return "  يجب ان لا  يقل 8 احرف  ";
    } else if (!RegExp(r'[A-Z]').hasMatch(value ?? '')) {
      return "  يجب ان يحتوي على حرف كبير";
    } else if (!RegExp(r'[0-9]').hasMatch(value ?? '')) {
      return "  يجب ان يحتوي على رقم";
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value ?? '')) {
      return "  يجب ان يحتوي على علامة خاصة";
    }
    return null;
  }

  // ===================== Authentication =====================

  void signUp() async {
    if (signUpEmailController.text
        .trim()
        .isEmpty ||
        signUpPasswordController.text
            .trim()
            .isEmpty) {
      emit(UserAuthSignUpError("البريد الإلكتروني أو كلمة المرور فارغة"),);
      return;
    }
    emit(UserLoadingSignUpState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signUpEmailController.text.trim(),
        password: signUpPasswordController.text.trim(),
      ).then((value) {
        print(value.user?.email);
        print(value.user?.uid);
        emit(UserSuccessSignUpState());
      },);
      await storeUserData();
    } on FirebaseAuthException catch (e) {
      String messge = '';
      if (e.code == 'weak-password') {
        messge = 'الباسورد  ضعيف';
      } else if (e.code == 'email-already-in-use') {
        messge = 'الاميل مستخدم بالفعل';
      }
      emit(UserAuthSignUpError(messge));
    } catch (e) {}
  }

  void signIn() async {
    // أولًا: التحقق من إن الحقول مش فاضية
    if (loginEmailController.text.trim().isEmpty ||
        loginPasswordController.text.trim().isEmpty) {
      emit(UserAuthLogInError("البريد الإلكتروني أو كلمة المرور فارغة"));
      return;
    }
    emit(UserLoadingLoginState());

    try {
      // تسجيل الدخول
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: loginEmailController.text.trim(),
          password: loginPasswordController.text.trim());

      // تسجيل الدخول نجح
      print("Email: ${userCredential.user?.email}");
      print("UID: ${userCredential.user?.uid}");

      emit(UserSuccessLoginState()); // أو UserSuccessLoginState لو موجود
    } on FirebaseAuthException catch (e) {
      // هنا بنمسك استثناءات FirebaseAuth
      String message = '';

      if (e.code == 'user-not-found') {
        message = 'الايميل ليس مسجل';
      } else if (e.code == 'wrong-password') {
        message = 'كلمة المرور خطأ';
      } else if (e.code == 'network-request-failed') {
        message = 'تأكد من الاتصال بالإنترنت';
      } else {
        message = 'حدث خطأ غير متوقع: ${e.message}';
      }

      emit(UserAuthLogInError(message));
    } catch (e) {
      // أي خطأ آخر
      emit(UserAuthLogInError('حدث خطأ غير متوقع'));
    }
  }
  final googleSignIn = GoogleSignIn();
  Future<User?> signInWithGoogle() async {
    emit(UserLoadingLoginState()); //

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // المستخدم ألغى الاختيار
        emit(UserAuthLogInError("تم إلغاء تسجيل الدخول"));
        return null;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await FirebaseAuth.instance.signInWithCredential(
          credential);

      emit(UserSignInWithGoogleState());
      print("تم تسجيل الدخول بحساب Google بنجاح!");
      return userCred.user;
    } on FirebaseAuthException catch (e) {
      emit(UserAuthLogInError(e.message ?? "حدث خطأ أثناء تسجيل الدخول"));
      return null;
    } catch (e) {
      emit(UserAuthLogInError("حدث خطأ غير متوقع"));
      return null;
    }
  }



  Future<void> storeUserData() async {
    // ⃣ Emit loading state
    emit(UserStoreLoadingState());

    try {
      // ⃣ تأكد إن فيه يوزر موجود بعد التسجيل
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(UserAuthSignUpError("لم يتم العثور على المستخدم بعد التسجيل"));
        return;
      }

      final userModel = UserModel(
        userId: user.uid,
        userName: nameController.text.trim(),
        useEmail: signUpEmailController.text.trim(),
        usePhoneNumber: phoneController.text.trim(),
        useLocation: locationController.text.trim(),
        usePassword: signUpPasswordController.text.trim(),
        useImage: imageController.text.trim(),
      );
      await
      FirebaseFirestore.instance .collection(FirebaseKeys.users)
          .doc(userModel.userId).set(userModel.toJos());


      // ⃣ جلب البيانات من Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection(FirebaseKeys.users)
          .doc(user.uid)
          .get();

      if (!snapshot.exists) {
        emit(UserAuthSignUpError("لم يتم العثور على بيانات المستخدم في Firestore"));
        return;
      }

      final fetchedUser = UserModel.fromJos(snapshot);

      // ⃣ خزنه في SharedPreferences
      await SharedHelper.set(key: SharedKeys.userId, value: fetchedUser.userId);
      await SharedHelper.set(key: SharedKeys.userName, value: fetchedUser.userName);
      await SharedHelper.set(key: SharedKeys.userEmail, value: fetchedUser.useEmail);
      await SharedHelper.set(key: SharedKeys.userPhone, value: fetchedUser.usePhoneNumber);
      await SharedHelper.set(key: SharedKeys.userImage, value: fetchedUser.useImage);
      await SharedHelper.set(key: SharedKeys.userLocationName, value: fetchedUser.useLocation);

      // ⃣ طبع للتأكد
      print('Email: ${SharedHelper.get(key: SharedKeys.userEmail)}');
      print('Phone: ${SharedHelper.get(key: SharedKeys.userPhone)}');
      } catch (e) {
      print(e.toString());
    }
  }

  Future<void> resetPassword() async {
    emit(ResetPassLoadState());
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final userDoc = await FirebaseFirestore.instance
          .collection(FirebaseKeys.users)
          .doc(uid)
          .get();
      final email = userDoc.data()!['email'];
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email:email,
      );
        print('email:$email');
      emit(ResetPassSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(ResetPassErorrState(e.message.toString()??'حدث خطا'));
    }
  }

  Future<void> signOut(BuildContext context) async {
    emit(UserLoadingLogOutState());

    try {
      // Firebase
      await FirebaseAuth.instance.signOut();

      // Google
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      // Clear local storage
      await SharedHelper.clear();

      emit(UserLogOUtState());

      if (!context.mounted) return;
      // Navigate to login screen and remove all previous routes
      AppNavigation.pushAndRemove(context, SignInView());
    } catch (e) {
      emit(UserLogOUtErorrState("حدث خطأ أثناء تسجيل الخروج"));
    }
  }

  File? userImage;
  String? selectedCategory;
  final picker =ImagePicker();
  userPicImage()async{
    final pickFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickFile !=null){
      userImage = File(pickFile.path);
    }
    emit(UserPickImageState());
  }

// ===================== Share, Comment, MyComments =====================
// دي ممكن تتحكم فيها على حسب تصميمك
// مثال: MyComments ممكن ترجع Comments collection filtered by userId

// ===================== App Info =====================
// aboutUs, reportIssue, faq, privacyPolicy, termsAndConditions
// دي ممكن تترجع كـ String ثابت أو من Firestore
  }


