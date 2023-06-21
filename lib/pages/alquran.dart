import 'package:flutter/material.dart';
import 'package:salam_app/tabs/juz_page.dart';
import 'package:salam_app/tabs/surah_page.dart';

class QuranPage extends StatelessWidget {
  QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        toolbarHeight: 250,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          width: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage('assets/bg_quran.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Image.asset(
                    'assets/alquran.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Alqur'anul karim",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Indonesia",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            Text(
                              "القرآن الكريم",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Arab",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'اَلسَّلَامُ عَلَيْكُمْ وَرَحْمَةُ اللهِ وَبَرَكَا تُهُ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                pinned: true,
                elevation: 0,
                backgroundColor: Color.fromARGB(255, 250, 250, 250),
                automaticallyImplyLeading: false,
                shape: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: _tab(),
                ),
              )
            ],
            body: const TabBarView(
              children: [SurahTab(), JuzTab()],
            ),
          ),
        ),
      ),
    );
  }

  TabBar _tab() {
    return TabBar(
      unselectedLabelColor: Color.fromARGB(255, 163, 163, 163),
      labelColor: Color.fromARGB(255, 29, 169, 141),
      indicatorColor: Color(0xFF29F5CC),
      indicatorWeight: 4,
      tabs: [
        _tabitem(label: "Surah"),
        _tabitem(label: "Juz"),
      ],
    );
  }

  Tab _tabitem({required String label}) {
    return Tab(
      child: Text(label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}
