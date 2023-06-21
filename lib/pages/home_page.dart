import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:salam_app/pages/compass.dart';
import 'package:salam_app/pages/user.dart';
import 'package:salam_app/widgets/notifier.dart';
import 'package:salam_app/widgets/user_post.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> users = [
    'Anisa_Saputri',
    'Hasanalhadar',
    'Suryononew',
    'Ahmad_Ngawiji',
    'Burhan_Amali',
    'NopalAditya25',
    'Umar_bin_Hamdan',
    'AmirSulaiman01',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60, // Sesuaikan dengan tinggi gambar latar belakang
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg_salam.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Row(
          children: [
            Container(
              child: Image.asset(
                'assets/salam_home.png',
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Icon(
            Icons.notifications_active_outlined,
            size: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Compass()),
                );
              },
              icon: Icon(Icons.explore_outlined),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserPage(),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?sta'),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PrayNotifier();
                    },
                    itemCount: 1, // Hanya satu item
                  ),
                  const Divider(
                    height: 1,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return UserPost(name: users[index]);
                    },
                    itemCount: users.length,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
