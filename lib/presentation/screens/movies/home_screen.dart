import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

import '../../views/views.dart';

class HomeScreen extends StatefulWidget {
  static const name = "home-screen";
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex})
      : assert(pageIndex <= 2);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double horizontalPadding = 25.0;
  double horizontalMargin = 25.0;

  final viewRoutes = const <Widget>[HomeView(), SizedBox(), FavoritesView()];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        //index: widget.pageIndex,
        children: [
          Positioned(
            bottom: horizontalMargin,
            left: horizontalMargin,
            child: CustomPaint(
              painter: AppBarPinter(),
              size: Size(
                size.width - (2 * horizontalMargin),
                70.0,
              ),
            ),
          )
        ],
      ),
      //bottomNavigationBar: CustomBottomNavigationBar(currentIndex: widget.pageIndex),
      // bottomNavigationBar: Positioned(
      //   bottom: horizontalMargin,
      //   left: horizontalMargin,
      //   child: CustomPaint(
      //     painter: AppBarPinter(),
      //     size: Size(size.width - (2*horizontalMargin), 80.0,),
      //   ),
      // ),
    );
  }
}

class AppBarPinter extends CustomPainter {
  double height = 80.0;
  double start = 40.0;
  double end = 120.0;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(20.0, 0.0);

    path.quadraticBezierTo(40.0, 0.0, 50.0, 30.0);
    path.quadraticBezierTo(60.0, 55.0, 90.0, 55.0);
    path.quadraticBezierTo(120.0, 55.0, 130.0, 30.0);
    path.quadraticBezierTo(140.0, 0.0, 160.0, 0.0);

    path.lineTo(size.width - 20.0, 0.0);

    path.quadraticBezierTo(size.width, 0.0, size.width, 25.0);
    path.lineTo(size.width, size.height - 25.0);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 25.0, size.height);
    path.lineTo(25.0, size.height);
    path.quadraticBezierTo(0.0, size.height, 0.0, size.height - 25.0);
    path.lineTo(0.0, 25.0);
    path.quadraticBezierTo(0.0, 0.0, 20.0, 0.0);
    path.close();

    canvas.drawPath(path, paint);

    canvas.drawCircle(Offset(90, 10.0), 30.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
