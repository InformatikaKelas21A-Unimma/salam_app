import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool isReplyVisible = false;
  TextEditingController replyTextEditingController = TextEditingController();
  List<String> replies = [];
  DateTime commentTime =
      DateTime.now(); // Tambahkan variabel untuk menyimpan waktu komentar

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?u=${faker.guid.guid()}'), // Ganti dengan gambar profil yang sesuai
        ),
        title: Row(
          children: [
            Text(
              faker.person.name(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              formatTime(
                  commentTime), // Gunakan fungsi formatTime untuk menampilkan waktu
              style: TextStyle(
                fontSize: 12,
                color: const Color.fromARGB(239, 158, 158, 158),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              faker.lorem.sentence(),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isReplyVisible = true;
                    });
                  },
                  child: Text(
                    'Balas',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isReplyVisible = !isReplyVisible;
                    });
                  },
                  child: Text(
                    'Lihat Balasan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if (isReplyVisible)
              Column(
                children: [
                  TextField(
                    controller: replyTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Tulis balasan',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        isReplyVisible = false;
                        final reply =
                            '${widget.name}:  $value  - ${formatTime(DateTime.now())}';
                        replies.add(reply);
                      });
                      // Kosongkan teks pada TextField
                      replyTextEditingController.clear();
                    },
                  ),
                  SizedBox(height: 8),
                  if (replies.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: replies
                          .map(
                            (reply) => Text(
                              reply,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                          .toList(),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    replyTextEditingController.dispose();
    super.dispose();
  }

  String formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inSeconds < 60) {
      return 'Baru saja';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit yang lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam yang lalu';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }
}
