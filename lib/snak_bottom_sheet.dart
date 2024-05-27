import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Center(
          child: Builder(builder: (context) {
            return TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext ct) => ScaffoldMessenger(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      constraints: BoxConstraints.tight(const Size.fromHeight(900)),
                      child: Overlaywidget(),
                    ),
                  ),
                );
              },
              child: const Text('Test'),
            );
          }),
        ),
      ),
    );
  }
}

class Overlaywidget extends StatefulWidget {
  const Overlaywidget({Key? key}) : super(key: key);

  @override
  State<Overlaywidget> createState() => _OverlaywidgetState();
}

class _OverlaywidgetState extends State<Overlaywidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // height: 900,
          color: Colors.blue,
          child: TextButton(
            child: Text(
              'Show snackbar',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 2),
                  content: Text(
                    'Hello',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
