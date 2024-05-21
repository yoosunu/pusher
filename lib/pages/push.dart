// import 'package:flutter/material.dart';
// import 'package:pusher/pages/database.dart';
// // import 'package:workmanager/workmanager.dart';

// class PusherPage extends StatefulWidget {
//   const PusherPage({super.key, required this.title});

//   final String title;

//   @override
//   State<PusherPage> createState() => _PusherPageState();
// }

// class _PusherPageState extends State<PusherPage> {
//   var count = 0;

//   @override
//   void initState() {
//     super.initState();
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
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               '$count',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             TextButton(
//                 onPressed: () {
//                   setState(() {});
//                 },
//                 child: const Text("Workmanager start!"))
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     const DataBasePage(title: "DatabasePage")),
//           );
//         },
//         tooltip: 'Change',
//         child: const Icon(Icons.send),
//       ),
//     );
//   }
// }
