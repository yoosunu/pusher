import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as parser;
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBasePage extends StatefulWidget {
  const DataBasePage({super.key, required this.title});

  final String title;

  @override
  State<DataBasePage> createState() => _DataBasePageState();
}

class _DataBasePageState extends State<DataBasePage> {
  // for reading from DB section
  late dynamic codesGet = [];
  late dynamic titlesGet = [];
  late dynamic linksGet = [];
  late dynamic maxCode = 0;

  // signup section
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController2 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  // realtime database config
  FirebaseDatabase database = FirebaseDatabase.instance;

  void getData() async {
    DataSnapshot snapshotMaxCode =
        await database.ref("info").child("codeMax").get();
    DataSnapshot snapshotCodesGet =
        await database.ref("info").child("codes").get();
    DataSnapshot snapshotTitlesGet =
        await database.ref("info").child("titles").get();
    DataSnapshot snapshotLinksGet =
        await database.ref("info").child("links").get();

    setState(() {
      maxCode = snapshotMaxCode.value;
      codesGet = snapshotCodesGet.value;
      titlesGet = snapshotTitlesGet.value;
      linksGet = snapshotLinksGet.value;
    });
    FirebaseDatabase.instance.setPersistenceEnabled(true);
  }

  @override
  void initState() {
    super.initState();
    final codesRef = FirebaseDatabase.instance.ref("info").child("codes");
    codesRef.keepSynced(true);
    final titlesRef = FirebaseDatabase.instance.ref("info").child("titles");
    titlesRef.keepSynced(true);
    final linksRef = FirebaseDatabase.instance.ref("info").child("links");
    linksRef.keepSynced(true);
    final codeMaxRef = FirebaseDatabase.instance.ref("info").child("codeMax");
    codeMaxRef.keepSynced(true);

    // Workmanager().initialize(callbackDispatcher);
    // schedulePeriodicTask();
    renderData();
  }

  Future<void> renderData() async {
    setState(() {
      getData();
    });
  }

  // signup section
  Future<void> _signUpWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController2.text,
        password: _passwordController2.text,
      );
      print('User signed up: ${userCredential.user}');
      _emailController2.clear();
      _passwordController2.clear();
      // 회원가입 성공 시 다음 화면으로 이동하거나 필요한 작업을 수행합니다.
    } on FirebaseAuthException catch (e) {
      print('Failed to sign up: $e');
      // 회원가입 실패 시 사용자에게 적절한 오류 메시지를 표시합니다.
    }
  }

  //popup for registering
  void registerPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              "Register Section",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          content: SizedBox(
            height: 300,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _emailController2,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _passwordController2,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _signUpWithEmailAndPassword(context);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Submit"),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 23, 0, 0),
                  child:
                      const Text("!! You can see notifications\nafter sign up"),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  //Popup for info of notifications
  void showPopup(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "${titlesGet[index]}",
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          content: ElevatedButton(
            onPressed: () {},
            child: InkWell(
              onTap: () async {
                final Uri url = Uri.parse(
                    'https://www.jbnu.ac.kr/kor/' '${linksGet[index]}');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch'
                      'https://www.jbnu.ac.kr/kor/'
                      '${linksGet[index]}';
                }
              },
              child: const Text(
                'Go to site to check!',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: null,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                10,
                10,
                10,
                0,
              ),
              child: SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 50)),
                  onPressed: () {},
                  child: const Text(
                    "Get the Notification!",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white10,
                padding: const EdgeInsets.fromLTRB(
                  10,
                  10,
                  10,
                  0,
                ),
                alignment: Alignment.center,
                child: ListView.builder(
                    itemCount: codesGet.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 55),
                            alignment: Alignment.center,
                          ),
                          onPressed: () {
                            showPopup(context, index);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${codesGet[index]}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  '${titlesGet[index]}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ]),
                        ),
                      );
                    }),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 246, 201, 216),
                  border: Border(
                      top: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  0,
                  10,
                  10,
                  10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 70,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[200],
                          side: const BorderSide(
                              color: Color.fromARGB(255, 232, 147, 141),
                              width: 2),
                          elevation: 5,
                          shadowColor: Colors.black.withOpacity(1),
                        ),
                        onPressed: () {},
                        child: Text(
                          "$maxCode",
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          registerPopup(context);
        },
        tooltip: 'Fetch',
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
