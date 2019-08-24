import 'package:cloud_firestore/cloud_firestore.dart';

class Farmer {
  String uid,framerName;
  num age, money;
 List<String> stock;

  Farmer._({
    this.uid,
    this.framerName,
    this.age,
    this.money,
    this.stock
   
   

  });
 
  factory Farmer.fromDocument(DocumentSnapshot snap) {
    if (snap == null) {
      return null;
    } else {
      Map<String, dynamic> data = snap.data;
      return Farmer._(
        uid: snap.documentID,
        
        stock: data["Stock"],
        
        age: data["age"],
        money: data["money"],
      );
    }
  }
}
