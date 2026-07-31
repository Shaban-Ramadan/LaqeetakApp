import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/notivication_model.dart';
import 'notivication_states.dart';


class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  static NotificationCubit get(context) => BlocProvider.of<NotificationCubit>(context);
  final CollectionReference notificationCollection =
  FirebaseFirestore.instance.collection('notification');

  void fetchNotifications() async {
    emit(NotificationLoading());
    try {
      final snapshot = await notificationCollection.get();
      final notifications = snapshot.docs.map((doc) => NotificationModel.fromJos(doc)).toList();
      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> addNotification(NotificationModel notification) async {
    try {
      await notificationCollection.add(notification.toJos());
      fetchNotifications();
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> updateNotification(NotificationModel notification) async {
    try {
      await notificationCollection.doc(notification.notificationId).update(notification.toJos());
      fetchNotifications();
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await notificationCollection.doc(notificationId).delete();
      fetchNotifications();
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}
