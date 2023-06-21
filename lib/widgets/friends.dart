import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class Friends extends StatelessWidget {
  const Friends({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 110,
          height: 145,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    width: 40,
                    image: NetworkImage('https://i.pravatar.cc/'),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  faker.person.name(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Aksi yang dijalankan saat tombol ditekan
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Warna latar belakang
                    minimumSize: Size(70, 30), // Ukuran minimum tombol
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Mengatur sudut melengkung
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 5),
                      Text(
                        "Ikuti",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
