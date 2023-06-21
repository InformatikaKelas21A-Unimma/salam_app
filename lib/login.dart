import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salam_app/home.dart';
import 'package:salam_app/register.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login_pic.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 330, 30, 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                        color: Color.fromARGB(255, 3, 3, 3),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.0,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "E-mail",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey,
                        size: 22,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                        size: 22,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Lupa Password ?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Color.fromARGB(255, 0, 68, 193),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: signIn,
                        child: Text("Masuk",
                            style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF19F5CC),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'OR',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 174, 174, 174),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 228, 228, 228)),
                        ),
                        onPressed: () {
                          signInWithGoogle();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/google_logo.png',
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Masuk dengan Google',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Belum punya akun? ",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "Daftar",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      child: Image.asset(
                        "assets/salam_logo.png",
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
