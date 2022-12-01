import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Uri _link1 =
      Uri.parse('flutterdeeplinkingdemo://dharam.com/screen-one');
  final Uri _link2 =
      Uri.parse('flutterdeeplinkingdemo://dharam.com/screen-one/123');
  final Uri _link3 =
      Uri.parse('flutterdeeplinkingdemo://dharam.com/screen-two');
  final Uri _link4 =
      Uri.parse('flutterdeeplinkingdemo://dharam.com/screen-two/123');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote deep linking'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _launchUrl(_link1),
                child: Text(
                  _link1.toString(),
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              GestureDetector(
                onTap: () => _launchUrl(_link2),
                child: Text(
                  _link2.toString(),
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              GestureDetector(
                onTap: () => _launchUrl(_link3),
                child: Text(
                  _link3.toString(),
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              GestureDetector(
                onTap: () => _launchUrl(_link4),
                child: Text(
                  _link4.toString(),
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri uri) async {
    try {
      if (!await launchUrl(uri)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch $uri'),
          ),
        );
        throw 'Could not launch $uri';
      }
    } catch (e) {
      if (Platform.isAndroid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
      return;
    }
  }
}
