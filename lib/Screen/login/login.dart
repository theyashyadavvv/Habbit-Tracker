// import 'package:flutter/material.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFFA8D5BA), // Pale Green
//                 Color(0xFFECE5C7), // Ecru
//                 Color(0xFFD4B59E), // Soft Brown
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 SizedBox(height: screenHeight * 0.05),
//                 const Padding(
//                   padding: EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         "Login",
//                         style: TextStyle(color: Colors.white, fontSize: 40),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         "Welcome Back",
//                         style: TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   constraints: BoxConstraints(
//                     maxHeight: screenHeight * 0.75,
//                   ),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(60),
//                       topRight: Radius.circular(60),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth * 0.1,
//                       vertical: screenHeight * 0.03,
//                     ),
//                     child: Column(
//                       children: <Widget>[
//                         const SizedBox(height: 20),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: const [
//                               BoxShadow(
//                                 color: Color.fromRGBO(225, 95, 27, .3),
//                                 blurRadius: 20,
//                                 offset: Offset(0, 10),
//                               ),
//                             ],
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             children: <Widget>[
//                               Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: const BoxDecoration(
//                                   border: Border(
//                                     bottom: BorderSide(color: Colors.grey),
//                                   ),
//                                 ),
//                                 child: const TextField(
//                                   decoration: InputDecoration(
//                                     hintText: "Email or Phone number",
//                                     hintStyle: TextStyle(color: Colors.grey),
//                                     border: InputBorder.none,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: const BoxDecoration(
//                                   border: Border(
//                                     bottom: BorderSide(color: Colors.grey),
//                                   ),
//                                 ),
//                                 child: const TextField(
//                                   decoration: InputDecoration(
//                                     hintText: "Password",
//                                     hintStyle: TextStyle(color: Colors.grey),
//                                     border: InputBorder.none,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         const Text(
//                           "Forgot Password?",
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         const SizedBox(height: 20),
//                         Container(
//                           height: 50,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             color: Color.fromARGB(
//                                 255, 100, 134, 100), // Minty Fresh Color
//                           ),
//                           child: const Center(
//                             child: Text(
//                               "Login",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         const Text(
//                           "Continue with social media",
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           children: <Widget>[
//                             Expanded(
//                               child: Container(
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(50),
//                                   color: const Color.fromARGB(255, 100, 134, 1),
//                                 ),
//                                 child: const Center(
//                                   child: Text(
//                                     "Facebook",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 20),
//                             Expanded(
//                               child: Container(
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(50),
//                                   color:
//                                       const Color.fromARGB(255, 100, 134, 100),
//                                 ),
//                                 child: const Center(
//                                   child: Text(
//                                     "Google",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
