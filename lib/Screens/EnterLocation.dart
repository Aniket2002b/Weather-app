import 'package:flutter/material.dart';

class Enterlocation extends StatefulWidget {
  const Enterlocation({super.key});

  @override
  State<Enterlocation> createState() => _EnterlocationState();
}

class _EnterlocationState extends State<Enterlocation> {
  TextEditingController cityNameControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/screen2.jpg'),
                fit: BoxFit.cover
            )
        ),
        child:SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height:0,
              ),
              IconButton(
                icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 40,
              ),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: cityNameControler,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Enter the city name.",
                    labelText:"City Name",
                    fillColor: Colors.white,
                    filled: true
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: GestureDetector(
                    child: Text(
                      "Get Weather",
                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    onTap: (){
                      Navigator.pop(context,cityNameControler.text);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
