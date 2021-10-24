import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_42video/ProfilEkrani.dart';
import 'package:firebase_42video/yazisayfasi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage - All Blogs"),
        actions: [
          IconButton(
            icon: const Icon(Icons.book), 
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilEkrani()),
                  (Route<dynamic> route) => true);
            },
          ),
          IconButton(
              icon: const Icon(Icons.exit_to_app),
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
      body: const TumYazilar(),
    );
  }
}

class TumYazilar extends StatelessWidget {
  const TumYazilar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference blogYazilari =
        FirebaseFirestore.instance.collection('Yazilar');

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
