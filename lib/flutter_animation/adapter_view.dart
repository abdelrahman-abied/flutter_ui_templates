import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animate/src/effects/shader_effect.dart';

class InfoView extends StatelessWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title = const Text(
      'Flutter Animate Examples',
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 40,
        color: Color(0xFF666870),
        height: 1,
        letterSpacing: -1,
      ),
    );

    // here's an interesting little trick, we can nest Animate to have
    // effects that repeat and ones that only run once on the same item:
    title = title
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1200.ms, color: const Color(0xFF80DDFF))
        .animate() // this wraps the previous Animate in another Animate
        .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
        .slide();

    List<Widget> tabInfoItems = [
      for (final tab in FlutterAnimateExample.tabs)
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(tab.icon, color: const Color(0xFF80DDFF)),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  tab.description,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        )
    ];

    // Animate all of the info items in the list:
    tabInfoItems = tabInfoItems
        .animate(interval: 600.ms)
        .fadeIn(duration: 900.ms, delay: 300.ms)
        .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
        .move(begin: const Offset(-100, 0), curve: Curves.easeOutQuad);

    return Scaffold(
      backgroundColor: const Color(0xFF666870),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          title,
          hr,
          const Text('''
    This simple app demonstrates a few features of the flutter_animate library. More examples coming as time permits.
    
    Switch between examples via the bottom nav bar. Tap again to restart that animation.'''),
          hr,
          ...tabInfoItems,
          hr,
          const Text('These examples are over the top for demo purposes. Use restraint. :)'),
        ],
      ),
    );
  }

  Widget get hr => Container(
        height: 2,
        color: const Color(0x8080DDFF),
        margin: const EdgeInsets.symmetric(vertical: 16),
      ).animate().scale(duration: 600.ms, alignment: Alignment.centerLeft);
}

class TabInfo {
  const TabInfo(this.icon, this.builder, this.label, this.description);

  final IconData icon;
  final WidgetBuilder builder;
  final String label;
  final String description;
}

class FlutterAnimateExample {
  static final List<TabInfo> tabs = [
    TabInfo(Icons.info_outline, (_) => InfoView(key: UniqueKey()), 'Info',
        'Simple example of Widget & List animations.'),
    TabInfo(Icons.palette_outlined, (_) => VisualView(key: UniqueKey()), 'Visual',
        'Visual effects like saturation, tint, & blur.'),
    TabInfo(Icons.format_list_bulleted, (_) => const AdapterView(), 'Adapters',
        'Animations driven by scrolling & user input.'),
    TabInfo(Icons.grid_on_outlined, (_) => const EverythingView(), 'Kitchen Sink',
        'Grid view of effects with default settings.'),
    TabInfo(Icons.science_outlined, (_) => PlaygroundView(key: UniqueKey()), 'Playground',
        'A blank canvas for experimenting.'),
  ];
}

class VisualView extends StatelessWidget {
  const VisualView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // create our stylish text:
    Widget title = const Text(
      'SOME\nVISUAL\nEFFECTS\n\n  on\n\nRAINBOW\nTEXT',
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 64,
        color: Color(0xFF666870),
        height: 0.9,
        letterSpacing: -5,
      ),
    );

    // add a rainbow gradient:
    // I'm lazy so I'll just apply a ShimmerEffect, use a ValueAdapter to
    // pause it half way, and let it handle the details
    title = title.animate(adapter: ValueAdapter(0.5)).shimmer(
      colors: [
        const Color(0xFFFFFF00),
        const Color(0xFF00FF00),
        const Color(0xFF00FFFF),
        const Color(0xFF0033FF),
        const Color(0xFFFF00FF),
        const Color(0xFFFF0000),
        const Color(0xFFFFFF00),
      ],
    );

    // sequence some visual effects
    title = title
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .saturate(delay: 1.seconds, duration: 2.seconds)
        .then() // set baseline time to previous effect's end time
        .tint(color: const Color(0xFF80DDFF))
        .then()
        .blurXY(end: 24)
        .fadeOut();

    return Padding(padding: const EdgeInsets.all(24), child: title);
  }
}

class PlaygroundView extends StatelessWidget {
  const PlaygroundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        child: const Text("Playground 🛝")
            .animate()
            .slideY(duration: 900.ms, curve: Curves.easeOutCubic)
            .fadeIn(),
      ),
    );
  }
}

class AdapterView extends StatelessWidget {
  const AdapterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // example of driving an animation with a ValueNotifier

    // create the ValueNotifier:
    ValueNotifier<double> notifier = ValueNotifier(0);

    // create an animation driven by ValueNotifierAdapter,
    // and wire up a Slider to update the ValueNotifier
    Widget panel = Container(
      color: const Color(0xFF2A2B2F),
      child: Column(children: [
        const SizedBox(height: 32),
        const Text(
          'Slider Driven Animation',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          textAlign: TextAlign.center,
        )
            .animate(adapter: ValueNotifierAdapter(notifier, animated: true))
            .blurXY(end: 16, duration: 600.ms)
            .tint(color: const Color(0xFF80DDFF)),

        // Slider:
        AnimatedBuilder(
          animation: notifier,
          builder: (_, __) => Slider(
            activeColor: const Color(0xFF80DDFF),
            value: notifier.value,
            onChanged: (value) => notifier.value = value,
          ),
        )
      ]),
    );

    // example of driving animations with a ScrollController

    // create the ScrollController:
    ScrollController scrollController = ScrollController();

    // create some dummy items for the list:
    List<Widget> items = [
      const Text(
        'Scroll driven animation',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      )
    ];
    for (int i = 0; i < 100; i++) {
      items.add(Text('item $i', style: const TextStyle(height: 2.5)));
    }

    // layer the indicators & rocket behind the list, and assign the
    // the animations (via ScrollAdapter), and the list:
    Widget list = Stack(
      children: [
        // background color:
        Container(color: const Color(0xFF202125)),

        // top indicator:
        Container(
          height: 64,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x4080DDFF), Color(0x0080DDFF)]),
          ),
        )
            .animate(
              adapter: ScrollAdapter(
                scrollController,
                end: 500, // end 500px into the scroll
              ),
            )
            .scaleY(alignment: Alignment.topCenter),

        // bottom indicator:
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 64,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0x4080DDFF), Color(0x0080DDFF)],
              ),
            ),
          )
              .animate(
                adapter: ScrollAdapter(
                  scrollController,
                  begin: -500, // begin 500px before the end of the scroll
                ),
              )
              .scaleY(alignment: Alignment.bottomCenter, end: 0),
        ),

        // rocket:
        const Text('🚀', style: TextStyle(fontSize: 96))
            .animate(
              adapter: ScrollAdapter(
                scrollController,
                animated: true, // smooth the scroll input
              ),
            )
            .scaleXY(end: 0.5, curve: Curves.easeIn)
            .fadeOut()
            .custom(
              // custom animation to move it via Align
              begin: -1,
              builder: (_, value, child) => Align(
                alignment: Alignment(value, -value),
                child: child,
              ),
            )
            .shake(hz: 3.5, rotation: 0.15), // wobble a bit

        // the list (with the scrollController assigned):
        ListView(
          padding: const EdgeInsets.all(24.0),
          controller: scrollController,
          children: items,
        ),
      ],
    );

    return Column(
      children: [
        panel,
        Flexible(child: list),
      ],
    );
  }
}
// Kitchen sink view of all Effects
// Note the use of shortcut methods (defined at the bottom) to make these more concise

class EverythingView extends StatelessWidget {
  static ui.FragmentShader? shader;

  const EverythingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => GridView.count(
        crossAxisCount: (constraints.maxWidth / 192).floor(),
        childAspectRatio: 0.85,
        children: [
          /***
          A few fun / interesting examples
          ***/
          tile(
            'fade+tint+blur+scale',
            a
                .fadeIn(curve: Curves.easeOutCirc)
                .untint(color: Colors.white)
                .blurXY(begin: 16)
                .scaleXY(begin: 1.5),
          ),
          tile(
            'fade+blur+move',
            a.fadeIn(curve: Curves.easeOutExpo).blurY(begin: 32).slideY(begin: -0.4, end: 0.4),
          ),
          tile(
            'scale',
            a.scale(begin: const Offset(2, 0), curve: Curves.elasticOut),
          ),
          tile(
            'scale+move+elevation',
            a.scaleXY(end: 1.15, curve: Curves.easeOutBack).moveY(end: -10).elevation(end: 24),
          ),
          tile(
            'shimmer+rotate',
            a
                .shimmer(
                  blendMode: BlendMode.dstIn,
                  angle: pi / 4,
                  size: 3,
                  curve: Curves.easeInOutCirc,
                )
                .rotate(begin: -pi / 12),
          ),
          tile(
            'shimmer+elevation+flip',
            a
                .shimmer(angle: -pi / 2, size: 3, curve: Curves.easeOutCubic)
                .elevation(begin: 24, end: 2)
                .flip(),
          ),
          tile(
            'shake+scale+tint',
            a
                .shake(curve: Curves.easeInOutCubic, hz: 3)
                .scaleXY(begin: 0.8)
                .tint(color: Colors.red, end: 0.6),
          ),
          tile(
            'shake+slide+slide',
            a
                .shake(curve: Curves.easeInOut, hz: 0.5)
                .slideX(curve: Curves.easeOut, begin: -0.4, end: 0.4)
                .slideY(curve: Curves.bounceOut, begin: -0.4, end: 0.4),
          ),
          tile(
            'boxShadow+scale',
            a
                .boxShadow(
                  end: const BoxShadow(
                    blurRadius: 4,
                    color: Colors.white,
                    spreadRadius: 3,
                  ),
                  curve: Curves.easeOutExpo,
                )
                .scaleXY(end: 1.1, curve: Curves.easeOutCirc),
          ),
          tile(
            'slide+flip+scale+tint',
            a
                .slideX(begin: 1)
                .flipH(begin: -1, alignment: Alignment.centerRight)
                .scaleXY(begin: 0.75, curve: Curves.easeInOutQuad)
                .untint(begin: 0.6),
          ),

          /***
          Catalog of minimal examples for all visual effects.
          In alphabetic order of the effect's class name.
          ***/

          //tile('blur', a.blur()),
          tile('blurX', a.blurX()),
          tile('blurY', a.blurY()),
          tile('blurXY', a.blurXY()),

          tile('boxShadow', a.boxShadow()),

          tile('color', a.color()),

          tile('crossfade', a.crossfade(builder: (_) {
            return Container(
              width: _boxSize,
              height: _boxSize,
              color: const Color(0xFFDDAA00),
              alignment: Alignment.center,
              child: const Text('😎', style: TextStyle(fontSize: 60)),
            );
          })),

          // callback

          tile('custom', a.custom(builder: (_, val, child) {
            val = val * pi * 2 - pi / 2;
            return Transform.translate(
              offset: Offset(cos(val) * 24, sin(val) * 24),
              child: Transform.scale(scale: 0.66, child: child),
            );
          })),

          // effect

          tile('elevation', a.elevation()),

          //tile('fade', a.fade()),
          tile('fadeIn', a.fadeIn()),
          tile('fadeOut', a.fadeOut()),

          tile('flipH', a.flipH()),
          tile('flipV', a.flipV()),

          tile(
            'followPath',
            a.followPath(
              path: Path()
                ..moveTo(-40, -40)
                ..quadraticBezierTo(-40, 40, 40, 40),
              rotate: true,
            ),
          ),

          // listen

          //tile('move', a.move()),
          tile('moveX', a.moveX()),
          tile('moveY', a.moveY()),

          tile('rotate', a.rotate()),

          tile('saturate', a.saturate()),
          tile('desaturate', a.desaturate()),

          //tile('scale', a.scale()),
          tile('scaleX', a.scaleX()),
          tile('scaleY', a.scaleY()),
          tile('scaleXY', a.scaleXY()),

          tile('shake', a.shake()),
          tile('shakeX', a.shakeX()),
          tile('shakeY', a.shakeY()),

          tile('shader', a.shader(shader: EverythingView.shader)),

          tile('shimmer', a.shimmer()),

          //tile('slide', a.slide()),
          tile('slideX', a.slideX()),
          tile('slideY', a.slideY()),

          tile('swap', a.swap(builder: (_, __) => const Text('HELLO!'))),
          tile('swap (child)', a.swap(builder: (_, child) {
            return Opacity(opacity: 0.5, child: child!);
          })),

          // then

          tile('tint', a.tint()),
          tile('untint', a.untint()),

          tile('toggle', a.toggle(builder: (_, b, child) {
            return Container(
              color: b ? Colors.purple : Colors.yellow,
              padding: const EdgeInsets.all(8),
              child: child,
            );
          })),

          //tile('visibility', a.visibility()),
          tile('hide', a.hide()),
          tile('show', a.show()),
        ],
      ),
    );
  }

  // this returns a ready to use Animate instance targeting a `box` (see below)
  // it uses empty effects to set default delay/duration values (750 & 1500ms)
  // and a total duration (3000ms), so there is a 750ms pause at the end.
  Animate get a => box
      .animate(onPlay: (controller) => controller.repeat())
      .effect(duration: 3000.ms) // this "pads out" the total duration
      .effect(delay: 750.ms, duration: 1500.ms); // set defaults

  // simple square box with a gradient to use as the target for animations.
  Widget get box => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.green, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: _boxSize,
        height: _boxSize,
      );

  // grid tile. Naming should be `buildTile`, but going for brevity.
  Widget tile(String label, Widget demo) => Container(
        margin: const EdgeInsets.all(4),
        color: Colors.black12,
        child: Column(
          children: [
            Flexible(child: Center(child: demo)),
            Container(
              color: Colors.black12,
              height: 32,
              alignment: Alignment.center,
              child: Text(label, style: const TextStyle(fontSize: 12)),
            )
          ],
        ),
      );
}

double _boxSize = 80;
