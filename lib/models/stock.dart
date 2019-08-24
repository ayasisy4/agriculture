import 'package:cloud_firestore/cloud_firestore.dart';

class Stock {
   String uid;
  num nutrientSensor;
  List<String> avialbleCrops;


 

  Stock._({
    this.uid,
    this.avialbleCrops,
  
    this.nutrientSensor,
   
   

  });
 
  factory Stock.fromDocument(DocumentSnapshot snap) {
    if (snap == null) {
      return null;
    } else {
      Map<String, dynamic> data = snap.data;
      return Stock._(
        uid: snap.documentID,
        
       avialbleCrops : data["avbcrops"],
        
        nutrientSensor: data["nutrientsensor"],
      
      );
    }
  }
}
