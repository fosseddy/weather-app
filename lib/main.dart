import "package:flutter/material.dart";

void main() => runApp(MyApp());

const String APP_NAME = "Weather App";

class MyApp extends StatelessWidget {
    const MyApp({ Key? key }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: APP_NAME,
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: Scaffold(
                appBar: AppBar(
                    title: Text(APP_NAME),
                ),
                body: Center(
                    child: Text(
                        "Hello, World!",
                        style: Theme.of(context).textTheme.headline3,
                    ),
                ),
            ),
        );
    }
}
