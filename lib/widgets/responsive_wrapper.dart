// import 'package:flutter/material.dart';

// /// Wraps content so it is:
// /// - Full-width on mobile (< 600 px)
// /// - Centred & capped at [maxWidth] on wider screens (tablet / web)
// class ResponsiveWrapper extends StatelessWidget {
//   final Widget child;
//   final double maxWidth;
//   final Color? backgroundColor;

//   const ResponsiveWrapper({
//     super.key,
//     required this.child,
//     this.maxWidth = 480,
//     this.backgroundColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: backgroundColor ?? const Color(0xFFF5F5F7),
//       alignment: Alignment.topCenter,
//       child: ConstrainedBox(
//         constraints: BoxConstraints(maxWidth: maxWidth),
//         child: child,
//       ),
//     );
//   }
// }