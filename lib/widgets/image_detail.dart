import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:salam_app/widgets/comment.dart';

class ImageDetailScreen extends StatefulWidget {
  final int index;

  ImageDetailScreen({required this.index});

  @override
  _ImageDetailScreenState createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  late String name; // Variabel untuk menyimpan nama faker

  @override
  void initState() {
    super.initState();
    name =
        faker.person.name(); // Mengambil nama faker saat widget diinisialisasi
  }

  bool isLiked = false; // Variabel untuk melacak status like

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
                  'Jelajahi',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                  'https://i.pravatar.cc/150?u=$name'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(Icons.more_vert),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 410,
                    child: Image.network(
                      'https://picsum.photos/500/500?random=${widget.index}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isLiked = !isLiked;
                                });
                              },
                              icon: Icon(
                                isLiked
                                    ? Icons.thumb_up_rounded
                                    : Icons.thumb_up_outlined,
                                color: isLiked
                                    ? Color.fromARGB(255, 255, 63, 197)
                                    : null,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.chat_bubble_outline),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.send_outlined),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                          icon: Icon(
                            isLiked ? Icons.eco_rounded : Icons.eco_outlined,
                            color: isLiked ? Color(0xFF29F5CC) : null,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: const [
                        Text('Liked by '),
                        Text(
                          'Amber',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(' and '),
                        Text(
                          'Others',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            faker.lorem.sentences(3).join(' '),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 5, bottom: 3),
                    child: Row(
                      children: [
                        Text(
                          '17 hours Ago',
                          style: TextStyle(color: Colors.black54, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CommentWidget(name: name);
                    },
                    itemCount:
                        10, // Ganti dengan jumlah komentar yang diinginkan
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
