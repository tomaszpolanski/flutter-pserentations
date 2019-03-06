import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    Key key,
    this.fraction,
    this.beat = 0,
  }) : super(key: key);
  final double fraction;
  final double beat;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.shortestSide;
    return Center(
      child: Container(
        height: size * fraction + 10 * beat,
        width: size * fraction + 10 * beat,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: const [
              Color(0xFFdc5921),
              Color(0xFFdc5921),
              Color(0xFF670625),
              Color(0xFF35051f),
              Colors.black,
            ],
            stops: const [0, 0.7, 0.8, 0.98, 1],
          ),
        ),
      ),
    );
  }
}

class ThatsAll extends StatefulWidget {
  @override
  _ThatsAllState createState() => _ThatsAllState();
}

class _ThatsAllState extends State<ThatsAll> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _fadeInController;
  bool _showQuestions = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )
      ..repeat(reverse: true)
      ..addListener(() => setState(() {}));
    _fadeInController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _showQuestions = true);
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Floks',
        fontWeight: FontWeight.w400,
        fontSize: 180,
      ),
      child: Stack(
        children: [
          Transform.scale(
            scale: 2.5,
            child: Stack(
              children: [
                GradientContainer(fraction: 1),
                GradientContainer(
                  fraction: 0.7,
                  beat: _controller.value,
                ),
                GradientContainer(
                  fraction: 0.7 * 0.7,
                  beat: _controller.value,
                ),
                GradientContainer(
                  fraction: 0.7 * 0.7 * 0.7,
                  beat: _controller.value,
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _format("That's all Folks!".split('')).toList(),
                ),
                DefaultTextStyle.merge(
                  style: TextStyle(fontSize: 100),
                  child: AnimatedCrossFade(
                    duration: Duration(milliseconds: 500),
                    crossFadeState: _showQuestions
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _format('Thank you!'.split('')).toList(),
                    ),
                    secondChild: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _format('Questions?'.split('')).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _showQuestions ? 1 : 0,
              child: DefaultTextStyle.merge(
                style: TextStyle(fontSize: 30),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text('Tomek Polanski'),
                      Text('@tpolansk'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Iterable<Widget> _format(List<String> letters) sync* {
    int i = 0;
    for (final letter in letters) {
      yield Transform.translate(
        offset: Offset(0, 1 / 8 * pow(2 * i - letters.length, 2)),
        child: Transform.rotate(
          angle: pi / 180 * (i - letters.length * 0.5) * 2,
          child: Text(letter),
        ),
      );
      i += 1;
    }
  }
}
