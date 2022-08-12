import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/brew.dart';
import 'package:untitled/models/myuser.dart';

class DatabaseService{


  final String uid;

  DatabaseService({required this.uid});

  //Collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snapshot
  List<Brew>?  _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
        name: doc.get('name') ?? '',
        sugars: doc.get('sugars') ?? 0,
        strength: doc.get('strength') ?? '0',
        );
    }).toList();
  }

 UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  return UserData(
    uid: uid, 
    name: snapshot.get('name'),
     sugars: snapshot.get('sugars'),
      strength: snapshot.get('strength')
  );
 }

  //get brews stream
  Stream<List<Brew>?> get brews {
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}