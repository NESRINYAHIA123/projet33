

import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_test_0/packages/dynamic_image_crop_package/dynamic_image_crop.dart';
import 'package:image_picker_test_0/providers/positions_provider.dart';
import 'package:image_picker_test_0/providers/screens_provider.dart';
import 'package:provider/provider.dart';

part '../enums/dimensions.dart';
part '../enums/image_category.dart';


class ImageMergingProvider extends ChangeNotifier{




  ImageMergingProvider(){
    _cropController.changeType(CropType.drawing);

  }

  File? _sourceImage;
  Uint8List? _sourceUint8ListImage;

  File? _targetImage;
  Uint8List? _targetUint8ListImage;

  File? _croppedImage;
  Uint8List? _croppedtUint8ListImage;

  File? _mergedImage;
  Uint8List? _mergedUint8ListImage;

  String? _sourceBase64Image;

  String? _targetBase64Image;


  String? _croppedBase64Image;


  CropController _cropController = CropController();


  String? getSourceBase64Image(){
    return _sourceBase64Image;
  }

  String? getTargetBase64Image(){
    return _targetBase64Image;
  }


  String? getCroppedBase64Image(){
    return _croppedBase64Image;
  }

  setSourceImage(File value) {
    _sourceImage = value;
    _sourceUint8ListImage = _sourceImage!.readAsBytesSync();
    _cropController.changeImageFile(_sourceImage!);

    notifyListeners();
  }

  Uint8List? getSourceUint8ListImage() {
    return _sourceUint8ListImage;
  }

  File? getTargetImage() {
    return _targetImage;
  }

  setTargetImage(File value) {
    _targetImage = value;
    _targetUint8ListImage = _targetImage!.readAsBytesSync();
    notifyListeners();
  }

  Uint8List? getTargetUint8ListImage() {
    return _targetUint8ListImage;
  }


  setCroppedImage(File? value) {
    _croppedImage = value;
    notifyListeners();
  }

  Uint8List? getCroppedtUint8ListImage() {
    return _croppedtUint8ListImage;
  }

  setCroppedtUint8ListImage(Uint8List? value) {
    _croppedtUint8ListImage = value;
    _croppedBase64Image = base64Encode(value!);
    notifyListeners();
  }

  File? getMergedImage() {
    return _mergedImage;
  }

  setMergedImage(File value) {
    _mergedImage = value;
    notifyListeners();
  }

  Uint8List? getMergedUint8ListImage() {
    return _mergedUint8ListImage;
  }

  setMergedUint8ListImage(Uint8List value) {
    _mergedUint8ListImage = value;
    notifyListeners();
  }



  CropController getCropController() {
    return _cropController;
  }


 int  getTargetImageSize({required Dimensions dimensions }){

    // var imageHeightLogical ;
   int imageHeight = 0;
   int imageWidth = 0;
    if (_sourceUint8ListImage != null) {
      final Image image = Image.memory(_sourceUint8ListImage!);
      final ImageStream stream = image.image.resolve(
          ImageConfiguration.empty);
      stream.addListener(ImageStreamListener((info, _) {

        imageHeight = info.image.height;
        imageWidth = info.image.width;


      }));
    }

    switch (dimensions){

      case Dimensions.width:
        return imageWidth;

      case Dimensions.height:
      return imageHeight;
    }



  }


  void cropTypeInit(){
    _cropController.changeType(CropType.drawing);
    notifyListeners();
  }

void clearCrop()  {
    _cropController.clearCropArea();
    notifyListeners();
  }


  Future<bool> pickImageFromGallery({required ImageCategory imageCategory,required BuildContext context}) async {

    try {
      final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage == null) return false;

      final imageTemp = File(pickedImage.path);

      if (imageCategory == ImageCategory.source) {
       setSourceImage(imageTemp);
       _sourceBase64Image = base64Encode(imageTemp!.readAsBytesSync());

      } else if(imageCategory == ImageCategory.target) {
        setTargetImage(imageTemp);
        _targetBase64Image = base64Encode(imageTemp!.readAsBytesSync());

        if (context.mounted) {
          context.read<PositionsProvider>().initMask(imageWidth: getTargetImageSize(dimensions: Dimensions.width), imageHeight: getTargetImageSize(dimensions: Dimensions.height)) ;
        } else {
          // Widget is not mounted, handle accordingly
        }
      }

      return true;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return false;
    }
  }


  void clearEveryThing({required BuildContext context}){

    print("Clearing EveryThing!!!");

     _sourceImage = null;
     _sourceUint8ListImage = null;
     _targetImage = null;
     _targetUint8ListImage = null;
     _croppedImage = null;
     _croppedtUint8ListImage = null;
     _mergedImage = null;
     _mergedUint8ListImage = null;

     _sourceBase64Image = null;
     _targetBase64Image = null;
     _croppedBase64Image = null;

      context.read<ScreensProvider>().resetScreenToShow() ;
      context.read<PositionsProvider>().clearSelectionCords();

     notifyListeners();

  }


}

