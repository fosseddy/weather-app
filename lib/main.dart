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

const Map<String, String> WWO_CODE = {
    "113": "Sunny",
    "116": "PartlyCloudy",
    "119": "Cloudy",
    "122": "VeryCloudy",
    "143": "Fog",
    "176": "LightShowers",
    "179": "LightSleetShowers",
    "182": "LightSleet",
    "185": "LightSleet",
    "200": "ThunderyShowers",
    "227": "LightSnow",
    "230": "HeavySnow",
    "248": "Fog",
    "260": "Fog",
    "263": "LightShowers",
    "266": "LightRain",
    "281": "LightSleet",
    "284": "LightSleet",
    "293": "LightRain",
    "296": "LightRain",
    "299": "HeavyShowers",
    "302": "HeavyRain",
    "305": "HeavyShowers",
    "308": "HeavyRain",
    "311": "LightSleet",
    "314": "LightSleet",
    "317": "LightSleet",
    "320": "LightSnow",
    "323": "LightSnowShowers",
    "326": "LightSnowShowers",
    "329": "HeavySnow",
    "332": "HeavySnow",
    "335": "HeavySnowShowers",
    "338": "HeavySnow",
    "350": "LightSleet",
    "353": "LightShowers",
    "356": "HeavyShowers",
    "359": "HeavyRain",
    "362": "LightSleetShowers",
    "365": "LightSleetShowers",
    "368": "LightSnowShowers",
    "371": "HeavySnowShowers",
    "374": "LightSleetShowers",
    "377": "LightSleet",
    "386": "ThunderyShowers",
    "389": "ThunderyHeavyRain",
    "392": "ThunderySnowShowers",
    "395": "HeavySnowShowers",
};

const Map<String, String> WEATHER_SYMBOL = {
    "Sunny":               "sun.png",

    "PartlyCloudy":        "partly-cloudy.png",
    "Cloudy":              "cloudy.png",
    "VeryCloudy":          "cloudy.png",

    "LightRain":           "light-rain.png",
    "LightShowers":        "light-rain.png",

    "LightSleet":          "heavy-rain.png",
    "LightSleetShowers":   "heavy-rain.png",
    "HeavyRain":           "heavy-rain.png",
    "HeavyShowers":        "heavy-rain.png",

    "ThunderyHeavyRain":   "thunder.png",
    "ThunderyShowers":     "thunder.png",
    "ThunderySnowShowers": "thunder.png",

    "LightSnow":           "snow.png",
    "LightSnowShowers":    "snow.png",
    "HeavySnow":           "snow.png",
    "HeavySnowShowers":    "snow.png",

    "Fog":                 "fog.png",

    "Unknown":             "unknown.png",
};

