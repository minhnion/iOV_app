import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iov_app/screens/installation_screen/installation_screen.dart';
import 'package:iov_app/screens/kpi_screen/kpi_screen.dart';
import 'package:iov_app/screens/login_screen/login_screen.dart';
import 'package:iov_app/screens/profile_screen/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // Cấu hình đa ngôn ngữ
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('vi', 'VN'), // Tiếng Việt
        Locale('en', 'US'), // English
      ],
      locale: Locale('vi', 'VN'),
      home: ProfileScreen(),
    );
  }
}
