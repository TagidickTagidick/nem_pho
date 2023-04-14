import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          Text("text 1"),
          Expanded(
            child: Text("text 2"),
          ),
          Text("text 3")
        ],
      ),
    )
  );
}