import 'package:cloud_firestore/cloud_firestore.dart';

class Weather {
   String uid;
  num humidty, tempr;
 

  Weather._({
    this.uid,
    this.humidty,
    this.tempr,
   
   

  });

  factory Weather.fromDocument(DocumentSnapshot snap) {
    if (snap == null) {
      return null;
    } else {
      Map<String, dynamic> data = snap.data;
      return Weather._(
        uid: snap.documentID,
        
        humidty: data["humidity"],
        
        tempr: data["temp"],
      
      );
    }
  }
}
