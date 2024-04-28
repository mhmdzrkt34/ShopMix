import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SideBar extends StatelessWidget {
  late BuildContext currentcontext;

  SideBar(this.currentcontext);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          useracount(),
          ListTile(
            leading: const Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
            title: const Text(
              "Dashboard",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(currentcontext, "/");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.format_align_right_outlined,
              color: Colors.white,
            ),
            title: const Text(
              "All Products",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(currentcontext, "/AllProducts");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.add_to_photos_rounded,
              color: Colors.white,
            ),
            title: const Text(
              "ADD Products",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(currentcontext, "/AddProduct");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.add_to_photos_rounded,
              color: Colors.white,
            ),
            title: const Text(
              "ADD Category",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(currentcontext, "/AddCategory");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: const Text(
              "Setting",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(currentcontext, "/Setting");
            },
          ),
        ],
      ),
    );
  }

  Widget useracount() {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(38, 102, 250, 0),
      ),
      accountName: Text("Admin"),
      accountEmail: Text("Admin@email.com"),
      currentAccountPicture: CircleAvatar(
        child: ClipOval(
          child: Image.network(
            "https://www.findabusinessthat.com/blog/wp-content/uploads/2022/01/e35a25d810b79737083717ebd8ec3d10.jpg",
            width: 90,
            height: 90,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
