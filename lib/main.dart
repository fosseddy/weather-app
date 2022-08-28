import "dart:io";
import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter/services.dart";

void main() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0x00),
        statusBarIconBrightness: Brightness.dark,
    ));

    runApp(MyApp());
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

const COLOR_BG = Color(0xFFFFFFFF);
const COLOR_FG = Color(0xFF000000);
const COLOR_FG_SECONDARY = Color(0xFFBEBEBE);

const TEXT_STYLE_PRIMARY = TextStyle(color: COLOR_FG, fontSize: 30.0, fontWeight: FontWeight.bold);
const TEXT_STYLE_SECONDARY = TextStyle(color: COLOR_FG_SECONDARY, fontSize: 20.0);

const DEGREE_SYMBOL = "\u00b0";

class HomeScreen extends StatefulWidget {
    HomeScreen({ Key? key }) : super(key: key);

    @override
    HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
    late Future<Map<String, dynamic>> data;

    @override
    void initState() {
        super.initState();
        this.data = fetchWeatherInfo();
    }

    @override
    Widget build(BuildContext ctx) {
        return Scaffold(
            body: FutureBuilder<Map<String, dynamic>>(
                future: data,
                builder: (ctx, snapshot) {
                    if (snapshot.hasError) {
                        return Center(
                            child: Text("${snapshot.error}"),
                        );
                    }

                    if (!snapshot.hasData) {
                        return Center(
                            child: CircularProgressIndicator(color: COLOR_FG),
                        );
                    }

                    Map<String, dynamic> currCond = snapshot.requireData["current_condition"].first;
                    final String tempC = currCond["temp_C"];
                    final String feelsLike = currCond["FeelsLikeC"];
                    final String windDir = currCond["winddir16Point"];
                    final String windSpeed = currCond["windspeedKmph"];
                    final String weatherDesc = currCond["weatherDesc"].first["value"];
                    final String weatherImage = getWeatherImage(currCond["weatherCode"]);

                    return RefreshIndicator(
                        color: COLOR_FG,
                        backgroundColor: COLOR_BG,
                        onRefresh: () async {
                            var res = await fetchWeatherInfo();
                            setState(() {
                                data = Future.value(res);
                            });
                        },
                        child: Container(
                            color: COLOR_BG,
                            child: ListView(
                                children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.only(top: 170.0, left: 50.0, right: 50.0),
                                        child: Center(
                                            child: Column(
                                                children: <Widget>[
                                                    Text("CHELYABINSK", style: TEXT_STYLE_PRIMARY),
                                                    Text("${weatherDesc.toUpperCase()}", textAlign: TextAlign.center, style: TEXT_STYLE_SECONDARY),
                                                    Container(
                                                        margin: EdgeInsets.symmetric(vertical: 60.0),
                                                        child: Image(image: AssetImage("assets/$weatherImage"), height: 200.0),
                                                    ),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                            SizedBox(width: 10.0),
                                                            Image(image: AssetImage("assets/thermometer.png"), height: 25.0),
                                                            Text(" / ", style: TEXT_STYLE_SECONDARY),
                                                            Text("${tempC + DEGREE_SYMBOL}", style: TEXT_STYLE_PRIMARY),
                                                            SizedBox(
                                                                width: 50.0,
                                                                child: Text("/ ${feelsLike + DEGREE_SYMBOL}", style: TEXT_STYLE_SECONDARY),
                                                            ),
                                                        ],
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                            Image(image: AssetImage("assets/wind.png"), height: 25.0),
                                                            SizedBox(width: 5.0),
                                                            Text("$windSpeed km/h, $windDir direction", style: TEXT_STYLE_SECONDARY),
                                                        ],
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    );
                }
            ),
        );
    }
}

Future<Map<String, dynamic>> fetchWeatherInfo() async {
    HttpClient c = HttpClient();

    HttpClientRequest req = await c.getUrl(
        Uri.parse("https://wttr.in/chelyabinsk?format=j1")
    );
    HttpClientResponse res = await req.close();

    c.close();

    return await res.transform(utf8.decoder)
        .transform(json.decoder)
        .first as Map<String, dynamic>;
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

const Map<String, String> WEATHER_IMAGE = {
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
};

String getWeatherImage(String code) {
    return WEATHER_IMAGE[WWO_CODE[code]] ?? "unknown.png";
}
