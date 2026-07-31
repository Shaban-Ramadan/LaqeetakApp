import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future<void> showNotification() async {
    var androidDetails = const AndroidNotificationDetails(
      "test_channel",
      "Test Notification",
      importance: Importance.high,
      priority: Priority.high,
      fullScreenIntent: true,
    );

    var notificationDetails = NotificationDetails(android: androidDetails);
    await _notification.show(0, "اختبار فوري", "هذا إشعار تجريبي", notificationDetails);
    print("Immediate notification triggered");
  }

  static Future<void> requestPermissions() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }
    if (await Permission.ignoreBatteryOptimizations.isDenied) {
      print("Opening Battery Optimization settings...");
      await Permission.ignoreBatteryOptimizations.request();
      if (await Permission.ignoreBatteryOptimizations.isDenied) {
        print("تحذير: لازم تسمح للتطبيق 'Mag' بـ 'بدون قيود' في إعدادات البطارية عشان الإشعارات المجدولة تشتغل!");
      }
    }

    print("Notification: ${await Permission.notification.status}");
    print("Exact Alarm: ${await Permission.scheduleExactAlarm.status}");
    print("Battery Optimization: ${await Permission.ignoreBatteryOptimizations.status}");
  }

  static Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'important_notification',
      'My Channel',
      description: 'قناة لإشعارات مهمة',
      importance: Importance.max,
    );

    await _notification
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    print("Channel created successfully");

    await _notification.initialize(const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    ));

    await requestPermissions();
  }

  static Future<void> scheduleNotification(String title, String body, int userDayInput) async {
    var androidDetails = const AndroidNotificationDetails(
      "important_notification",
      "My Channel",
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true,
    );

    var notificationDetails = NotificationDetails(android: androidDetails);
    int id = Random().nextInt(100000);
    var scheduledTime = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));

    print("Current time: ${tz.TZDateTime.now(tz.local)}");
    print("Scheduled at: $scheduledTime");
    print("Battery Optimization in schedule: ${await Permission.ignoreBatteryOptimizations.status}");

    if (await Permission.ignoreBatteryOptimizations.isDenied) {
      print("الإشعار المجدول مش هيظهر لأن تحسين البطارية مفعل. روح للإعدادات > البطارية > إدارة استهلاك التطبيقات > Mag > بدون قيود");
    }

    await _notification.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    print("Notification scheduled with ID: $id");
  }

  static void cancelAllNotification() {
    _notification.cancelAll();
    print("All notifications canceled");
  }
}
