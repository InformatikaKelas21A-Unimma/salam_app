import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_compass/flutter_compass.dart';

class Compass extends StatefulWidget {
  const Compass({Key? key}) : super(key: key);

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double? heading = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color(0xFF29F5CC),
        centerTitle: true,
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
                  'Kompas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${heading!.ceil()}*",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset("assets/compass/cadrant.png"),
                    Transform.rotate(
                      angle: ((heading ?? 0) * (pi / 180) * -1),
                      child:
                          Image.asset("assets/compass/compass.png", scale: 1.1),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
