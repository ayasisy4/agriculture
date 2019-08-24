import 'package:cloud_firestore/cloud_firestore.dart';

class Crop {
  String uid,cropName,season;
num value,mad,temp;

  Crop._({
    this.uid,
    this.cropName,
    this.season,
   this.value,
    this.mad,
    this.temp,

   
   

  });

  factory Crop.fromDocument(DocumentSnapshot snap) {
    if (snap == null) {
      return null;
    } else {
      Map<String, dynamic> data = snap.data;
      return Crop._(
        uid: snap.documentID,
        
        cropName: data["type"],
        
        value: data["Value"],
        mad: data["MAD"],
        season: data["season"],
        temp: data["temp"]
       
      );
    }
  }
}
