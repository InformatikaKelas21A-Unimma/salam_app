import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salam_app/widgets/comment.dart';
import 'dart:convert';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeVideo {
  final String videoId;
  final String title;
  final String channelName;
  final int viewCount;

  YouTubeVideo({
    required this.videoId,
    required this.title,
    required this.channelName,
    required this.viewCount,
  });
}

class AbdulSomad extends StatefulWidget {
  @override
  _AbdulSomadState createState() => _AbdulSomadState();
}

class _AbdulSomadState extends State<AbdulSomad> {
  List<YouTubeVideo> videos = [];
  late String name;

  @override
  void initState() {
    super.initState();
    fetchYouTubeVideos();
    name = faker.person.name();
  }

  Future<void> fetchYouTubeVideos() async {
    final String apiUrl = 'https://www.googleapis.com/youtube/v3/search?'
        'part=snippet'
        '&channelId=UClvc6c04-xEYKFFyeP3yjKA'
        '&maxResults=10'
        '&order=date'
        '&key=AIzaSyCxKSQyp4DKpwlV7bTvqC9UMgbC2rAOC_E';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> videoList = data['items'];

      setState(() {
        videos = videoList.map((item) {
          final snippet = item['snippet'];
          return YouTubeVideo(
            videoId: item['id']['videoId'],
            title: snippet['title'],
            channelName: snippet['channelTitle'],
            viewCount:
                0, // Anda dapat memperbarui ini dengan mengambil data jumlah views dari API.
          );
        }).toList();
      });
    } else {
      throw Exception('Failed to fetch YouTube videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: videos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerScreen(video: video),
                      ),
                    );
                  },
                  leading: Image.network(
                    'https://img.youtube.com/vi/${video.videoId}/0.jpg',
                    width: 100,
                  ),
                  title: Text(
                    video.title,
                    style: TextStyle(),
                  ),
                  subtitle: Text(
                      '${video.channelName} • ${video.viewCount} Ditonton'),
                );
              },
            ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final YouTubeVideo video;

  VideoPlayerScreen({required this.video});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final String name = faker.person.name();
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    String videoUrl = 'https://www.youtube.com/watch?v=${widget.video.videoId}';
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: widget.video.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
      ),
    );

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
                  'Salam Kajian',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {
                // Add listener or actions here if needed
              },
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.video.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text('${widget.video.viewCount} x Ditonton')
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    width: 40,
                    image: AssetImage('assets/ulama/ch3.png'),
                  ),
                ),
                SizedBox(width: 3),
                Text(
                  '${widget.video.channelName}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
                Spacer(),
                Row(
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
                          iconSize: 20,
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 20,
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.send_outlined,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Positioned(
                      left: 80,
                      top: 5,
                      child: Container(
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0xFF29F5CC),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 7.0),
                          child: Text(
                            "+ Ikuti",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Komentar',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: 10, // Ganti dengan jumlah komentar yang diinginkan
              itemBuilder: (context, index) {
                return CommentWidget(name: name);
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
      padding: const EdgeInsets.all(5.0),
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
