import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  String _hijriDate = '';
  String _hijriDay = '';
  String _hijriMonth = '';
  String _hijriYear = '';
  bool _isLoading = true;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  String location = 'Magelang'; // Ubah lokasi sesuai kebutuhan
  Map<String, dynamic> prayerTimes = {};

  TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPrayerTimes();
    fetchHijriDate();
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

  Future<void> fetchHijriDate() async {
    final response =
        await http.get(Uri.parse('http://api.aladhan.com/v1/gToH'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final hijriDay = data['data']['hijri']['day'];
      final hijriMonth = data['data']['hijri']['month']['en'];
      final hijriYear = data['data']['hijri']['year'];

      setState(() {
        _hijriDay = hijriDay;
        _hijriMonth = hijriMonth;
        _hijriYear = hijriYear;
        _isLoading = false;
      });
    } else {
      setState(() {
        _hijriDay = '';
        _hijriMonth = '';
        _hijriYear = '';
        _isLoading = false;
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
                  'Kalender',
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
            TableCalendar(
              firstDay: DateTime.utc(2021, 1, 1),
              lastDay: DateTime.utc(2023, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            Container(
              width: 419,
              height: 419,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 10,
                    child: Container(
                      width: 390,
                      height: 419,
                      decoration: BoxDecoration(
                        color: Color(0xFF29F5CC),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      width: 390,
                      height: 415,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          if (prayerTimes != null && prayerTimes.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.sunny,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Jadwal Shalat",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        _hijriDay,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        _hijriMonth,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        _hijriYear,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Hari ini",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
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
                                  buildPrayerTimeRow(
                                      'Maghrib', prayerTimes['Maghrib']),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  buildPrayerTimeRow(
                                      'Isya', prayerTimes['Isha']),
                                ],
                              ),
                            ),
                          if (prayerTimes == null || prayerTimes.isEmpty)
                            CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPrayerTimeRow(String prayerName, String prayerTime) {
    final time =
        DateFormat.jm().format(DateTime.parse('2023-06-10 $prayerTime'));
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            prayerName,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
          Spacer(),
          Text(
            time,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
