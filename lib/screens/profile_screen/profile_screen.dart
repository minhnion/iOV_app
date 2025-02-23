import 'package:flutter/material.dart';

import '../../widgets/build_profile_item/build_profile_item.dart';
import '../../widgets/menu_tab/menu_tab.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

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
      drawer: const MenuTab(selectedMenu: "Profile"),
      body: Container(
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
              const BuildProfileItem(label: "Tên người dùng", value: "quynhlx"),
              const BuildProfileItem(label: "Tên thật", value: "quynhlx"),
              const BuildProfileItem(label: "Biệt danh", value: "N/A"),
              const BuildProfileItem(label: "Chức vụ", value: "TECHNICIAN"),
              const BuildProfileItem(label: "Số điện thoại", value: "0912345678"),
              const BuildProfileItem(label: "Số điện thoại dự phòng", value: "N/A"),
              const BuildProfileItem(label: "Email", value: "quynhlx@gmail.com"),
            ],
          ),
        ),
      ),
    );
  }
}