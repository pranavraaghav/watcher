import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Item {
  String image;
  Timestamp timestamp;
}

class Monitor extends StatefulWidget {
  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  List<Item> reports;

  final CollectionReference reportCollection =
      FirebaseFirestore.instance.collection('report');

  @override
  void initState() {
    super.initState();
    _getReports();
  }

  void _getReports() {
    reportCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((result) {
      result.docs.forEach((element) {
        reports.add(element.data());
      });
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ListView.builder(
  //     padding: const EdgeInsets.all(8),
  //     itemCount: reports.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Container(
  //         child: Text('${reports[index].image}'),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: reportCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<DocumentSnapshot> documents = snapshot.data.docs;
          return ListView(
            children: documents
                .map(
                  (doc) => Card(child: Image.network(doc['image'])),
                )
                .toList(),
          );
        }
      },
    );
  }
}
