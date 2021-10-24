import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_42video/anasayfa.dart';
import 'package:firebase_42video/kartvizit.dart';
import 'package:firebase_42video/yazisayfasi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import 'main.dart';

class ProfilEkrani extends StatelessWidget {
  const ProfilEkrani({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
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
              icon: const Icon(Icons.person), //kartvizit için
              onPressed: () {
                FirebaseAuth.instance.signOut().then((deger) => {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const MyWidget()),
                          (Route<dynamic> route) => false),
                    });
              }),
          IconButton(
              icon: const Icon(Icons.exit_to_app), //çıkış
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const YaziEkrani()),
              (Route<dynamic> route) => true);
        },
      ),
      body: const KullaniciYazilari(),
    );
  }
}

class KullaniciYazilari extends StatelessWidget {
  const KullaniciYazilari({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser; //site -çalıştı
    Query blogYazilari = FirebaseFirestore.instance.collection('Yazilar').where(
          "kullanıcıid",
          isEqualTo: currentUser?.uid,
        );

    return StreamBuilder<QuerySnapshot>(
      stream: blogYazilari.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        // ignore: unnecessary_new
        return new ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            return ListTile(
              title: Text(document['baslik']),
              subtitle: Text(document['icerik']),
            );
          }).toList(),
        );
      },
    );
  }
}
