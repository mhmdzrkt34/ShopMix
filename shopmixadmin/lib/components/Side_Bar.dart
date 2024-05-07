import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  late BuildContext currentcontext;

  SideBar(this.currentcontext);

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(currentcontext)?.settings.name;

    return Drawer(
      backgroundColor: Colors.blue,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          useracount(),
          if (currentRoute != '/')
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
          if (currentRoute != '/AllProducts')
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
          if (currentRoute != '/AddProduct')
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
          if (currentRoute != '/AddCategory')
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
          if (currentRoute != '/Orders')
            ListTile(
              leading: const Icon(
                Icons.insert_chart_outlined_rounded,
                color: Colors.white,
              ),
              title: const Text(
                "Orders",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(currentcontext, "/Orders");
              },
            ),
          if (currentRoute != '/users')
            ListTile(
              leading: const Icon(
                Icons.comment,
                color: Colors.white,
              ),
              title: const Text(
                "Chat",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(currentcontext, "/users");
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
            errorBuilder: (context, url, error) => Container(
              width: 160,
              height: 120,
              color: Colors.grey,
              child: const Icon(
                Icons.error,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
