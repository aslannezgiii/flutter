//burası firebase ile ekle sil güncelle getir işlemlerini yaptığımız yer
// ignore: unused_import
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class YaziEkrani extends StatefulWidget {
  const YaziEkrani({Key? key}) : super(key: key);

  @override
  State<YaziEkrani> createState() => _YaziEkraniState();
}

class _YaziEkraniState extends State<YaziEkrani> {
  // ignore: unnecessary_new
  TextEditingController t1 = new TextEditingController();
  // ignore: unnecessary_new
  TextEditingController t2 = new TextEditingController();

  var gelenYaziBasligi = " ";
  var gelenYaziIcerigi = " ";

  //FirebaseAuth auth = FirebaseAuth.instance; //video-çalışmadı
  var currentUser = FirebaseAuth.instance.currentUser; //site -çalıştı
  //site link: https://firebase.flutter.dev/docs/auth/usage/#user-management

  yaziEkle() {
    FirebaseFirestore.instance.collection("Yazilar").doc(t1.text).set({
      "kullanıcıid": currentUser?.uid,
      'baslik': t1.text,
      'icerik': t2.text,
    }).whenComplete(() => print(
        "yazi eklendi")); //işlem tammalanınca concole'de "yazi eklendi" yazsın diye
  }

  yaziGuncelle() {
    FirebaseFirestore.instance.collection("Yazilar").doc(t1.text).update({
      'baslik': t1.text,
      'icerik': t2.text
    }).whenComplete(() => print(
        "yazi güncellendi")); //işlem tammalanınca concole'de "yazi güncellendi" yazsın diye
  }

  yazSil() {
    FirebaseFirestore.instance.collection("Yazilar").doc(t1.text).delete();
  }

  yazGetir() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .get()
        .then((gelenVeri) {
      setState(() {
        gelenYaziBasligi = gelenVeri.data()!["baslik"];
        gelenYaziIcerigi = gelenVeri.data()!["icerik"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Editing"),
      ),
      body: Container(
        margin: const EdgeInsets.all(50),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: t1,
              ),
              TextField(
                controller: t2,
              ),
              Column(
                children: [
                  RaisedButton(child: Text("Add"), onPressed: yaziEkle),
                  RaisedButton(child: Text("Update"), onPressed: yaziGuncelle),
                  RaisedButton(child: Text("Delete"), onPressed: yazSil),
                  RaisedButton(child: Text("Show"), onPressed: yazGetir),
                ],
              ),
              ListTile(
                title: Text(gelenYaziBasligi),
                subtitle: Text(gelenYaziIcerigi),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
