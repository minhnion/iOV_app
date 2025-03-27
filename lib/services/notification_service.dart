// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:iov_app/screens/login_screen/login_screen.dart';
//
// class NotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   Future<void> init(BuildContext context) async {
//     // Cấu hình Android
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     // Cấu hình iOS
//     const DarwinInitializationSettings initializationSettingsIOS =
//     DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//     );
//
//     // Tổng hợp cấu hình
//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     // Khởi tạo plugin local notifications
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (details) {
//         print('Notification Tapped: ${details.payload}');
//         // Xử lý khi nhấn vào thông báo
//       },
//     );
//
//     // Yêu cầu quyền
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     print('Notification Permission Status: ${settings.authorizationStatus}');
//
//     // Lấy token
//     String? token = await _firebaseMessaging.getToken();
//     print('Firebase Messaging Token: $token');
//
//     // Xử lý thông báo khi ứng dụng đang chạy
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Foreground Message:');
//       _showNotification(message);
//     });
//
//     // Xử lý khi mở app từ thông báo
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Message Opened App:');
//       _handleNotificationTap(context, message);
//     });
//
//     // Xử lý thông báo ban đầu khi mở app
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if (message != null) {
//         print('Initial Message:');
//         _handleNotificationTap(context, message);
//       }
//     });
//   }
//
//   Future<void> _showNotification(RemoteMessage message) async {
//     // Cấu hình chi tiết thông báo
//     AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'channel_id',
//       'channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     NotificationDetails platformDetails = NotificationDetails(
//       android: androidDetails,
//       iOS: const DarwinNotificationDetails(),
//     );
//
//     // Hiển thị thông báo
//     await _flutterLocalNotificationsPlugin.show(
//       0, // ID thông báo
//       message.notification?.title ?? 'Thông báo',
//       message.notification?.body ?? 'Bạn có thông báo mới',
//       platformDetails,
//       payload: message.data.toString(),
//     );
//   }
//
//   void _handleNotificationTap(BuildContext context, RemoteMessage message) {
//     // Điều hướng đến màn hình chi tiết
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => const LoginScreen(
//
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../firebase_options.dart';

class NotificationService {
  // ... (singleton instance, _messaging, _localNotifications, _isFlutterLocalNotificationsInitialized)
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    // --- Quan trọng: Gọi setupFlutterNotifications TRƯỚC ---
    // Đảm bảo local notifications sẵn sàng cho cả foreground và background
    await setupFlutterNotifications();

    // Request permission
    await _requestPermission();

    // Setup message handlers (sau khi local notifications đã sẵn sàng)
    await _setupMessageHandlers();

    // Get FCM token
    final token = await _messaging.getToken();
    print('FCM Token: $token');

  }

  Future<void> _requestPermission() async {
    try { // Thêm try-catch để xem có lỗi cụ thể hơn không
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
      // Có thể bạn muốn xử lý lỗi này (ví dụ: thông báo cho người dùng)
    }
  }

  Future<void> setupFlutterNotifications() async {
    // --- Di chuyển lên đầu initialize() ---
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }
    print('Setting up Flutter Local Notifications...'); // Thêm log

    // android setup
    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    // iOS setup (đảm bảo bạn cũng cấu hình đúng trong AppDelegate.swift/m)
    const initializationSettingsDarwin = DarwinInitializationSettings(
      requestSoundPermission: true, // Yêu cầu quyền ngay khi khởi tạo
      requestBadgePermission: true,
      requestAlertPermission: true,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification, // Cần nếu target iOS < 10
    );


    // android init settings
    const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');


    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin, // Thêm cấu hình iOS vào đây
    );


    // flutter notification setup
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse, // Xử lý khi nhấn thông báo (cả local và push đã hiển thị qua local)
    );

    // Tạo kênh cho Android
    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Cấu hình thêm cho iOS foreground notification (nếu cần hiển thị khi app đang mở)
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );


    _isFlutterLocalNotificationsInitialized = true;
    print('Flutter Local Notifications Initialized.'); // Thêm log
  }

  // Hàm xử lý khi nhấn vào thông báo (được gọi bởi local_notifications)
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
    // Đảm bảo đã initialize trước khi hiển thị
    if (!_isFlutterLocalNotificationsInitialized) {
      print('Local notifications not initialized yet. Skipping showNotification.');
      // Có thể gọi lại setupFlutterNotifications ở đây nếu thực sự cần, nhưng nên tránh
      // await setupFlutterNotifications();
      return;
    }

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? ios = message.notification?.apple; // Lấy thông tin iOS

    // Chỉ hiển thị nếu có nội dung thông báo
    if (notification != null && (android != null || ios != null)) { // Kiểm tra cả android và ios
      print('Showing notification: ${notification.title}'); // Thêm log
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails( // Sử dụng channel đã tạo
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
            'This channel is used for important notifications.',
            importance: Importance.high, // Đảm bảo giống channel
            priority: Priority.high,
            icon: '@mipmap/ic_launcher', // Icon phải tồn tại
          ),
          iOS: DarwinNotificationDetails( // Cấu hình hiển thị cho iOS
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        // payload chứa dữ liệu để xử lý khi nhấn vào thông báo
        payload: message.data.toString(), // Chuyển data thành string để dùng làm payload
      );
    } else {
      print('Notification content is null or platform specific part is missing.');
    }
  }

  Future<void> _setupMessageHandlers() async {
    // foreground message
    FirebaseMessaging.onMessage.listen((message) {
      print('Foreground Message received: ${message.notification?.title}');
      // Gọi showNotification để hiển thị bằng local_notifications
      showNotification(message);
    });

    // background message tap handler (Khi app chạy nền)
    // Cần 1 cơ chế để điều hướng từ đây (ví dụ: GlobalKey<NavigatorState>, Stream)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // terminated message tap handler (Khi app bị tắt)
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      print('Initial Message received: ${initialMessage.notification?.title}');
      _handleMessageOpenedApp(initialMessage);
    }
  }

  // Hàm dùng chung để xử lý khi nhấn thông báo từ nền/terminated
  void _handleMessageOpenedApp(RemoteMessage message) {
    print("Handling message opened app: ${message.data}");
    // Xử lý dựa vào message.data
    // Ví dụ: điều hướng tới màn hình cụ thể
    if (message.data['type'] == 'chat') {
      // Điều hướng tới màn hình chat
      // Cần context hoặc GlobalKey<NavigatorState> để điều hướng ở đây
      // Navigator.of(context)... sẽ không hoạt động trực tiếp
      print("Navigate to chat screen based on data: ${message.data}");
    } else {
      print("Navigate to default screen or handle other types based on data: ${message.data}");
    }
    // Lưu ý: Hàm này chạy khi app được mở TỪ thông báo,
    // bạn cần cơ chế điều hướng phù hợp không phụ thuộc vào context hiện tại.
  }
}
