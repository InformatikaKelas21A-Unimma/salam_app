import 'package:flutter/material.dart';
import 'package:salam_app/pages/home_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:salam_app/widgets/image_detail.dart';

class ExplorerPage extends StatelessWidget {
  ExplorerPage({super.key});

  final List<String> items = List.generate(20, (index) => 'Item ${index + 2}');

  final List users = [
    'Anisa_Saputri',
    'Hasanalhadar',
    'Suryononew',
    'Ahmad_Ngawiji',
    'Burhan_Amali',
    'NopalAditya25',
    'Umar_bin_Hamdan',
    'AmirSulaiman01'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60, // Sesuaikan dengan tinggi gambar latar belakang
        centerTitle: false,
        backgroundColor: Color(0xFF29F5CC),
        elevation: 0,
        title: Container(
          width: 500,
          height: 45,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(6)),
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
      body: SafeArea(
        child: GridView.custom(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            pattern: [
              QuiltedGridTile(2, 2),
              QuiltedGridTile(2, 2),
              QuiltedGridTile(2, 2),
              QuiltedGridTile(2, 2),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => GestureDetector(
              onTap: () {
                // Membuka menu baru dengan gambar sesuai indeks yang diklik
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageDetailScreen(index: index),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://picsum.photos/500/500?random=$index'),
                  ),
                ),
              ),
            ),
            childCount: 50,
          ),
        ),
      ),
    );
  }
}
