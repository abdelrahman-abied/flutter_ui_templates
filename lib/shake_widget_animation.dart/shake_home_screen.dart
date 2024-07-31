import 'package:flutter/material.dart';
import 'package:flutter_ui_template/shake_widget_animation.dart/shake_widget.dart';

class ShakeHomeScreen extends StatefulWidget {
  const ShakeHomeScreen({super.key});

  @override
  State<ShakeHomeScreen> createState() => _ShakeHomeScreenState();
}

class _ShakeHomeScreenState extends State<ShakeHomeScreen> {
  //TODO 8. Control the ShakeWidget with a GlobalKey
  // 1. declare a GlobalKey
  final _shakeKey = GlobalKey<ShakeWidgetState>();
  final _shakeTextField = GlobalKey<ShakeWidgetState>();
  final _formKey = GlobalKey<FormState>();
  final inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: ShakeWidget(
                  // 4. pass the GlobalKey as an argument
                  key: _shakeTextField,
                  // 5. configure the animation parameters
                  shakeCount: 3,
                  shakeOffset: 10,
                  shakeDuration: const Duration(milliseconds: 400),
                  // 6. Add the child widget that will be animated
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "please enter value";
                      }
                      return null;
                    },
                    controller: inputController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              //  shake the widget via the GlobalKey when a button is pressed

              ShakeWidget(
                // 4. pass the GlobalKey as an argument
                key: _shakeKey,
                // 5. configure the animation parameters
                shakeCount: 3,
                shakeOffset: 10,
                shakeDuration: const Duration(milliseconds: 400),
                // 6. Add the child widget that will be animated
                child: const Text(
                  'Invalid credentials',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: validateForm,
                child: const Text('Sign In', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateForm() {
    if (!_formKey.currentState!.validate()) {
      _shakeTextField.currentState?.shake();
    }
  }
}
