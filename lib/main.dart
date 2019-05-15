import 'package:flutter/material.dart';

void main() => runApp(MyApp());

const Color MainColor = Colors.black;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: GridView.count(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          crossAxisCount: 3,
          children: List.generate(9, (index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: MainColor, width: 2),
              ),
              child: Center(
                child: Text(
                  'X',
                  style: TextStyle(fontSize: 54, fontWeight: FontWeight.w300),  
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}