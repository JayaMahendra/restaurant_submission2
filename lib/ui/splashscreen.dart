
// import 'package:flutter/material.dart';
// import 'package:sub2/main.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   static const routeName = '/splash_screen';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Container(
//             padding: EdgeInsets.only(top: 100),
//             child: Image.network(
//               'https://www.pngkey.com/png/detail/341-3417964_food-icon-red-png.png',
//             ),
//           ),
//           Text(
//             "Restaurant",
//             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             "by Jaya Mahendra untuk submission 2 Dicoding",
//             style: TextStyle(fontSize: 18),
//           ),
//           RaisedButton(
//               color: Color(0xFFFF1744),
//               onPressed: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (context) => Home()));
//               },
//               child: Text(
//                 "Next",
//                 style: TextStyle(color: Colors.white),
//               ))
//         ],
//       ),
//     );
//   }
// }
