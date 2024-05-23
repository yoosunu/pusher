// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:pusher/sqldbinit.dart';
// import 'package:url_launcher/url_launcher.dart';

// class PusherPage extends StatefulWidget {
//   const PusherPage({super.key, required this.title});

//   final String title;

//   @override
//   State<PusherPage> createState() => _PusherPageState();
// }

// class _PusherPageState extends State<PusherPage> {
//   DatabaseHelper dbHelper = DatabaseHelper();

//   List<Map<String, dynamic>> _storedData = [];
//   bool _isLoading = true;

//   Future<void> getData() async {
//     List<Map<String, dynamic>> data = await dbHelper.getStoredData();
//     setState(() {
//       _storedData = data;
//       _isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//         actions: <Widget>[
//           IconButton(
//             onPressed: () async {
//               await dbHelper.resetStoredTable();
//               setState(() {
//                 _isLoading = true;
//                 getData();
//               });
//             },
//             icon: const Icon(Icons.delete),
//           ),
//           const Padding(padding: EdgeInsets.all(12))
//         ],
//       ),
//       body: Center(
//         child: _isLoading
//             ? const CircularProgressIndicator()
//             : _storedData.isEmpty
//                 ? const Text('No Data')
//                 : ListView.builder(
//                     itemCount: _storedData.length,
//                     itemBuilder: (context, index) {
//                       var item = _storedData[index];
//                       var dateTime = DateTime.tryParse(
//                           item[DatabaseHelper.secondColumnTimeStamp]);
//                       var formattedDate = dateTime != null
//                           ? DateFormat('yyyy-MM-dd – kk:mm').format(dateTime)
//                           : 'Invalid Date';
//                       return Container(
//                         color: Colors.purple[50],
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(3, 0, 0, 10),
//                               child: ListTile(
//                                 title: Text(
//                                   item[DatabaseHelper.secondColumnTitle],
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 subtitle: Row(
//                                   children: [
//                                     Text(
//                                       item[DatabaseHelper.secondColumnCode]
//                                           .toString(),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     const SizedBox(width: 35),
//                                     Text(
//                                       'Saved: $formattedDate',
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ],
//                                 ),
//                                 trailing: ElevatedButton(
//                                   onPressed: () async {
//                                     final Uri url = Uri.parse(
//                                         'https://www.jbnu.ac.kr/kor/${item[DatabaseHelper.secondColumnLink]}');
//                                     if (await canLaunchUrl(url)) {
//                                       await launchUrl(url);
//                                     }
//                                   },
//                                   child: const Text("Go"),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {},
//       //   tooltip: 'Refresh',
//       //   child: const Icon(Icons.refresh),
//       // ),
//     );
//   }
// }
