import 'package:flutter/material.dart';
import 'dart:math';

class StarWithSparkles extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;
  final Color color;
  final double size;

  const StarWithSparkles({
    Key? key,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<StarWithSparkles> createState() => _StarWithSparklesState();
}

class _StarWithSparklesState extends State<StarWithSparkles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool _showSparkles = false;

  final int numSparkles = 8;
  final double sparkleRadius = 20;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showSparkles = false;
        });
        _controller.reset();
      }
    });
  }

  @override
  void didUpdateWidget(covariant StarWithSparkles oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      setState(() {
        _showSparkles = true;
      });
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildSparkles() {
    final List<Widget> sparkles = [];
    final random = Random();

    for (int i = 0; i < numSparkles; i++) {
      final angle = (2 * pi / numSparkles) * i;
      final distance = sparkleRadius * (0.7 + random.nextDouble() * 0.6);
      final delay = i * 50; // ms

      sparkles.add(_SparkleParticle(
        angle: angle,
        distance: distance,
        delay: Duration(milliseconds: delay),
        controller: _controller,
      ));
    }

    return sparkles;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: widget.size * 2,
        height: widget.size * 2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(
                widget.icon,
                color: widget.color,
                size: widget.size,
              ),
            ),
            if (_showSparkles) ..._buildSparkles(),
          ],
        ),
      ),
    );
  }
}

class _SparkleParticle extends StatelessWidget {
  final double angle;
  final double distance;
  final Duration delay;
  final AnimationController controller;

  const _SparkleParticle({
    Key? key,
    required this.angle,
    required this.distance,
    required this.delay,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Animation<double> moveOut = Tween<double>(begin: 0, end: distance)
        .animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          delay.inMilliseconds / 600,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );

    final Animation<double> fadeOut = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          delay.inMilliseconds / 600,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final dx = moveOut.value * cos(angle);
        final dy = moveOut.value * sin(angle);

        return Positioned(
          left: 24 + dx,
          top: 24 + dy,
          child: Opacity(
            opacity: fadeOut.value,
            child: child,
          ),
        );
      },
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.orangeAccent.withOpacity(0.7),
              blurRadius: 4,
              spreadRadius: 1,
            )
          ],
        ),
      ),
    );
  }
}
