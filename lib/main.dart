import "dart:io";
import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter/services.dart";

void main() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0x00),
        statusBarIconBrightness: Brightness.dark,
    ));

    return runApp(MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({ Key? key }) : super(key: key);

    @override
    Widget build(BuildContext ctx) {
        return MaterialApp(
            title: "Weather App",
            home: HomeScreen(),
        );
    }
}

class HomeScreen extends StatefulWidget {
    HomeScreen({ Key? key }) : super(key: key);

    @override
    HomeScreenState createState() => HomeScreenState();
}

const COLOR_BG = Color(0xFFFFFFFF);
const COLOR_FG = Color(0xFF000000);
const COLOR_FG_SECONDARY = Color(0xFFBEBEBE);

class HomeScreenState extends State<HomeScreen> {
    @override
    Widget build(BuildContext ctx) {
        return Scaffold(
            body: Container(
                padding: EdgeInsets.only(top: 170.0, left: 50.0, right: 50.0),
                color: COLOR_BG,
                child: Center(
                    child: Column(
                        children: <Widget>[
                            Text("CHELYABINSK", style: TextStyle(color: COLOR_FG, fontSize: 30.0, fontWeight: FontWeight.bold)),
                            Text("LIGHT RAIN AND STUFF THIS IS REALLY LONG", textAlign: TextAlign.center, style: TextStyle(color: COLOR_FG_SECONDARY, fontSize: 20.0)),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 60.0),
                                child: Image(image: AssetImage("assets/sun.png"), height: 200.0),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    SizedBox(width: 5.0),
                                    Image(image: AssetImage("assets/thermometer.png"), height: 25.0),
                                    Text(" / ", style: TextStyle(color: COLOR_FG_SECONDARY, fontSize: 20.0)),
                                    Text("-7\u00b0", style: TextStyle(color: COLOR_FG, fontSize: 30.0, fontWeight: FontWeight.bold)),
                                    SizedBox(
                                        width: 50.0,
                                        child: Text("/ -13\u00b0", style: TextStyle(color: COLOR_FG_SECONDARY, fontSize: 20.0)),
                                    ),
                                ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Image(image: AssetImage("assets/wind.png"), height: 25.0),
                                    SizedBox(width: 5.0),
                                    Text("100 km/h, NNW direction", style: TextStyle(color: COLOR_FG_SECONDARY, fontSize: 20.0)),
                                ],
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}
