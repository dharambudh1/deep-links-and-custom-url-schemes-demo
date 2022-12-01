import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_deep_linking_demo/screen_one.dart';
import 'package:firebase_deep_linking_demo/screen_two.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
import 'dart:async';

import 'package:uni_links/uni_links.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
  bool _initialURILinkHandled = false;
  Uri? _initialURI;
  Uri? _currentURI;
  Object? _err;
  StreamSubscription? _streamSubscription;

  final Uri _link1 =
      Uri.parse('flutterdeeplinkingdemo://dharam.com/screen-one');
  final Uri _link2 =
      Uri.parse('flutterdeeplinkingdemo://dharam.com/screen-one/123');
  final Uri _link3 =
      Uri.parse('flutterdeeplinkingdemo://dharam.com/screen-two');
  final Uri _link4 =
      Uri.parse('flutterdeeplinkingdemo://dharam.com/screen-two/123');

  Future<void> _initURIHandler() async {
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;
      Fluttertoast.showToast(
          msg: "Invoked _initURIHandler",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white);
      try {
        final initialURI = await getInitialUri();
        if (initialURI != null) {
          debugPrint("Initial URI received $initialURI");
          if (!mounted) {
            return;
          }
          setState(() {
            _initialURI = initialURI;
          });
          navigationForInitialURL();
        } else {
          debugPrint("Null Initial URI received");
        }
      } on PlatformException {
        debugPrint("Failed to receive initial uri");
      } on FormatException catch (err) {
        if (!mounted) {
          return;
        }
        debugPrint('Malformed Initial URI received');
        setState(() => _err = err);
      }
    }
  }

  void _incomingLinkHandler() {
    if (!kIsWeb) {
      _streamSubscription = uriLinkStream.listen((Uri? uri) {
        if (!mounted) {
          return;
        }
        debugPrint('Received URI: $uri');
        setState(() {
          _currentURI = uri;
          _err = null;
        });
        navigationForCurrentURL();
      }, onError: (Object err) {
        if (!mounted) {
          return;
        }
        debugPrint('Error occurred: $err');
        setState(() {
          _currentURI = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initURIHandler();
    _incomingLinkHandler();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Firebase Deep linking demo',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ExpansionTile(
                  title: const Text('Initial Link'),
                  children: [
                    ListTile(
                      title: const Text("Initial Link Host"),
                      subtitle: Text('${_initialURI?.host}'),
                    ),
                    ListTile(
                      title: const Text("Initial Link Scheme"),
                      subtitle: Text('${_initialURI?.scheme}'),
                    ),
                    ListTile(
                      title: const Text("Initial Link"),
                      subtitle: Text(_initialURI.toString()),
                    ),
                    ListTile(
                      title: const Text("Initial Link Path"),
                      subtitle: Text('${_initialURI?.path}'),
                    ),
                  ],
                ),
                Visibility(
                  visible: !kIsWeb,
                  child: ExpansionTile(
                    title: const Text('Current Link'),
                    children: [
                      ListTile(
                        title: const Text("Current Link Host"),
                        subtitle: Text('${_currentURI?.host}'),
                      ),
                      ListTile(
                        title: const Text("Current Link Scheme"),
                        subtitle: Text('${_currentURI?.scheme}'),
                      ),
                      ListTile(
                        title: const Text("Current Link"),
                        subtitle: Text(_currentURI.toString()),
                      ),
                      ListTile(
                        title: const Text("Current Link Path"),
                        subtitle: Text('${_currentURI?.path}'),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _err != null,
                  child: ListTile(
                    title: const Text('Error',
                        style: TextStyle(color: Colors.red)),
                    subtitle: Text(_err.toString()),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
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
      ),
    );
  }

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  navigationForInitialURL() {
    String path = _initialURI?.path ?? '';
    List<String> array = path.split('/');
    array.removeAt(0);
    routing(array, 'navigationForInitialURL');
  }

  navigationForCurrentURL() {
    String path = _currentURI?.path ?? '';
    List<String> array = path.split('/');
    array.removeAt(0);
    routing(array, 'navigationForCurrentURL');
  }

  void routing(List<String> array, String fromMethod) {
    String routeName = '';
    String idParam = '';

    if (array.isEmpty) {
      Fluttertoast.showToast(
        msg: "Not a valid URL: params error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      return;
    } else {
      routeName = array[0];
      array.length == 2 ? idParam = array[1] : idParam = '';
    }

    if (routeName == 'screen-one') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ScreenOne(
              id: idParam,
            );
          },
        ),
      );
    } else if (routeName == 'screen-two') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ScreenTwo(
              id: idParam,
            );
          },
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: "Not a valid URL:: $fromMethod else called",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      return;
    }
  }
}
