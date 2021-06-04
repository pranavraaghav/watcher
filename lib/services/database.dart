import 'package:crosswalk/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future getUserDoc() async {
    return await usersCollection.doc(uid).get();
  }

  Future updateUserData(String email, String displayName) async {
    return await usersCollection.doc(uid).set({
      'displayName': displayName,
      'email': email,
    });
  }

  CrosswalkUser _crosswalkUserFromSnapShot(DocumentSnapshot snapshot) {
    return CrosswalkUser(
      uid: uid,
      displayName: snapshot.get('displayName') ?? 'Username',
      email: snapshot.get('email') ?? 'Email Address',
    );
  }

  //Streams are basically a database listener, when the database is updated anything connected to the stream gets updated too
  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }

  Stream<CrosswalkUser> get userByUid {
    print(usersCollection.doc(uid).snapshots().map(_crosswalkUserFromSnapShot));
    return usersCollection.doc(uid).snapshots().map(_crosswalkUserFromSnapShot);
  }
}
