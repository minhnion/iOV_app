import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/build_profile_item/build_profile_item.dart';
import '../../widgets/menu_tab/menu_tab.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String userName;
  late String fullName;
  late String roleName;
  late String phoneNumber;
  late String address;
  late String email;
  late String gender;
  late String dateOfBirth;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInformation();
  }
  Future<void> getInformation () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName')??'';
    fullName = prefs.getString('fullName')??'';
    roleName = prefs.getString('roleName')??'';
    phoneNumber = prefs.getString('phoneNumber')??'';
    address = prefs.getString('address')??'';
    email = prefs.getString('email')??'';
    gender = prefs.getString('gender')??'';
    dateOfBirth = prefs.getString('dateOfBirth')??'';
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(193, 234, 193, 100),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      drawer: MenuTab(selectedMenu: "Profile", onLanguageChanged: () {
        setState(() {

        });
      },),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    BuildProfileItem(label: "Tên người dùng", value: userName),
                    BuildProfileItem(label: "Tên thật", value: fullName),
                    BuildProfileItem(label: "Biệt danh", value: "N/A"),
                    BuildProfileItem(label: "Chức vụ", value: roleName),
                    BuildProfileItem(
                        label: "Số điện thoại", value: phoneNumber),
                    BuildProfileItem(
                        label: "Số điện thoại dự phòng", value: "N/A"),
                    BuildProfileItem(label: "Email", value: email),
                  ],
                ),
              ),
            ),
    );
  }
}