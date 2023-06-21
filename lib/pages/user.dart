import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:salam_app/pages/jelajah_page.dart';
import 'package:salam_app/widgets/friends.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  FirebaseAuth auth = FirebaseAuth.instance;

  void logout() async {
    await auth.signOut();
    // Tambahkan kode atau navigasi tambahan setelah logout
  }

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late Future<String> _emailFuture;
  late Future<String> _nameFuture;
  late Future<List<String>> _randomImagesFuture;

  @override
  void initState() {
    super.initState();
    _emailFuture = getEmailName();
    _nameFuture = getName();
    _randomImagesFuture = getRandomImages();
  }

  Future<String> getEmailName() async {
    User? user = FirebaseAuth.instance.currentUser;
    String email = user?.email ?? 'No Email';
    return 'admin@gmail.com';
  }

  Future<List<String>> getRandomImages() async {
    List<String> randomImages = [];

    // Menentukan jumlah gambar yang akan ditampilkan dalam GridView
    int imageCount = 10;

    // Mengambil gambar acak dari Picsum menggunakan faker sebagai seed
    for (int i = 0; i < imageCount; i++) {
      String randomImage =
          'https://picsum.photos/200?random=${Faker().guid.guid()}';
      randomImages.add(randomImage);
    }

    return randomImages;
  }

  Future<String> getName() async {
    User? user = FirebaseAuth.instance.currentUser;
    // Mengganti dengan cara mendapatkan nama akun dari Firebase
    String name = "admin";
    // Misalnya, jika nama akun tersimpan di dalam user profile atau Firestore
    // Anda dapat mengaksesnya dengan mengambil data dari Firestore
    // name = await FirebaseFirestore.instance
    //    .collection('users')
    //    .doc(user?.uid)
    //    .get()
    //    .then((doc) => doc['name']);
    return name;
  }

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
                  'Akun Saya',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FutureBuilder<String>(
                  future: _nameFuture,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        String name = snapshot.data ?? 'Nama_Akun';
                        return Row(
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.logout_outlined),
                              onPressed: () {
                                Navigator.pop(context);
                                widget.logout();
                              },
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.add_box_outlined,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.more_vert_outlined,
                            ),
                          ],
                        );
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Color(0xFF29F5CC),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/150?u=$getEmailName()'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "2",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Postingan",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                "2",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Pengikut",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                "2",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Mengikuti",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<String>(
                      future: _emailFuture,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            String email = snapshot.data ?? 'No Email';
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(email),
                                Text(
                                  'Ini adalah tampilan dari userpage',
                                )
                              ],
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 140,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            Text("Edit Profil"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 165,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            Text("Tambah Postingan"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: Row(
                          children: [
                            Icon(Icons.people_alt_outlined),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Teman Saya",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 160,
                child: Row(
                  children: [
                    Center(
                      child: Friends(),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Center(
                      child: Friends(),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Center(
                      child: Friends(),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Center(
                      child: Friends(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Postingan Saya",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<String>>(
              future: _randomImagesFuture,
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<String> randomImages = snapshot.data ?? [];

                    return GridView.builder(
                      padding: EdgeInsets.all(16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Jumlah kolom dalam grid
                        crossAxisSpacing:
                            10, // Jarak horizontal antara setiap item
                        mainAxisSpacing:
                            10, // Jarak vertikal antara setiap item
                      ),
                      itemCount: randomImages.length,
                      itemBuilder: (BuildContext context, int index) {
                        String imageUrl = randomImages[index];

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
