import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(),
        child: ListView.builder(itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("data"),
            ),
          );
        }),
      ),
    );
  }
}
