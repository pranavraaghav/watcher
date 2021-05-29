import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreTest extends StatelessWidget {
  final images = [14, 13, 40, 43];
  final timestamp = ['1', '2', '3', '5'];
  void add(images, timestamps) {
    FirebaseFirestore.instance.collection('reports').doc('report1').set({
      'images': images,
      'timestamps': timestamps,
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('title'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => add(images, timestamp),
            child: Text('TEST'),
          ),
        ),
      ),
    );
  }
}
