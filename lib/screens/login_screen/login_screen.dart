import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iov_app/screens/installation_screen/installation_screen.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    await _authService.registerDevice();

    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    bool success = await _authService.login(username, password);

    setState(() {
      _isLoading = false;
    });
    if (!mounted) return;
    if (success) {
      await _authService.decodeAccessToken();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const InstallationsScreen()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng nhập thất bại, vui lòng thử lại!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 120, 24, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 240, 2, 1.0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                  child: Text(
                    'iOV',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  )),
            ),
            const SizedBox(height: 24),
            Text(
              'welcome_back'.tr(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(21 ,186 , 66, 1.0),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'login_to_account'.tr(),
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(21, 186, 66, 1.0),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'username'.tr(),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'password'.tr(),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(23, 150, 68, 1.0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _handleLogin,
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white) // Hiển thị loading
                    : Text(
                        'login'.tr(),
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
