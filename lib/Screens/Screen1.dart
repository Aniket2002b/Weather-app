import 'dart:convert';
import 'package:climateeee/Screens/EnterLocation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Screen1 extends StatefulWidget {
  final weatherdata;
  const Screen1({super.key, this.weatherdata});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  var apiKey = "90cfe288988677f0a5431798b182193f";
  var cityName;
  var currentWeather;
  var tempInCel;
  var emoji;
  @override
  void initState() {
    // TODO: implement initState
    updateScreen1(widget.weatherdata);
    super.initState();
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/screen1.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: (){
                  updateScreen1(widget.weatherdata);
                }, icon: const Icon(
                  Icons.near_me,
                  color: Colors.blue,
                  size: 30,
                ),),
                const SizedBox(width: 10,),
                IconButton(
                    onPressed:()async{
                  var cityName = await Navigator.push(context, MaterialPageRoute(builder: (_) => Enterlocation()));
                  if(cityName != null && cityName != ""){
                    var weatherData = getWeatherDataFromCityName(cityName);
                    updateScreen1(widget.weatherdata);
                    print(cityName);
                  }else{
                    print("empty");
                  }
                },
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 30,
                    ))
              ],
            ),
            Text("$cityName",
            style: const TextStyle(
                color: Colors.white, fontSize:40,fontWeight: FontWeight.bold,
            ),
            ),
            Text("$tempInCel° C",
            style:TextStyle(
              color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30,
            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text("$emoji",style: TextStyle(
                    fontSize: 45,
                  ),),
                ),
                Container(
                  margin: EdgeInsets.only(right: 60),
                  child:Text("$currentWeather",
                    style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold,
                  ),),
                )
              ],
            )
          ],
        )
        ),
      ),
    );
  }
  String kelvinToCelcius(var temp){
    var toCelcius = temp -273.15;
    String tempInString = toCelcius.floor().toString();
    return tempInString;
  }
  void getWeatherDataFromCityName(String cityName)async{
    var apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=${apiKey}";
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'q': cityName ,'appid': apiKey});
    var response = await http.get(url);
    var data = response.body;
    var weatherData = jsonDecode(data);
    updateScreen1(weatherData);
  }
  void updateScreen1(weatherData){
    var weatherId = weatherData['weather'][0]['id'];
    if(weatherId > 200 && weatherId < 300){
      setState(() {
        emoji = "⛈";
      });
    }
    else if(weatherId > 300 && weatherId < 400){
      setState(() {
        emoji = "️🌦";
      });
    }
    else if(weatherId > 400 && weatherId < 500){
      setState(() {
        emoji = "️🌧";
      });
    }
    else if(weatherId > 500 && weatherId < 600){
      setState(() {
        emoji = "️🌨";
      });
    }
    else if(weatherId > 600 && weatherId < 700){
      setState(() {
        emoji = "️";
      });
    }
    else if(weatherId >= 700){
      setState(() {
        emoji = "️🌤";
      });
    }
    setState(() {
      var temp = weatherData['main']['temp'];
      tempInCel = kelvinToCelcius(temp);
      currentWeather = weatherData['weather'][0]['main'];
      cityName = weatherData['name'];
    });
  }
}
