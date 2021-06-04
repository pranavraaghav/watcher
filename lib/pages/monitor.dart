import 'package:crosswalk/models/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Item {
  String image;
  Timestamp timestamp;
}

class Monitor extends StatefulWidget {
  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CrosswalkUser>(context);

    List<Item> reports;

    final CollectionReference reportCollection =
        FirebaseFirestore.instance.collection(user.uid);

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
        stream:
            reportCollection.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            return ListView(
              children: documents
                  .map(
                    (doc) => RotatedBox(
                      quarterTurns: 1,
                      child: Card(
                        child: Image.network(doc['image']),
                      ),
                    ),
                  )
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
