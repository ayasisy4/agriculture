import 'package:cloud_firestore/cloud_firestore.dart';

class Kit {
  String uid,farmerId,cropId,kitName;
  num waterLevel, area, raw,activerootdepth,farrowlength,fc,irreff,lr,pwp,rowspacing,soiltemp,nooffarrowfedan,mad;


  Kit._({
    this.uid,
   
    this.area,
    this.fc,
    this.irreff,
    this.lr,
    this.pwp,
    this.nooffarrowfedan,
    this.raw,
    this.rowspacing,
    this.soiltemp,
    this.farrowlength,
    this.activerootdepth,
    this.waterLevel,
    this.cropId,
    this.farmerId,
    this.kitName,
    this.mad

  });

  factory Kit.fromDocument(DocumentSnapshot snap) {
    if (snap == null) {
      return null;
    } else {
      Map<String, dynamic> data = snap.data;
      return Kit._(
        uid: snap.documentID,       
        farrowlength: data["farrowLength"],
        fc: data["fc"],
        irreff: data["irr.eff"],
        nooffarrowfedan: data["nooffarrowfedan"],
        pwp: data["pwp"],
        area: data["area"],
        farmerId: data["farmerId"],
        cropId: data["cropId"],
        kitName: data["name"],
        rowspacing: data["rowSpacing"],
        soiltemp: data["soilTemp"],
        lr: data["lr"],
        activerootdepth: data["activRootDepth"],
        raw: data["RAW"],
        mad: data["mad"]


      );
    }
  }
}
