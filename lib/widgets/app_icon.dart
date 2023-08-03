import 'package:flutter/cupertino.dart';
import 'package:untitled/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color baskgroundColor;
  final Color iconColor;
  final double size;
  final double iconsize;

  AppIcon({super.key,
  required this.icon,
    this.baskgroundColor=const Color(0xFFfcf4e4),
    this.iconColor= const Color(0xFF756d54),
    this.size=40,
    this.iconsize=16,
    Color? backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(size/2),
        color: baskgroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconsize,
      ),
    );
  }
}
