// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:pusher/pages/database.dart';
// // import 'package:pusher/pages/push.dart';
// // import 'package:provider/provider.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   String? messageTitle = "";
//   String? messageBody = "";

//   Future<void> _signInWithEmailAndPassword(BuildContext context) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       print('User signed in: ${userCredential.user}');
//       // Navigate to the new page after successful sign-in
//       Navigator.push(
//         // ignore: use_build_context_synchronously
//         context,
//         MaterialPageRoute(
//           builder: (context) => const DataBasePage(title: "Pusher"),
//         ), // Replace NewPage with your desired page
//       );
//       _emailController.clear();
//       _passwordController.clear();
//       // 로그인 성공 후 다음 화면으로 이동하거나 필요한 처리를 수행합니다.
//     } on FirebaseAuthException catch (e) {
//       print('Failed to sign in: $e');
//       // 로그인 실패에 대한 적절한 처리를 수행합니다.
//     }
//   }

//   @override
//   void initState() {
//     foregroundConfig();
//     super.initState();
//   }

//   void foregroundConfig() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       final notification = message.notification;
//       if (notification != null) {
//         messageTitle = notification.title;
//         messageBody = notification.body;
//         showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: const Text('New Added!'),
//                 content: Text('$messageTitle\n' '${message.sentTime}'),
//                 actions: <Widget>[
//                   TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: const Text('OK'))
//                 ],
//               );
//             });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Container(
//               padding: const EdgeInsets.all(20),
//               width: 350,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: Colors.purple[50], // Change the color as needed
//                 borderRadius: BorderRadius.circular(30),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5), // Color of the shadow
//                     spreadRadius: 1, // Spread radius
//                     blurRadius: 6, // Blur radius
//                     offset: const Offset(0, 1), // Changes position of shadow
//                   ),
//                 ], // Adjust the radius as needed
//               ),
//               child: Text(
//                 "Welcome to Pusher!",
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
//               child: SizedBox(
//                 width: 250,
//                 child: TextField(
//                   controller: _emailController,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Email',
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
//               child: SizedBox(
//                 width: 250,
//                 child: TextField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                   ),
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _signInWithEmailAndPassword(context);
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 child: Text(
//                   "Login",
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(30),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         tooltip: 'Increment',
//         child: const Icon(Icons.person_add),
//       ),
//     );
//   }
// }
