import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_42video/ProfilEkrani.dart';
import 'package:firebase_42video/anasayfa.dart';
import 'package:firebase_42video/try_hero.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Iskele(),
    );
  }
}

class Iskele extends StatefulWidget {
  const Iskele({Key? key}) : super(key: key);

  @override
  State<Iskele> createState() => _IskeleState();
}

class _IskeleState extends State<Iskele> {
  // ignore: unnecessary_new
  TextEditingController t1 = TextEditingController();
  // ignore: unnecessary_new
  TextEditingController t2 = TextEditingController();

  get margin => null;

  Future<void> kayitOl() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: t1.text,
            password: t2.text) //kullanıcı kayıt işlemi tamamlandı
        .then((kullanici) => {
              FirebaseFirestore.instance
                  .collection("Kullanicilar")
                  .doc(t1.text)
                  .set({"KullaniciEposta": t1.text, "KullaniciSifre": t2.text}),
            }); //sonra
    showDialog(
        //kayıt başarılı bildirimi için
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("Successfully")),
            content: const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.done,
                color: Colors.green,
              ),
              iconSize: 100,
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Ok"),
              )
            ],
            backgroundColor: Colors.white,
          );
        });
  }

  girisYap() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: t1.text, password: t2.text)
        .then(
          (kullanici) => {
            Navigator.push(context,
                MaterialPageRoute(builder: (kullanici) => const AnaSayfa())),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Center(child: Text("Blog Store")),
      ),
      body: Container(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              // ignore: prefer_const_constructors
              MaterialPageRoute(builder: (context) => PageImage()),
            );
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,

                      child: Hero(
                        //hero kullanarak yeni sayfada image'yi açma
                        tag: 'hero_example',
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/blog-foto.png'),
                          radius: 100,
                        ),
                      ),
                      /*
                      child: Image.asset('images/blog-foto.png',
                          height: double.infinity,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover)), */ //böyle kare oluyor
                    ),
                  ),
                ),
                const SizedBox(
                  //resim textfield'a yapışmasın diye
                  height: 50.0,
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter valid email id as abc@gmail.com',
                  ),
                  controller: t1,
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter secure password',
                  ),
                  controller: t2,
                ),
                const SizedBox(
                  //resim textfield'a yapışmasın diye
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, //tuşlar ortada olsun
                  children: [
                    // ignore: deprecated_member_use
                    RaisedButton(
                      color: Colors.blue.shade400, // background
                      textColor: Colors.white, // foreground
                      child: const Text("Sign up"),
                      onPressed: kayitOl,
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(
                      //resim textfield'a yapışmasın diye
                      width: 10.0,
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      color: Colors.blue.shade400, // background
                      textColor: Colors.white, // foreground
                      child: const Text("Sign in"),
                      onPressed: girisYap,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
