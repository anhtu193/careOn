import 'package:care_on/models/reminder_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:math';

class Noti {
  FlutterLocalNotificationsPlugin localNotificationService;

  Noti(this.localNotificationService);

  Future initialize() async {
    tz.initializeTimeZones();
    await _configureLocalTimeZone();
    var androidInitialize =
        new AndroidInitializationSettings('@drawable/ic_stat_ic_launcher');
    var iOSInitialize = new IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    await localNotificationService.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  Future<void> _configureLocalTimeZone() async {
    tz.Location? location = tz.getLocation('Asia/Ho_Chi_Minh');
    tz.setLocalLocation(location);
  }

  int generateRandomIntId() {
    Random random = Random();
    int min = 100000;
    int max = 999999;

    return min + random.nextInt(max - min);
  }

  tz.TZDateTime _nextInstanceOfDay(
    tz.TZDateTime now,
    int dayIndex,
    String timeStart,
    bool onRepeat,
  ) {
    final List<String> timeSplit = timeStart.split(':');
    final int hour = int.parse(timeSplit[0]);
    final int minute = int.parse(timeSplit[1]);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (onRepeat) {
      while (scheduledDate.weekday != dayIndex) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      // Nếu ngày đã qua, thì cộng thêm 7 ngày để lặp lại vào tuần kế tiếp
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 7));
      }
    } else {
      while (scheduledDate.weekday != dayIndex || scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
    }

    return scheduledDate;
  }

  void scheduleNotification(Reminder reminder) async {
    if (reminder.needAlarm) {
      List<int> daysOfWeek = [];
      if (reminder.reminderOn.contains('Th 2')) daysOfWeek.add(1);
      if (reminder.reminderOn.contains('Th 3')) daysOfWeek.add(2);
      if (reminder.reminderOn.contains('Th 4')) daysOfWeek.add(3);
      if (reminder.reminderOn.contains('Th 5')) daysOfWeek.add(4);
      if (reminder.reminderOn.contains('Th 6')) daysOfWeek.add(5);
      if (reminder.reminderOn.contains('Th 7')) daysOfWeek.add(6);
      if (reminder.reminderOn.contains('CN')) daysOfWeek.add(7);

      for (int dayIndex in daysOfWeek) {
        tz.TZDateTime scheduledTime = _nextInstanceOfDay(
            tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1)),
            dayIndex,
            reminder.timeStart,
            reminder.onRepeat);

        await localNotificationService.zonedSchedule(
          generateRandomIntId(),
          reminder.title,
          reminder.description == ""
              ? "Đến giờ cho hoạt động " + reminder.title + " rồi!"
              : reminder.description,
          scheduledTime,
          const NotificationDetails(
            android: AndroidNotificationDetails('channel_id', 'channel_name',
                channelDescription: 'description',
                icon: "@drawable/ic_stat_ic_launcher",
                importance: Importance.max,
                priority: Priority.max,
                playSound: true),
          ),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );

        print("Đã đặt thông báo cho hoạt động " +
            reminder.title +
            " lúc " +
            reminder.timeStart +
            " cho Thứ " +
            (dayIndex + 1).toString());
      }
    }
  }

  Future<NotificationDetails> _noticationDetail() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'description',
            icon: "@mipmap/ic_launcher",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();
    return const NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
  }

  Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    final details = await _noticationDetail();
    await localNotificationService.show(id, title, body, details);
  }

  Future<void> showScheduledNotification(
      {required int id,
      required String title,
      required String body,
      required int seconds}) async {
    final details = await _noticationDetail();
    await localNotificationService.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
            DateTime.now().add(Duration(seconds: seconds)), tz.local),
        details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print("id $id");
  }

  static void _onSelectNotification(String? payload) {
    print("payload $payload");
  }
}
