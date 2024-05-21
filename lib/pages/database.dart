// import 'package:flutter/material.dart';
// // import 'pages/home.dart';
// import 'pages/push.dart';
// import 'pages/database.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'firebase_options.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as parser;
// import 'package:workmanager/workmanager.dart';

// FirebaseDatabase database = FirebaseDatabase.instance;
// dynamic codes = [];
// dynamic titles = [];
// dynamic links = [];

// Future<void> fetchData() async {
//   var url = Uri.parse('https://www.jbnu.ac.kr/kor/?menuID=139');
//   var url2 = Uri.parse('https://www.jbnu.ac.kr/kor/?menuID=139&pno=2');
//   var response = await http.get(url);
//   var response2 = await http.get(url2);

//   if (response.statusCode == 200) {
//     // page 1
//     var document = parser.parse(response.body);
//     var noticesPage1 = document.getElementsByTagName('tr');

//     for (var noticePage1 in noticesPage1) {
//       var mnoms = noticePage1.getElementsByClassName('mnom');
//       var anchors = noticePage1.getElementsByTagName('a');

//       for (var i = 0; i < mnoms.length; i++) {
//         var mnom = mnoms[i];
//         var anchor = anchors[i];
//         if (mnom.text.isNotEmpty) {
//           codes.add(mnom.text);
//           titles.add(anchor.text);
//           links.add(anchor.attributes['href']);
//         }
//       }
//     }

//     // // page 2
//     var document2 = parser.parse(response2.body);
//     var noticesPage2 = document2.getElementsByTagName('tr');

//     for (var noticePage2 in noticesPage2) {
//       var mnoms = noticePage2.getElementsByClassName('mnom');
//       var anchors = noticePage2.getElementsByTagName('a');
//       for (var i = 0; i < mnoms.length; i++) {
//         var mnom = mnoms[i];
//         var anchor = anchors[i];
//         if (mnom.text.isNotEmpty) {
//           codes.add(mnom.text);
//           titles.add(anchor.text);
//           links.add(anchor.attributes['href']);
//         }
//       }
//     }
//   }
// }

// void updateData() async {
//   print("Updating data...");
//   try {
//     await database.ref().child("info").update({
//       "codes": codes,
//       "titles": titles,
//       "links": links,
//       "codeMax": codes.first,
//       "test": 1
//     });
//   } catch (e) {
//     print("Error updating data: $e");
//   }

//   FirebaseDatabase.instance.setPersistenceEnabled(true);
// }

// @pragma('vm:entry-point')
// void callbackDispatcher() async {
//   Workmanager().executeTask((task, inputData) async {
//     await fetchData();
//     updateData();
//     print("workmanager init!");
//     return Future.value(true);
//   });
// }

// void schedulePeriodicTask() {
//   Workmanager().registerPeriodicTask(
//     "periodicTask",
//     "periodicTaskTag",
//     frequency: const Duration(seconds: 10),
//     inputData: <String, dynamic>{},
//   );
// }

// // background section

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   Workmanager().initialize(callbackDispatcher);
//   schedulePeriodicTask();

//   // ignore: unused_local_variable
//   final fcmToken = await FirebaseMessaging.instance.getToken();
//   FirebaseMessaging.instance.requestPermission(
//     badge: true,
//     alert: true,
//     sound: true,
//   );
//   if (await Permission.notification.isDenied) {
//     await Permission.notification.request();
//   }

//   // making channel high priority
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_priority_Channel',
//     'High Priority Notifications',
//     importance: Importance.high,
//   );

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   // foreground section
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const DataBasePage(
//         title: 'Pusher',
//       ),
//       routes: <String, WidgetBuilder>{
//         '/push': (BuildContext context) =>
//             const PusherPage(title: 'Pusher Page'),
//         '/db': (BuildContext context) =>
//             const DataBasePage(title: 'Building...'),
//         // '/c': (BuildContext context) => const MyPage(title: Text('page C')),
//       },
//     );
//   }
// }
