import 'package:flutter/material.dart';
import 'package:multiswitch/multiswitch.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String value = "one";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selected: '$value'"),
      ),
      body: Center(
        child: Multiswitch(
          options: ["one", "two", "three", "four", "five"],
          onChanged: _changeValue,
        ),
      ),
    );
  }

  void _changeValue(String value) {
    setState(() {
      this.value = value;
    });
  }
}
