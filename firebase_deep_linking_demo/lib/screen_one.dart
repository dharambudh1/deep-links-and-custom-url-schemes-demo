import 'package:flutter/material.dart';

class ScreenOne extends StatefulWidget {
  final String id;
  const ScreenOne({Key? key, required this.id}) : super(key: key);

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen one'),
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
