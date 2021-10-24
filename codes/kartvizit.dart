// ignore: unused_import
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ProfilEkrani.dart';
import 'anasayfa.dart';
import 'main.dart';

void main() => runApp(const MyWidget());

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Business Card "),
        actions: [
          IconButton(
            icon: const Icon(Icons.home), //anasayfa
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const AnaSayfa()),
                  (Route<dynamic> route) => true);
            },
          ),
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.book), //burayı değiştiriyorum
            //tooltip: 't', //çok küçük diye yazmıyor galiba
            //highlightColor: Colors.black, //olmadı -Icon içine galiba deneyeceğim
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilEkrani()),
                  (Route<dynamic> route) => true);
            },
          ),
          IconButton(
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((deger) => {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const Iskele()),
                          (Route<dynamic> route) => false),
                    });
              }),
        ],
      ),
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 100,
              ),
              CircleAvatar(
                radius: 70,
                //backgroundColor: Colors.lime,
                backgroundImage: AssetImage('images/ea-foto.png'),
              ),
              Text(
                "Ezgi Aslan",
                style: TextStyle(fontFamily: 'Satisfy', fontSize: 45),
              ),
              Text(
                "Software Engineer",
                style: TextStyle(fontFamily: 'Satisfy', fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 45),
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.blue.shade200,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "xxxx@gmail.com",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 45),
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.blue.shade200,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "+905xx xxx xx xx",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
