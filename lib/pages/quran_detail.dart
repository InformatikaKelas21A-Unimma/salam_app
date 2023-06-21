import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:salam_app/models/ayat.dart';
import 'package:salam_app/models/surah.dart';

class QuranDetailPage extends StatelessWidget {
  final int noSurat;

  QuranDetailPage({Key? key, required this.noSurat}) : super(key: key);

  Future<Surah> _getDetailSurah() async {
    var data = await Dio().get("https://equran.id/api/surat/$noSurat");
    return Surah.fromJson(json.decode(data.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Surah>(
      future: _getDetailSurah(),
      initialData: null,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFF29F5CC),
          );
        }
        Surah? surah = snapshot.data!;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _appBar(context: context, surah: surah),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: _details(surah: surah),
              )
            ],
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                child: ListView.separated(
                  // tambahkan controller scroll
                  itemBuilder: (context, index) => _ayatitem(
                      ayat: surah.ayat!
                          .elementAt(index + (noSurat == 1 ? 1 : 0))),
                  separatorBuilder: (context, index) => Container(),
                  itemCount: surah.jumlahAyat + (noSurat == 1 ? -1 : 0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _ayatitem({required Ayat ayat}) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 500,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      ayat.ar,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      "assets/frame.png",
                      width: 30, // Ukuran gambar
                      height: 30,
                      alignment: Alignment.centerLeft,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "${ayat.nomor}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    ayat.idn,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
            ),
          ],
        ),
      );

  Widget _details({required Surah surah}) => Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 3), // mengatur offset bayangan
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/bg_quran.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Image(
                                  image: AssetImage("assets/star.png"),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${surah.nomor}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              surah.nama,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              width: 300,
                              child: Row(
                                children: [
                                  Text(
                                    surah.namaLatin,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    surah.arti,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                              color: Colors.white,
                            ),
                            Container(
                              width: 300,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    surah.tempatTurun.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${surah.jumlahAyat} Ayat",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [Image.asset("assets/bismillah.png")],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  AppBar _appBar({required BuildContext context, required Surah surah}) =>
      AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back),
            ),
            const SizedBox(
              width: 10,
            ),
            Image(
              image: AssetImage("assets/salam_logo.png"),
              width: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Al Quran",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                // Pass the BuildContext
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
      );
}
