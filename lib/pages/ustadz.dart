import 'package:flutter/material.dart';
import 'package:salam_app/widgets/ustadz_detail.dart';

class UstadzPage extends StatelessWidget {
  UstadzPage({Key? key}) : super(key: key);

  final List<String> ustadz = [
    "Habib Husein Ja'far Al Hadar",
    'Ustadz Abdul Shomad',
    'Ustadz Khalid Basalamah',
    'Ustadz Adi Hidayat',
    'Gus Miftah',
  ];

  final List<String> pekerjaan = [
    "Pemuka Agama & Konten kreator",
    'Pemuka Agama & Konten kreator',
    'Pemuka Agama & Konten kreator',
    'Pemuka Agama & Konten kreator',
    'Pemuka Agama & Konten kreator',
  ];

  final List<String> imageUrls = [
    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fid.wikipedia.org%2Fwiki%2FMiftah_Maulana_Habiburrahman&psig=AOvVaw1U_tsZuHrk8VeAGLz7Xq_9&ust=1687067045810000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCPjQqtDMyf8CFQAAAAAdAAAAABAE',
    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fid.wikipedia.org%2Fwiki%2FMiftah_Maulana_Habiburrahman&psig=AOvVaw1U_tsZuHrk8VeAGLz7Xq_9&ust=1687067045810000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCPjQqtDMyf8CFQAAAAAdAAAAABAE',
    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fid.wikipedia.org%2Fwiki%2FMiftah_Maulana_Habiburrahman&psig=AOvVaw1U_tsZuHrk8VeAGLz7Xq_9&ust=1687067045810000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCPjQqtDMyf8CFQAAAAAdAAAAABAE',
    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fid.wikipedia.org%2Fwiki%2FMiftah_Maulana_Habiburrahman&psig=AOvVaw1U_tsZuHrk8VeAGLz7Xq_9&ust=1687067045810000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCPjQqtDMyf8CFQAAAAAdAAAAABAE',
    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fid.wikipedia.org%2Fwiki%2FMiftah_Maulana_Habiburrahman&psig=AOvVaw1U_tsZuHrk8VeAGLz7Xq_9&ust=1687067045810000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCPjQqtDMyf8CFQAAAAAdAAAAABAE',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color(0xFF29F5CC),
        elevation: 0,
        title: Row(
          children: [
            SizedBox(
              width: 10,
            ),
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
                  'Ustadz',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 500,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(137, 204, 204, 204),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search_outlined),
                      iconSize: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            // Lakukan sesuatu saat nilai search berubah
                          },
                          onSubmitted: (value) {
                            // Lakukan sesuatu saat search dikirimkan
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return UstadzWidget(
                  nama: ustadz[index],
                  kategori: pekerjaan[index], // Use Image.asset here
                );
              },
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }
}
