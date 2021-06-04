import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Item {
  String image;
  Timestamp timestamp;
}

class Monitor extends StatefulWidget {
  String uid;
  Monitor({this.uid});

  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  // List<Item> reports;

  // final CollectionReference reportCollection =
  //     FirebaseFirestore.instance.collection(widget.uid);

  // @override
  // void initState() {
  //   super.initState();
  //   _getReports();
  // }

  // void _getReports() {
  //   reportCollection
  //       .orderBy('timestamp', descending: true)
  //       .snapshots()
  //       .listen((result) {
  //     result.docs.forEach((element) {
  //       reports.add(element.data());
  //     });
  //   });
  // }

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
    List<Item> reports;

    final CollectionReference reportCollection =
        FirebaseFirestore.instance.collection(widget.uid);

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

    _getReports();

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: reportCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            return (documents == null)
                ? ListView(
                    children: documents
                        .map(
                          (doc) => Card(child: Image.network(doc['image'])),
                        )
                        .toList(),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                        Text('No images captured yet'),
                      ],
                    ),
                  );
          }
        },
      ),
    );
  }
}
