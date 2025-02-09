//
// import 'package:flutter/material.dart';
//
// import '../../Constants/paths.dart';
// import '../../Constants/sizedbox.dart';
// import '../../Constants/textStyle.dart';
// import '../../utils/app_common.dart';
//
// class SettingsItem extends StatelessWidget {
//   final String icon;
//   final String title;
//   final Widget? trailing;
//   final Color titleColor;
//   // final Function()? onTap;
//   final bool showArrow;
//
//   const SettingsItem({
//     Key? key,
//     required this.icon,
//     required this.title,
//     // this.onTap,
//     this.trailing,
//     this.titleColor = Colors.black,
//     this.showArrow = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 15),
//       decoration: const BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: Color(0xFFDDDDDD),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(
//         children: [
//           sizeWidth5,
//           cachedImage(
//             icon,
//             width: 22,
//             height: 22,
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Text(
//               title,
//               style: txtStyle14AndBold,
//             ),
//           ),
//           if (trailing != null) trailing!,
//           if (showArrow) ...[
//             const SizedBox(width: 9),
//             cachedImage(
//               nextIcon,
//               width: 18,
//               height: 18,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }