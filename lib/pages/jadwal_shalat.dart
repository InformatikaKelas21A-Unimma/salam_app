import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PrayerTimePage extends StatefulWidget {
  @override
  _PrayerTimePageState createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage> {
  String location = 'Magelang'; // Ubah lokasi sesuai kebutuhan
  Map<String, dynamic> prayerTimes = {};

  TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPrayerTimes();
  }

  Future<void> getPrayerTimes() async {
    final response = await http.get(Uri.parse(
        'https://api.aladhan.com/v1/timingsByCity?city=$location&country=Indonesia&method=8'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        prayerTimes = data['data']['timings'];
      });
    }
  }

  void updatePrayerTimes() {
    setState(() {
      location = _locationController.text;
    });
    getPrayerTimes();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color(0xFF29F5CC),
        elevation: 0,
        title: Row(
          children: [
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
                  'Jadwal Shalat',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: 'Cari Kota...',
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: updatePrayerTimes,
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            if (prayerTimes.isNotEmpty)
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 395,
                        height: 360,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 60, left: 10, right: 10),
                          child: Column(
                            children: [
                              Container(
                                width: 375,
                                height: 300,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        children: [
                                          buildPrayerTimeRow(
                                              'Imsak', prayerTimes['Imsak']),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          buildPrayerTimeRow(
                                              'Subuh', prayerTimes['Fajr']),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          buildPrayerTimeRow(
                                              'Dhuhr', prayerTimes['Dhuhr']),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          buildPrayerTimeRow(
                                              'Ashar', prayerTimes['Asr']),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          buildPrayerTimeRow('Maghrib',
                                              prayerTimes['Maghrib']),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          buildPrayerTimeRow(
                                              'Isya', prayerTimes['Isha']),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: 395,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFF29F5CC),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 16),
                              Icon(Icons.location_on_outlined),
                              SizedBox(width: 10),
                              Text(
                                'Kota $location dan sekitarnya',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            if (prayerTimes.isEmpty) CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  launchMaps();
                },
                child: Stack(
                  children: [
                    Container(
                      width: 395,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/map.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      child: Container(
                        width: 395,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.location_on,
                                size: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Masjid Terdekat",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "Masjid Agung Magelang",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget buildPrayerTimeRow(String prayerName, String prayerTime) {
    final time =
        DateFormat.jm().format(DateTime.parse('2023-06-17 $prayerTime'));
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            prayerName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Spacer(),
          Text(time),
        ],
      ),
    );
  }

  void launchMaps() async {
    // Cek apakah aplikasi Google Maps sudah terpasang
    if (await canLaunch('comgooglemaps://')) {
      // Jika terpasang, buka aplikasi Google Maps
      await launch('comgooglemaps://?q=masjid');
    } else {
      // Jika tidak terpasang, buka Google Maps melalui browser
      String url =
          'https://www.google.com/maps/search/?api=1&query=masjid+terdekat+kota+magelang';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Tidak dapat membuka Google Maps';
      }
    }
  }
}
