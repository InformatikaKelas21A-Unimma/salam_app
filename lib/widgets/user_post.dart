import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class UserPost extends StatefulWidget {
  const UserPost({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                        'https://i.pravatar.cc/150?u=${widget.name}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
          height: 300,
          child: Image.network(
            'https://picsum.photos/640/360?random=${widget.name}',
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
                      color: isLiked ? Color.fromARGB(255, 255, 63, 197) : null,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.chat_bubble_outline),
                  const SizedBox(
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
          child: RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: 'Imam Nahrawi ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      'Subhanallah, walhamdulillah, wa laillahailallah, wa allahu akhar :)',
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            'View all comments',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            '17 hours Ago',
            style: TextStyle(color: Colors.black54, fontSize: 10),
          ),
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }
}
