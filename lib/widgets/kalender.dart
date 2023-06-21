import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HijriCalendarPage extends StatefulWidget {
  @override
  _HijriCalendarPageState createState() => _HijriCalendarPageState();
}

class _HijriCalendarPageState extends State<HijriCalendarPage> {
  String _hijriDate = '';
  String _hijriDay = '';
  String _hijriMonth = '';
  String _hijriYear = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHijriDate();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalender Hijriyah'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _hijriDay,
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    _hijriMonth,
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    _hijriYear,
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
      ),
    );
  }
}
