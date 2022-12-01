import 'package:flutter/material.dart';

class ScreenTwo extends StatefulWidget {
  final String id;
  const ScreenTwo({Key? key, required this.id}) : super(key: key);

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen two'),
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            widget.id.isEmpty ? 'Id not passed' : 'Id: ${widget.id}',
          ),
        ),
      ),
    );
  }
}
