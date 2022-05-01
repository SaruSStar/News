import 'package:flutter/material.dart';

class BgWaveCustomPainter extends CustomPainter {
  final BuildContext context;

  BgWaveCustomPainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Theme.of(context).primaryColor.withOpacity(0.65)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width * -0.0019286, size.height * 0.6739000);
    path0.cubicTo(
        size.width * 0.1290000,
        size.height * 0.6769200,
        size.width * 0.2246786,
        size.height * 0.7273200,
        size.width * 0.2683929,
        size.height * 0.7569400);
    path0.cubicTo(
        size.width * 0.3051429,
        size.height * 0.7842600,
        size.width * 0.3075000,
        size.height * 0.7851000,
        size.width * 0.3635000,
        size.height * 0.8482600);
    path0.cubicTo(
        size.width * 0.4266786,
        size.height * 0.9172200,
        size.width * 0.5668571,
        size.height * 0.9584800,
        size.width * 0.6874643,
        size.height * 0.9665200);
    path0.quadraticBezierTo(size.width * 0.7624286, size.height * 0.9713600,
        size.width * 0.9980714, size.height * 0.9792000);
    path0.lineTo(size.width * 0.9980714, size.height * 1.0015600);
    path0.lineTo(size.width * -0.0019286, size.height * 1.0019600);
    path0.quadraticBezierTo(size.width * -0.0019286, size.height * 0.9377200,
        size.width * -0.0019286, size.height * 0.6739000);
    path0.close();

    canvas.drawPath(path0, paint0);

    Paint paint1 = Paint()
      ..color = Theme.of(context).primaryColor.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path1 = Path();
    path1.moveTo(size.width * 0.9980000, size.height * 0.8758600);
    path1.quadraticBezierTo(size.width * 0.6903929, size.height * 0.9498000,
        size.width * 0.3100714, size.height * 0.9481800);
    path1.cubicTo(
        size.width * 0.1860357,
        size.height * 0.9436800,
        size.width * 0.0759286,
        size.height * 0.9011800,
        0,
        size.height * 0.8610000);
    path1.quadraticBezierTo(
        0, size.height * 0.8958800, 0, size.height * 1.0005600);
    path1.lineTo(size.width, size.height * 1.0007800);
    path1.lineTo(size.width * 0.9980000, size.height * 0.8758600);
    path1.close();

    canvas.drawPath(path1, paint1);

    Paint paint2 = Paint()
      ..color = Theme.of(context).primaryColor.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path2 = Path();
    path2.moveTo(size.width, size.height * 0.3287200);
    path2.cubicTo(
        size.width * 0.8268929,
        size.height * 0.3144400,
        size.width * 0.7781071,
        size.height * 0.2809600,
        size.width * 0.7139643,
        size.height * 0.2439000);
    path2.cubicTo(
        size.width * 0.6190714,
        size.height * 0.1831400,
        size.width * 0.6468571,
        size.height * 0.1416600,
        size.width * 0.5387500,
        size.height * 0.0771000);
    path2.cubicTo(
        size.width * 0.4550714,
        size.height * 0.0253200,
        size.width * 0.3041429,
        size.height * 0.0173800,
        size.width * 0.1785714,
        size.height * 0.0180000);
    path2.quadraticBezierTo(size.width * 0.1130000, size.height * 0.0180400, 0,
        size.height * 0.0182000);
    path2.lineTo(0, 0);
    path2.lineTo(size.width, 0);
    path2.quadraticBezierTo(size.width, size.height * 0.0821800, size.width,
        size.height * 0.3287200);
    path2.close();

    canvas.drawPath(path2, paint2);

    Paint paint3 = Paint()
      ..color = Theme.of(context).primaryColor.withOpacity(0.4)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path3 = Path();
    path3.moveTo(size.width, size.height * 0.2505000);
    path3.cubicTo(
        size.width * 0.8120000,
        size.height * 0.2588200,
        size.width * 0.7394286,
        size.height * 0.2298400,
        size.width * 0.6500000,
        size.height * 0.1940000);
    path3.cubicTo(
        size.width * 0.5887143,
        size.height * 0.1652600,
        size.width * 0.5490357,
        size.height * 0.1265200,
        size.width * 0.4571429,
        size.height * 0.0860000);
    path3.quadraticBezierTo(
        size.width * 0.3138571, size.height * 0.0264800, 0, 0);
    path3.lineTo(size.width, 0);
    path3.quadraticBezierTo(size.width, size.height * 0.0626250, size.width,
        size.height * 0.2505000);
    path3.close();

    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
