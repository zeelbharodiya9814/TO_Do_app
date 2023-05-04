


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreDBHelper {
  FirestoreDBHelper._();

  static final FirestoreDBHelper firestoreDBHelper = FirestoreDBHelper._();

  static final FirebaseFirestore db = FirebaseFirestore.instance;



  Future<void> insert({required Map<String, dynamic> data}) async {

    DocumentSnapshot<Map<String, dynamic>> counter = await db.collection("counter").doc("notes_counter").get();
    int id = counter['id'];
    int length = counter['length'];

    // await db.collection("students").add(data);
    await db.collection("todos").doc("${++id}").set(data);

    await db.collection("counter").doc("notes_counter").update({"id" : id});

    await db.collection("counter").doc("notes_counter").update({"length" : ++length});
  }



  Future<void> delete({required String id}) async {

    await db.collection("todos").doc(id).delete();

    DocumentSnapshot<Map<String, dynamic>> counter = await db.collection("counter").doc("notes_counter").get();
    int length = counter['length'];

    await db.collection("counter").doc("notes_counter").update({"length" : --length});
  }



  Future<void> update({
    required String id,
    required String title,
     String? color,
  }) async {

    await db.collection("todos").doc(id).update({'title' : title,'color': color});

  }
}

// => All in Firestore
// TODO : insert
// TODO : update
// TODO : delete