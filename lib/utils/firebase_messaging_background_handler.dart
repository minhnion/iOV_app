import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:iov_app/services/notification_service.dart';
import 'package:iov_app/firebase_options.dart';

// force to not eliminate
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("--- Handling a background message ---");
  print("Message ID: ${message.messageId}");
  print("Message data: ${message.data}");
  if (message.notification != null) {
    print("Notification Title: ${message.notification!.title}");
    print("Notification Body: ${message.notification!.body}");
  }

  await NotificationService.instance.setupFlutterNotifications();

  await NotificationService.instance.showNotification(message);

  print("--- Background message handled ---");
}