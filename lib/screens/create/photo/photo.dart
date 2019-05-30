import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker_modern/image_picker_modern.dart';

import './../../../custom_icons.dart';
import './../../../typography/palette.dart';
import './../../../typography/style.dart';

// Create using photo form
class CreatePhoto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreatePhotoState();
  }
}

class CreatePhotoState extends State<CreatePhoto> {
  File _imageFile;
  bool _libraryActive = true;
  bool _cameraActive = false;

  // Function to retrieve image from source (i.e. library or camera)
  void _getImage(context, source) {
    print('hellos');

    ImagePicker.pickImage(source: source, maxWidth: 400).then((File image) {
      setState(() {
        _imageFile = image;
      });
    });
  }

  // Upload Image component - rendered in _photoTypeTemplate()
  _buildUploadImage() {
    return               
      Expanded(
        // color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _getImage(context, ImageSource.gallery);
              },
              child: Icon(CustomIcons.add,
                  size: 100, color: Color(0xff555555)),
            ),
            SizedBox(height: 20),
            Text('UPLOAD AN IMAGE'),
          ],
        ),
      );
  }

  // Use camera component - rendered in _photoTypeTemplate()
  _buildUseCamera() {
    return
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _getImage(context, ImageSource.camera);
              },
              child: Text('USE CAMERA'),
            ),
        
          ],
        ),
      );
  }

  // Component shown to prompt user to retrieve image
  _photoTypeTemplate() {
    return 
    Container(
        child: 
          Column(            
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _libraryActive ? _buildUploadImage() : _buildUseCamera(),
              
              Container(
                padding: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(border: Border(
                  top: BorderSide(color: Color(0xffeeeeee), width: 1),
                )),
                  child: Row(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width * .5,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _libraryActive = true;
                              _cameraActive = false;
                            });
                          },
                          child: Text('LIBRARY',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                  color: _libraryActive
                                      ? Color(0xff333333)
                                      : Color(0xff999999))))),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width * .5,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _libraryActive = false;
                              _cameraActive = true;
                            });
                            _getImage(context, ImageSource.camera);
                          },
                          child: Text('CAMERA',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: _cameraActive
                                      ? Color(0xff333333)
                                      : Color(0xff999999)))))
                ],
              ))
            ]));
  }

  // Component once image is retrieved
  _buildImagePreview() {
    return Column(children: [
      Container(
        width: MediaQuery.of(context).size.width, 
        height: MediaQuery.of(context).size.width,        
        color: Colors.blue,
        child: Image.file(_imageFile, fit: BoxFit.contain),
      ),
      Container(child: RaisedButton(onPressed: () {
        setState(() {
          _imageFile = null;
        });
      }))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return 
      Expanded(
        child: _imageFile == null ? _photoTypeTemplate() : _buildImagePreview()
      );
  }
}



// Caption

      // Container(
      //   padding: EdgeInsets.symmetric(horizontal: 10),
      //   margin: EdgeInsets.only(bottom: 10),
      //   child: TextField(
      //     buildCounter: (BuildContext context,
      //             {int currentLength, int maxLength, bool isFocused}) =>
      //         null,
      //     decoration: InputDecoration(
      //       border: InputBorder.none,
      //       hintText: 'Caption (optional)',
      //     ),
      //     cursorColor: JuntoPalette.juntoGrey,
      //     cursorWidth: 2,
      //     style: JuntoStyles.lotusLongformTitle,
      //     maxLines: 1,
      //     maxLength: 80,
      //   ),
      // ),