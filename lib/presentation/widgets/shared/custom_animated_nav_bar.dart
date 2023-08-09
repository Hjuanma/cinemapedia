import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAnimatedNavBar extends StatefulWidget {
  const CustomAnimatedNavBar({
    super.key,
    required this.size,
    required this.horizontalMargin,
    required this.horizontalPadding,
    required this.icons,
    required this.labels,
  });
  final Size size;
  final double horizontalMargin;
  final double horizontalPadding;
  final List<IconData> icons;
  final List<String> labels;

  @override
  State<CustomAnimatedNavBar> createState() => _CustomAnimatedNavBarState();
}

class _CustomAnimatedNavBarState extends State<CustomAnimatedNavBar>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late double position;
  late Animation<double> animation;
  int selected = 0;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    animation = Tween(begin: getEndPosition(0), end: getEndPosition(2)).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    position = getEndPosition(0);
    super.didChangeDependencies();
  }

  double getEndPosition(int index) {
    double totalMarin = 2 * widget.horizontalMargin;
    double totalPadding = 2 * widget.horizontalPadding;
    double valueToOmit = totalMarin + totalPadding;

    return (((MediaQuery.of(context).size.width - valueToOmit) / 3) * index +
            widget.horizontalPadding) +
        (((MediaQuery.of(context).size.width - valueToOmit) / 3) / 2) -
      70;
  }

  void animateDrop(int index) {
    animation = Tween(begin: position, end: getEndPosition(index)).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    position = getEndPosition(0);

    controller.forward().then((value) {
      position = getEndPosition(index);
      controller.dispose();
      selected = index;
      controller = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 250));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.transparent,
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return CustomPaint(
              painter: AppBarPinter(animation.value),
              size: Size(
                widget.size.width - (2 * widget.horizontalMargin),
              80.0,
              ),
              child: SizedBox(
                height: 120.0,
                width: widget.size.width - (2 * widget.horizontalMargin),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.horizontalPadding,
                  ),
                  child: Row(
                    children: widget.icons 
                        .map((icon){
                          int index = widget.icons.indexOf(icon);
                          return _NavItem(
                              horizontalMargin: widget.horizontalMargin,
                              horizontalPadding: widget.horizontalPadding,
                              icon: icon,
                              size: widget.size,
                              index: index,
                              animateDrop: animateDrop,
                              isSlected: index == selected,
                              label: widget.labels[index],
                            );
                        })
                        .toList(),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

typedef AnimateDropCallback = void Function(int index);

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.size,
    required this.horizontalMargin,
    required this.horizontalPadding,
    required this.icon,
    required this.index,
    required this.animateDrop,
    required this.isSlected,
    required this.label,
  });

  final Size size;
  final double horizontalMargin;
  final double horizontalPadding;
  final IconData icon;
  final int index;
  final bool isSlected;
  final String label;
  final AnimateDropCallback? animateDrop;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final color = isSlected ? colors.primary : Colors.black38;
    return GestureDetector(
      onTap: () {
        if (animateDrop != null) {
          animateDrop!(index);
        }
        context.go("/home/$index");

      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        height: 105,
        width:
            (size.width - (2 * horizontalMargin) - (2 * horizontalPadding)) / 3,
        padding: const EdgeInsets.only(bottom: 17.5, top: 22.5),
        alignment: isSlected ? Alignment.topCenter : Alignment.bottomCenter,
        child: SizedBox(
          height: 40,
          width: 60,
          child: Column(
            children: [
              Center(
                  child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeOut,
                child: Icon(
                  icon,
                  color: color,
                  weight: 30,
                ),
              )),
              Text(label, style: TextStyle(fontSize:10, color: color),)
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarPinter extends CustomPainter {
  final double x;

  double height = 80.0;
  double start = 40.0;
  double end = 120.0;

  AppBarPinter(this.x);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

        Path path = Path();
    path.moveTo(0.0, start);

    /// DROP paths, included X for animation
    path.lineTo((x) < 20.0 ? 20.0 : x, start);
    path.quadraticBezierTo(20.0 + x, start, 30.0 + x, start + 30.0);
    path.quadraticBezierTo(40.0 + x, start + 55.0, 70.0 + x, start + 55.0);
    path.quadraticBezierTo(100.0 + x, start + 55.0, 110.0 + x, start + 30.0);
    path.quadraticBezierTo(
        120.0 + x,
        start,
        (140.0 + x) > (size.width - 20.0) ? (size.width - 20.0) : 140.0 + x,
        start);
    path.lineTo(size.width - 20.0, start);

    /// Box with BorderRadius
    path.quadraticBezierTo(size.width, start, size.width, start + 25.0);
    path.lineTo(size.width, end - 25.0);
    path.quadraticBezierTo(size.width, end, size.width - 25.0, end);
    path.lineTo(25.0, end);
    path.quadraticBezierTo(0.0, end, 0.0, end - 25.0);
    path.lineTo(0.0, start + 25.0);
    path.quadraticBezierTo(0.0, start, 20.0, start);
    path.close();

    canvas.drawPath(path, paint);

    /// Circle to show at the top of the drop 
    canvas.drawCircle(Offset(x + 70.0, 50.0), 35.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
