
part of '../providers/screens_provider.dart';
enum ScreenToShow {


  empty(""),
  selectingSourceImage("Select source"),
  sourceImageSelected(""),
  selectingTargetImage("Select target"),
  targetImageSelected(""),
  mergingImage("Merging"),
  imageMerged(""),
  save("Save"),
  about("About"),
  exit("Exit")
  ;

  final String value   ;

  const ScreenToShow(this.value);

}