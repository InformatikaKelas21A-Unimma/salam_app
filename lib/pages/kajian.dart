import 'package:flutter/material.dart';
import 'package:salam_app/tabkajian/adihidayat.dart';
import 'package:salam_app/tabkajian/Islam.dart';
import 'package:salam_app/tabkajian/jedanulis.dart';
import 'package:salam_app/tabkajian/pemudatersesat.dart';
import 'package:salam_app/tabkajian/uas.dart';
import 'package:salam_app/widgets/bubble_story.dart';
import 'package:faker/faker.dart';
import 'package:salam_app/widgets/profil1/1.dart';
import 'package:salam_app/widgets/profil1/2.dart';
import 'package:salam_app/widgets/profil1/3.dart';
import 'package:salam_app/widgets/profil1/4.dart';
import 'package:salam_app/widgets/profil1/5.dart';

class KajianPage extends StatelessWidget {
  KajianPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color(0xFF29F5CC),
        elevation: 0,
        title: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Container(
                  child: Image.asset(
                    'assets/salam_logo.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  'Kajian',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 500,
              height: 45,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(137, 204, 204, 204),
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search_outlined),
                    iconSize: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          // Lakukan sesuatu saat nilai search berubah
                        },
                        onSubmitted: (value) {
                          // Lakukan sesuatu saat search dikirimkan
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: TabViewPage(),
          ),
        ],
      ),
    );
  }
}

class TabViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TabBar(
          isScrollable: true,
          indicatorColor: Colors.greenAccent,
          tabs: [
            Tab(
              child: Column(
                children: [
                  ProfileKajian1(),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  ProfileKajian2(),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  ProfileKajian3(),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  ProfileKajian4(),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  ProfileKajian5(),
                ],
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            Center(
              child: JedaNulis(),
            ),
            Center(
              child: PemudaTersesat(),
            ),
            Center(
              child: AbdulSomad(),
            ),
            Center(
              child: AdiHidayat(),
            ),
            Center(
              child: Islam(),
            ),
          ],
        ),
      ),
    );
  }
}
