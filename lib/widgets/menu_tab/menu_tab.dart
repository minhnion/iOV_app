import 'package:flutter/material.dart';
import 'package:iov_app/screens/installation_screen/installation_screen.dart';
import 'package:iov_app/screens/kpi_screen/kpi_screen.dart';
import 'package:iov_app/screens/profile_screen/profile_screen.dart';
import 'package:iov_app/widgets/confirm_inform/confirm_inform.dart';

class MenuTab extends StatefulWidget {
  const MenuTab({super.key, required this.selectedMenu});

  final String selectedMenu;

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  late String _selectedMenu;

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

          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const ConfirmInform(
                      title: 'Xác nhận đăng xuất',
                      content: 'Bạn có muốn đăng xuất không?',
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
