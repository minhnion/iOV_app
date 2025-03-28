import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:iov_app/main.dart';
import 'package:iov_app/screens/login_screen/login_screen.dart';


class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    await setupFlutterNotifications();

    await _requestPermission();

    await _setupMessageHandlers();

    final token = await _messaging.getToken();
    print('FCM Token: $token');

  }

  Future<void> _requestPermission() async {
    try {
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
        announcement: false,
        carPlay: false,
        criticalAlert: false,
      );
      print('Permission status: ${settings.authorizationStatus}');
    } catch (e) {
      print('Error requesting permission: $e');
    }
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }
    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    // iOS setup
    const initializationSettingsDarwin = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');


    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse, // Xử lý khi nhấn thông báo (cả local và push đã hiển thị qua local)
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    _isFlutterLocalNotificationsInitialized = true;
    print('Flutter Local Notifications Initialized.'); // Thêm log
  }

  // Hàm xử lý khi nhấn vào thông báo
  void _onDidReceiveNotificationResponse(NotificationResponse details) {
    print('Notification Tapped Payload: ${details.payload}');
    // Xử lý dữ liệu từ payload (message.data.toString())
    // Ví dụ: điều hướng màn hình dựa trên payload
    // final data = jsonDecode(details.payload ?? '{}'); // Cần parse nếu payload là JSON string
    // if (data['type'] == 'chat') { ... }

    // Lưu ý: Cần có cách để lấy BuildContext nếu muốn điều hướng từ đây
    // hoặc sử dụng một stream/event bus để thông báo cho UI cập nhật.
  }


  Future<void> showNotification(RemoteMessage message) async {
    if (!_isFlutterLocalNotificationsInitialized) {
      return;
    }

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? ios = message.notification?.apple;

    if (notification != null && (android != null || ios != null)) {
      print('Showing notification: ${notification.title}');
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
            'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    } else {
      print('Notification content is null or platform specific part is missing.');
    }
  }

  Future<void> _setupMessageHandlers() async {
    // foreground message
    FirebaseMessaging.onMessage.listen((message) {
      print('Foreground Message received: ${message.notification?.title}');
      showNotification(message);
    });

    // background message tap handler (Khi app chạy nền)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // terminated message tap handler (Khi app bị tắt)
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      print('Initial Message received: ${initialMessage.notification?.title}');
      _handleMessageOpenedApp(initialMessage);
    }
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    print("Handling message opened app: ${message.data}");
    _navigateBaseOnNotification(message.data.toString());
  }
  
  void _navigateBaseOnNotification(String? payload) {
    if(navigatorKey.currentContext != null) {
      Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false
      );
    }else{
      print('Navigator context is null. Unable to navigate.');
    }
  }
}
