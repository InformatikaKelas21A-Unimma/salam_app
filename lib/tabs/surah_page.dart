import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:salam_app/models/surah.dart';
import 'package:salam_app/pages/quran_detail.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  Future<List<Surah>> _getSurahList() async {
    String data = await rootBundle.loadString('assets/datas/list-surah.json');
    return surahFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
        future: _getSurahList(),
        initialData: [],
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return ListView.separated(
            itemBuilder: (context, index) => _surahitem(
                context: context, surah: snapshot.data!.elementAt(index)),
            separatorBuilder: (context, index) => Divider(
              color: Colors.black54,
              height: 0,
            ),
            itemCount: snapshot.data!.length,
          );
        }));
  }

  Widget _surahitem({required Surah surah, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => QuranDetailPage(
                    noSurat: surah.nomor,
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Stack(
                children: [
                  Image.asset('assets/star.png'),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: Text(
                        "${surah.nomor}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.namaLatin,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        surah.tempatTurun.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${surah.jumlahAyat} Ayat",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              )),
              Text(
                surah.nama,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 31, 159, 134)),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_rounded,
                    color: Color.fromARGB(255, 31, 159, 134),
                  ))
            ],
          ),
        ),
      );
}
