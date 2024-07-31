import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui_template/otp_design.dart/timer_widget.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationView extends ConsumerStatefulWidget {
  OtpVerificationView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends ConsumerState<OtpVerificationView>
    with TickerProviderStateMixin {
  final _otpController = TextEditingController();
  final _timerKey = GlobalKey<TimerWidgetState>();
  final defaultOtpTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(16),
    ),
  );

  int timeInSeconds = 5;
  @override
  void initState() {
    super.initState();
  }

  late String shortLink;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100, bottom: 50),
              child: const AutoSizeText(
                "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Pinput(
              controller: _otpController,
              length: 4,
              showCursor: true,
              autofocus: true,
              defaultPinTheme: defaultOtpTheme,
              keyboardType: TextInputType.text,
            ),
            TimerWidget(
              key: _timerKey,
              timeInSeconds: timeInSeconds,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "OTP Verification",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                onPressed: () => onOtpSubmit(),
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future onOtpSubmit() async {
    if (_otpController.text.isEmpty || _otpController.text.length < 4) {
      _timerKey.currentState?.startTimer();
    } else {}
  }
}
