import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlutterAnimateTemp extends ConsumerStatefulWidget {
  const FlutterAnimateTemp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FlutterAnimateTempState();
}

class _FlutterAnimateTempState extends ConsumerState<FlutterAnimateTemp> {
  TextStyle style = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hello")
                .animate(
                  // delay: 1000.ms, // this delay only happens once at the very start
                  onPlay: (controller) => controller.repeat(), // loop
                )
                .fadeIn(delay: 2000.ms),
            Animate(
              // autoPlay: true,
              onPlay: (controller) => controller.repeat(reverse: true),
            ).toggle(
              duration: 2.seconds,
              builder: (_, value, __) => Text(value ? "Before$value" : "After $value"),
            ),
            Text("Hello World")
                .animate(
                    // autoPlay: true,
                    )
                .custom(
                    duration: 300.ms,
                    builder: (context, value, child) => Container(
                          color: Color.lerp(Colors.red, Colors.blue, value),
                          padding: EdgeInsets.all(8),
                          child: child, // child is the Text widget being animated
                        )),
            Animate(
              onPlay: (controller) => controller.repeat(reverse: true),
            ).toggle(
              duration: 1.ms,
              builder: (_, value, __) => AnimatedContainer(
                duration: 1.seconds,
                color: value ? Colors.red : Colors.green,
                width: 100,
                height: 100,
              ),
            ),
            Animate(
              onPlay: (controller) => controller.repeat(reverse: true),
            ).toggle(
              duration: 1.seconds,
              builder: (_, value, __) => Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: value ? Colors.red : Colors.green,
                  borderRadius: BorderRadius.circular(value ? 0 : 50),
                ),
                child: Center(
                  child: Text(
                    value ? "On" : "Off",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),Animate(
  onPlay: (controller) => controller.repeat(reverse: true),
).toggle(
  duration: 1.seconds,
  builder: (_, value, __) => Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(50),
    ),
    child: Center(
      child: Text(
        value ? "On" : "Off",
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
        ),
      ),
    ),
  ),
),
            Text("Horrible Pulsing Text")
                .animate(onPlay: (controller) => controller.repeat(reverse: true))
                .fadeOut(curve: Curves.easeInOut),
            Animate()
                .custom(
                  duration: 10.seconds,
                  begin: 10,
                  end: 0,
                  builder: (_, value, __) => Text(value.round().toString()),
                )
                .fadeOut(),
            Column(
              children: AnimateList(
                interval: 600.ms,
                effects: [FadeEffect(duration: 1000.ms)],
                children: [
                  Text(
                    "Hello",
                    style: style,
                  ),
                  Text(
                    "World",
                    style: style,
                  ),
                  Text(
                    "Goodbye",
                    style: style,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
