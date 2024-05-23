// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pusher/sqldbinit.dart';
import 'package:url_launcher/url_launcher.dart';

class PusherPage extends StatefulWidget {
  const PusherPage({super.key, required this.title});

  final String title;

  @override
  State<PusherPage> createState() => _PusherPageState();
}

class _PusherPageState extends State<PusherPage> {
  DatabaseHelper dbHelper = DatabaseHelper();

  List<Map<String, dynamic>> _storedData = [];
  bool _isLoading = true;

  Future<void> getData() async {
    List<Map<String, dynamic>> data = await dbHelper.getStoredData();
    setState(() {
      _storedData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Delete all notices?'),
                  action: SnackBarAction(
                    label: 'DELETE',
                    onPressed: () async {
                      await dbHelper.resetStoredTable();
                      setState(() {
                        _isLoading = true;
                        getData();
                      });
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.delete),
          ),
          const Padding(padding: EdgeInsets.all(12))
        ],
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _storedData.isEmpty
                ? const Text('No Data')
                : ListView.builder(
                    itemCount: _storedData.length,
                    itemBuilder: (context, index) {
                      var item = _storedData[index];
                      var dateTime = DateTime.tryParse(
                          item[DatabaseHelper.secondColumnTimeStamp]);
                      var formattedDate = dateTime != null
                          ? DateFormat('yyyy-MM-dd – kk:mm').format(dateTime)
                          : 'Invalid Date';
                      return Container(
                        color: Colors.deepPurple[50],
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () async {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 200,
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            leading: const Icon(Icons.info),
                                            title: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 10, 0, 0),
                                              child: Text(
                                                item[DatabaseHelper
                                                    .secondColumnTitle],
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          ListTile(
                                            leading:
                                                const Icon(Icons.open_in_new),
                                            title: const Text('Go to site'),
                                            onTap: () async {
                                              Navigator.of(context).pop();
                                              final Uri url = Uri.parse(
                                                  'https://www.jbnu.ac.kr/kor/${item[DatabaseHelper.secondColumnLink]}');
                                              if (await canLaunchUrl(url)) {
                                                await launchUrl(url);
                                              }
                                            },
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.delete),
                                            title: const Text('Delete'),
                                            onTap: () async {
                                              await dbHelper.deleteNotification(
                                                  item[DatabaseHelper
                                                      .secondColumnCode]);
                                              setState(() {
                                                getData();
                                              });
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: const Text(
                                                      'Notice was deleted'),
                                                  action: SnackBarAction(
                                                    label: 'ok',
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ))),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(3, 0, 0, 10),
                                child: ListTile(
                                  title: Text(
                                    item[DatabaseHelper.secondColumnTitle],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        item[DatabaseHelper.secondColumnCode]
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(width: 15),
                                      Text(
                                        'Saved: $formattedDate',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  trailing: ElevatedButton(
                                    onPressed: () async {
                                      final Uri url = Uri.parse(
                                          'https://www.jbnu.ac.kr/kor/${item[DatabaseHelper.secondColumnLink]}');
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      }
                                    },
                                    child: const Text("Go"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Refresh',
      //   child: const Icon(Icons.details),
      // ),
    );
  }
}
