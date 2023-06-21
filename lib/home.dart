import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salam_app/pages/alquran.dart';
import 'package:salam_app/pages/home_page.dart';
import 'package:salam_app/pages/jelajah_page.dart';
import 'package:salam_app/pages/kajian.dart';
import 'package:salam_app/pages/ustadz.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> pages = [
    HomePage(),
    ExplorerPage(),
    QuranPage(),
    KajianPage(),
    UstadzPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
        selectedItemColor: Color(0xFF19F5CC),
        currentIndex: _selectedIndex,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 0 ? Icons.home : Icons.home_outlined),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 1 ? Icons.search : Icons.search_outlined),
            label: 'Jelajah',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 2
                ? Icons.menu_book
                : Icons.menu_book_outlined),
            label: 'Al-Quran',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 3
                ? Icons.mosque_rounded
                : Icons.mosque_outlined),
            label: 'Kajian',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 4
                ? Icons.video_call
                : Icons.video_call_outlined),
            label: 'Ustadz',
          ),
        ],
      ),
    );
  }
}
