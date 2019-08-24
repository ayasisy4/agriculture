import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstone/models/crop.dart';
import 'package:firstone/models/kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firstone/blocs/data.dart';
import 'package:weather/weather.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
    
          primaryColor: Color(0xFFF92b7e),
        ),
        home: HomePage(),
      );
    
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
 bool connect= false;
 bool showSoilType=false;
 Crop chosenCrop;

// functions 
 //function that return the current selected crop
 Crop setChosenCrop(List<Crop> crops,String cropId){
   setState(() {    
  crops.forEach((f){
  f.uid=cropId;
  chosenCrop=f;
  });
 });
 return chosenCrop;
 }
// build the widget
  @override
  Widget build(BuildContext context) {
    //the controller of the textfield
    final TextEditingController _text = TextEditingController();
           return StatefulProvider<DataServices>(
        valueBuilder: (BuildContext context) => DataServices(),
        child: Consumer<DataServices>(
            builder: (BuildContext context, forumServices) {
              //get all the kits and prsesnt the recommandtions of specific one based on the code entered by the user 
          return StreamBuilder<List<Kit>>(
              stream: forumServices.kit$,
              builder: (context, snapshot) {
                 if (!snapshot.hasData) {
                   //return loading indicator
                  return CircularProgressIndicator();
                }
               final kits= snapshot.data;
               //get all crops and then choose the one that matches with the kit : cropId
                  return StreamBuilder<List<Crop>>(
                    stream: forumServices.crops$,
                    builder: (context, snap) {
                       if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
               final crops= snap.data;
                      return Scaffold(
                body: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        //design a gradient screen
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.lightGreen,
                            Colors.white,
                            Colors.white,
                          ],
                          stops: [-1.0, 0.5, 1.0],
                        ),
                      ),
                      child: Center(       
                         child:   Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RaisedButton(
                                                                    child: Text(
                                        "اشترى العربة الان",
                                        style: TextStyle(
                                            fontSize: 25, fontWeight: FontWeight.w500,color: Colors.white),
                                      ),
                                      onPressed: ()=> showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  content: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          child: Text(
                                            "ادخل رقم الهاتف هنا الخاص بك للتواصل مع خدمة العملاء  ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        TextField(
                                          style: TextStyle(fontSize: 15,color: Colors.green),
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(15),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0))),
                                          onChanged: null,
                                          onSubmitted: null,
                                          onEditingComplete: null,
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                      RaisedButton(
                                                child: Text(
                                                  "CONFIRM",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.lightGreen,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  

                                                    Navigator.pop(context);
                                                  }
                                                
                                              ),
                                      ]
                                      )
                                      
                                    ));
                                    } 
                                    ),
                                      ),
                                    
                                    SizedBox(height: 50,),
                                     RaisedButton(
                                       onPressed: (){
                                         setState(() {
                                           this.connect=true;
                                         });
                                         print(connect);
                                       },
                                                                      child: Text(
                                        "الاتصال بالعربه الخاصه بك ",
                                        style: TextStyle(
                                            fontSize: 25, fontWeight: FontWeight.w500,color: Colors.white),
                                    ),
                                     ),

                                     connect?
                                     Column(
                                       children: <Widget>[
                                         Text("برجاء ادخال كود الشريحة "),
                                        TextField( 
                                          controller: _text,
                                          onSubmitted:(kitId){
                                            forumServices.getKit(kitId,kits);
                                          
                                            }
                                        ),
                                  


StreamBuilder<Kit>(
  stream: forumServices.kit,
  builder: (context, snapshot) {
    if(!snapshot.hasData){
      return Text(" ");
    }
    final kit= snapshot.data;
    return     StreamBuilder<Crop>(
      stream: forumServices.crop,
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return FlatButton(child: Text("انقر هناا للتاكيد "),
        
        onPressed: (){
          forumServices.getKit(_text.text, kits);
         chosenCrop= setChosenCrop(crops, kit.cropId);
          Navigator.push(
        
                            context, MaterialPageRoute(builder: (_) => Recomand(kit: kit,crop:chosenCrop,)));
        
        });
        }
                  return Text(" ");

      }
    );
  }
)


                                       ],
                                     ):
                                     Text(" "),
                                     

                                     
                                  ]
                                ),
                      ),
                ),
              );
                    }
                  );
              
                } 
          ); }
        ) ); 
  }
}

//the recommandition page 
class Recomand extends StatefulWidget {
  final Kit kit;
  final Crop crop;

  const Recomand(
      {Key key, @required this.kit, @required this.crop})
      : super(key: key);
  @override
  _RecomandState createState() => _RecomandState();
}

class _RecomandState extends State<Recomand> {
final TextEditingController _text = TextEditingController();
 String warningMsg=" ";
//functions 
//function to get the amount of water needed 
 void checkWater(Crop crop, Kit kit){
   num soilwettingVolume = kit.rowspacing* kit.activerootdepth * kit.nooffarrowfedan* kit.farrowlength;
   num amountofirrigation = soilwettingVolume * ((kit.fc)-(kit.pwp))*kit.raw*(1+kit.lr)*(1+kit.irreff);
   num areainfedan = kit.area/4200 ;
   num amountofwater= (amountofirrigation*areainfedan);

   if (kit.mad <= crop.mad)
   { 
     print(kit.mad.toString());     
     warningMsg="  منسوب المياة قليل للغاية لابد من الرى ف الحال  "+"  و تحتاج الى كمية لا تتعدى "+ amountofwater.toStringAsFixed(1) +" متر مكعب  ";
     if ( kit.soiltemp > crop.temp){
        warningMsg="درجة حرارة النباتات مرتفعه عن الحد المطلوب برجاء عمل  فحوصات و تاكد ان درجة الحرارة"+crop.temp.toString()+"\n \n \n \n"+warningMsg;
   }
   }
  else if( kit.soiltemp > crop.temp){

     warningMsg="درجة حرارة النباتات مرتفعه عن الحد المطلوب برجاء عمل  فحوصات و تاكد ان درجة الحرارة"+crop.temp.toString()+"\n \n \n \n"+warningMsg;
   }
   else {
    
     warningMsg=" ليس هناك اى مجهود اضافى مطلوب كل شئ على ما يرام"+"  , يمكنك الاستراحه الان  :)";
  }
 }

//widget build 
  @override
  Widget build(BuildContext context) {
  
         checkWater(widget.crop,widget.kit);
         
                  return Scaffold(
                    appBar: AppBar(
                      title:Text("   "), 
                      backgroundColor: Colors.lightGreen,
                      elevation: 0,
                    ),
                body:Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.lightGreen,
                            Colors.lightGreenAccent,
                            Colors.green,
                          ],
                          stops: [-1.0, 0.5, 1.0],
                        ),
                      ),
                      child: Center(
               child: Column(

                    children: <Widget>[
                      SizedBox(height: 5,),
                      Text("توصياات  ..",style:TextStyle(fontSize: 48,color: Colors.yellowAccent)),
                      SizedBox(height: 30,),
                      Column(children: <Widget>[
                        Text(warningMsg,style: TextStyle(color: Colors.white,fontSize:18,fontWeight: FontWeight.w700),),

                      ],),
                    ],
               ),
                      ),
                    ));
                  }
                
        
  }


           
