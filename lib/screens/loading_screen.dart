import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/getlocation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _temp;
  int _condition;
  String _cityname;
  Location x = Location();

  @override
  void initState() {
    super.initState();
    x.getcurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        Center(
          child: RaisedButton(
            onPressed: () async {
              //Get the current location
              var b = x.getlocation();
              // print(b);
              var lon = b['longitude'];
              var lat = b['latitude'];
              var url =
                  "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=578ff3e9d00030c7d290f89c49a5f9da";
              var response = await http.get(url);
              if (response.statusCode == 200) {
                var json = convert.jsonDecode(response.body);
                _temp = json['main']['temp'];
                _condition = json['weather'][0]['id'];
                _cityname = json['name'];
                print(_temp);
                print(_condition);
                print(_cityname);
              }
            },
            child: Text('Get Location'),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: TextField(
            style: TextStyle(color:Colors.grey),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hoverColor: Colors.green,
                focusColor: Colors.black,
                hintText:"city",
                border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(20)),borderSide: BorderSide.none),
                hintStyle: TextStyle(color:Colors.grey)
                ),
            onChanged: (value) {
              _cityname = value;
            },
          ),
        )
      ]),
    ));
  }
}
