import 'package:flutter/material.dart';
import 'package:salam_app/widgets/chat.dart';

class UstadzWidget extends StatelessWidget {
  const UstadzWidget({
    Key? key,
    required this.nama,
    required this.kategori,
  }) : super(key: key);

  final String nama;
  final String kategori;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: 380,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 32,
              top: 16,
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://img.freepik.com/premium-vector/islamic-boy-character-holding-quran-illustration_188398-1601.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nama,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          kategori,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(
                                255, 76, 175, 137), // Warna latar belakang
                            minimumSize: Size(220, 40), // Ukuran tombol
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Tanya Ustadz',
                            style: TextStyle(
                              color: Colors.white, // Warna teks
                            ),
                          ),
                        ),
                      ],
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
      ],
    );
  }
}
