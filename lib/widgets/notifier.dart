import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:salam_app/pages/jadwal_shalat.dart';
import 'package:salam_app/widgets/hijriyah.dart';
import 'package:salam_app/widgets/kalender.dart';

class PrayNotifier extends StatelessWidget {
  const PrayNotifier({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_jad_sh.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrayerTimePage()),
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '11.40',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Waktu Dhuhr'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          RichText(
                            text: const TextSpan(
                              text: 'Kota Magelang dan sekitarnya',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16, top: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CalendarPage()),
                          );
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                              size: 50,
                            ),
                            Text(
                              'Hijriyah',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
