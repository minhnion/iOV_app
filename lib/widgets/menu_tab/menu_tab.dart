import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iov_app/screens/installation_screen/installation_screen.dart';
import 'package:iov_app/screens/kpi_screen/kpi_screen.dart';
import 'package:iov_app/screens/login_screen/login_screen.dart';
import 'package:iov_app/screens/profile_screen/profile_screen.dart';
import 'package:iov_app/services/auth_service.dart';
import 'package:iov_app/utils/change_language.dart';
import 'package:iov_app/widgets/confirm_inform/confirm_inform.dart';

class MenuTab extends StatefulWidget {
  const MenuTab({super.key, required this.selectedMenu, required this.onLanguageChanged});

  final String selectedMenu;
  final VoidCallback onLanguageChanged;

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  late String _selectedMenu;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedMenu = widget.selectedMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String currentLanguageDisplay = getCurrentLanguageDisplay(context);
    return Drawer(
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const InstallationsScreen()));
            },
            child: Container(
              color: _selectedMenu == 'Installations'
                  ? Colors.green.withOpacity(0.3)
                  : null,
              child: ListTile(
                leading: const Icon(Icons.content_paste,
                    color: Colors.deepPurple),
                title: Text(
                  'Danh sách lắp đặt',
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const KpiScreen()));
            },
            child: Container(
              color:
                  _selectedMenu == 'Kpi' ? Colors.green.withOpacity(0.3) : null,
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
                'quynhlx@gmail.com',
                style: TextStyle(
                  fontWeight: _selectedMenu == 'Profile'
                      ? FontWeight.bold
                      : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: () {
                setState(() {
                  _selectedMenu = "Profile";
                });
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ProfileScreen()));
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
                'Ngôn ngữ',
                style: TextStyle(
                  fontWeight: _selectedMenu == 'Language'
                      ? FontWeight.bold
                      : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              trailing: DropdownButton<String>(
                value: currentLanguageDisplay,
                underline: Container(), // Bỏ đường gạch chân
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: _changeLanguage,
                items: getLanguageItems(context)
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
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
                    return  ConfirmInform(
                      title: 'Xác nhận đăng xuất',
                      content: 'Bạn có muốn đăng xuất không?',
                      onConfirm: handleLogout,
                    );
                  }
              );
            },
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title: Text(
                'Đăng xuất',
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
