import 'dart:convert';
import 'package:climateeee/Screens/Screen1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Services/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    if(mounted){
      getGeolocation();
    }

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("The main screen is disposed");
  }

  void getGeolocation()async{
    Location location = Location();
    await location.getCurrentLocation();
    double latitude = location.latitude;
    double longitude = location.longitude;
    var apiKey = "90cfe288988677f0a5431798b182193f";
    var apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=${apiKey}";
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'lat': latitude.toString() ,'lon': longitude.toString(),'appid': apiKey});
    var response = await http.get(url);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Screen1(weatherdata: data),
        ),
      );    }
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("images/Screen.jpg"),
    fit: BoxFit.cover,
    ),
    ),
     child: Center(
       child: ElevatedButton(
         onPressed: () {
           getGeolocation();
           print("pressed");
         },
         child: Text("Get Location"),
       ),
     ),
    ),);
  }
}