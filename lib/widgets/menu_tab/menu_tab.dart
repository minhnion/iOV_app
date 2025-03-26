import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iov_app/screens/installation_screen/installation_screen.dart';
import 'package:iov_app/screens/kpi_screen/kpi_screen.dart';
import 'package:iov_app/screens/login_screen/login_screen.dart';
import 'package:iov_app/screens/profile_screen/profile_screen.dart';
import 'package:iov_app/services/auth_service.dart';
import 'package:iov_app/utils/change_language.dart';
import 'package:iov_app/widgets/confirm_inform/confirm_inform.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuTab extends StatefulWidget {
  const MenuTab({super.key, required this.selectedMenu, required this.onLanguageChanged});

  final String selectedMenu;
  final VoidCallback onLanguageChanged;

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  late String _selectedMenu;
  late String email;
  bool isLoading = true;
  void _changeLanguage(String? selectedLanguage) {
    changeLanguage(context, selectedLanguage, () {
      setState(() {
      });
      widget.onLanguageChanged();
    });
  }

  Future<void> handleLogout() async{
    try{
      await AuthService().logout();
      if(mounted){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
      }
    }catch(e){
      print('Error: $e');
    }
  }
  Future<void> getEmail () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email')??'N/A';
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedMenu = widget.selectedMenu;
    });
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    final String currentLanguageDisplay = getCurrentLanguageDisplay(context);
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
            color: Colors.black,
          ))
        : Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 240, 2, 100),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'iOV',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Onelink',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedMenu = 'Installations';
                    });
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InstallationsScreen()));
                  },
                  child: Container(
                    color: _selectedMenu == 'Installations'
                        ? Colors.green.withOpacity(0.3)
                        : null,
                    child: ListTile(
                      leading: const Icon(Icons.content_paste,
                          color: Colors.deepPurple),
                      title: Text(
                        'installations'.tr(),
                        style: TextStyle(
                          fontWeight: _selectedMenu == 'Installations'
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedMenu = 'Kpi';
                    });
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KpiScreen()));
                  },
                  child: Container(
                    color: _selectedMenu == 'Kpi'
                        ? Colors.green.withOpacity(0.3)
                        : null,
                    child: ListTile(
                      leading: const Icon(Icons.stacked_bar_chart),
                      title: Text(
                        'Kpi',
                        style: TextStyle(
                          fontWeight: _selectedMenu == 'Kpi'
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  color: _selectedMenu == 'Profile'
                      ? Colors.green.withOpacity(0.3)
                      : null,
                  child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: Color.fromRGBO(23, 150, 68, 100),
                        child: Icon(Icons.person, color: Colors.white)),
                    title: Text(
                      email,
                      style: TextStyle(
                        fontWeight: _selectedMenu == 'Profile'
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    trailing: const Icon(Icons.arrow_drop_down),
                    onTap: () {
                      setState(() {
                        _selectedMenu = "Profile";
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                    },
                  ),
                ),
                Container(
                  color: _selectedMenu == 'Language'
                      ? Colors.green.withOpacity(0.3)
                      : null,
                  child: ListTile(
                    leading: const Icon(Icons.language, color: Colors.blue),
                    title: Text(
                      'language'.tr(),
                      style: TextStyle(
                        fontWeight: _selectedMenu == 'Language'
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    trailing: DropdownButton<String>(
                      value: currentLanguageDisplay,
                      underline: Container(),
                      // Bỏ đường gạch chân
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: _changeLanguage,
                      items: getLanguageItems(context)
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value.tr(),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedMenu = "Language";
                      });
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmInform(
                            title: 'logout_confirmation_title'.tr(),
                            content: 'logout_confirmation_message'.tr(),
                            onConfirm: handleLogout,
                          );
                        });
                  },
                  child: ListTile(
                    leading: const Icon(Icons.logout, color: Colors.black),
                    title: Text(
                      'logout'.tr(),
                      style: TextStyle(
                        fontWeight: _selectedMenu == 'SignOut'
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
