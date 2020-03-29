import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location{
  double _long,_lat;
  void  getcurrentLocation() async{
    Position pos=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    _long=pos.longitude;
    _lat=pos.latitude;
  print("long:$_long  lat:$_lat");
  }

  Map getlocation(){
    Map val={};
    val['longitude']=_long;
    val['latitude']=_lat;
    
    return val;
  }
}