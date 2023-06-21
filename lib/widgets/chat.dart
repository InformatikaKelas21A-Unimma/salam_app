import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> _messages = [];
  TextEditingController _textEditingController = TextEditingController();

  Future<String> getAIResponse(String message) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
      },
      body: jsonEncode({
        'prompt': message,
        'max_tokens': 50,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['text'];
    } else {
      throw Exception('Failed to get AI response');
    }
  }

  void _sendMessage(String message) async {
    setState(() {
      _messages.add('$message');
      _textEditingController.clear();
    });

    try {
      String aiResponse = await getAIResponse(message);

      setState(() {
        _messages.add('$aiResponse');
      });
    } catch (e) {
      print('Error: $e');
      print('Error message: ${e.toString()}');
    }
  }

  Widget _buildChatList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              SizedBox(
                width: 120,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 23, 23, 23),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _messages[index],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow
                            .ellipsis, // Mengatur overflow teks menjadi elipsis (...)
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF29F5CC),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://img.freepik.com/premium-vector/islamic-boy-character-holding-quran-illustration_188398-1601.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Habib Husein Ja'far Al Hadar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Online",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 10,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 25,
            ),
            SizedBox(
              width: 12,
            ),
            Icon(
              Icons.more_vert,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://www.pngkit.com/png/full/278-2789149_background-islam-png-islamic-pattern-background-png.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildChatList(),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(255, 23, 23, 23),
                        ),
                        height: 45,
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: TextField(
                            controller: _textEditingController,
                            decoration: InputDecoration.collapsed(
                              hintText: 'Type your message...',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors
                                  .white, // Mengatur warna teks menjadi putih
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromARGB(255, 17, 134, 101),
                      ),
                      height: 45,
                      width: 45,
                      child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          _sendMessage(_textEditingController.text);
                        },
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
