import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firstone/models/crop.dart';
import 'package:firstone/models/kit.dart';

class DataServices {
  final _firestore = Firestore.instance;
  String cropId;

 
  void addsoiltype(String type,kitId) {
   
 
    Firestore.instance.collection('kit').document(kitId).updateData(
      {
        'soilType': type,
      },
    );
  }


  BehaviorSubject<Kit> _kit$ =
      BehaviorSubject<Kit>();
  Stream<Kit> get kit => _kit$.stream;
    BehaviorSubject<Crop> _crop$ =
      BehaviorSubject<Crop>();
  Stream<Crop> get crop => _crop$.stream;
    
   void getKit(String kitId,List<Kit> kits){
   Kit currentkit;
    kits.forEach((f){
      if(f.kitName==kitId){
        currentkit= f;
      }
    });
    cropId=currentkit.cropId;
    _kit$.sink.add(currentkit);
  }

   void getcrop(String cropId,List<Crop> crops){
   Crop choosenCrop;
    crops.forEach((f){
      if(f.uid==cropId){
        choosenCrop= f;
      }
    });
    _crop$.sink.add(choosenCrop);
  }
  

  Stream<List<Kit>> get kit$ {
    return _firestore
        .collection("kit")
        .snapshots()
        .map((snap) {
      final docs = snap.documents;
      final kits = docs.map((doc) => Kit.fromDocument(doc)).toList();
      return kits;
    });
  }
   Stream<List<Crop>> get crops$ {
    return _firestore
        .collection("crop")
        .snapshots()
        .map((snap) {
      final docs = snap.documents;
      final crops = docs.map((doc) => Crop.fromDocument(doc)).toList();
      return crops;
    });
  }
 
 

  void dispose() {
    _kit$.close();
    _crop$.close();
  }
}
