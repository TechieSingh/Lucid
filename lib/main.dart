import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File pickedImage;

  bool isImageLoaded=false;

  Future pickImage() async{
    var tempStore=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage=tempStore;
      isImageLoaded=true;
    });
  }

  Future readText() async{
     FirebaseVisionImage ourImage=FirebaseVisionImage.fromFile(pickedImage);
     TextRecognizer recognizeText=FirebaseVision.instance.textRecognizer();
     VisionText readText= await recognizeText.processImage(ourImage);
     for(TextBlock block in readText.blocks)  {
      for(TextLine line in block.lines){
        for(TextElement word in line.elements){
          print(word.text);
        }
      } 
     }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment(0.0, 0.0),
          child: Text('Ludddcidhg')
          ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isImageLoaded? Center(
              child:Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(pickedImage),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ):Container(),
            SizedBox(height: 10.0,),
            RaisedButton(
              onPressed: pickImage,
              child: Text('Pick an Image'),
              ),
              SizedBox(height: 10.0,),
              RaisedButton(
                onPressed: readText,
                child: Text('Read Text'),
              )
          ],
        ),
      ),
    );
  }
}
