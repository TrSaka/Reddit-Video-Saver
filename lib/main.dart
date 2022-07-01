// ignore_for_file: sort_child_properties_last, prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings
import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redditsaver/Pages/DownloadPage.dart';
import 'package:redditsaver/Pages/MainPage.dart';
import 'package:redditsaver/dialog/dialoghelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    debug: true,
    ignoreSsl: true,
  );
  runApp(MainGame());
}

class MainGame extends StatelessWidget {
  const MainGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Uri url = Uri.parse(text);
  getDataAndDownload() async {
    final response = await get(Uri.parse(text));
    final jsonData = jsonDecode(response.body);

    var myfile = jsonData[0]["data"]["children"][0]["data"]["secure_media"]
        ["reddit_video"]["fallback_url"];

    var myJpg = jsonData[0]["data"]["children"][0]["data"]["thumbnail"];
    var myTitle = jsonData[0]["data"]["children"][0]["data"]["title"];

    setState(() {
      jsonData;
      myfile;
      myJpg;
      myTitle;
      debugPrint(myfile);
      debugPrint(myJpg);
      debugPrint(myTitle);
    });

    //
    //
    //
    final status = await Permission.storage.request();
    if (status.isGranted) {
      debugPrint("Accepted");
      final baseStorage = await getExternalStorageDirectory();
      final id = await FlutterDownloader.enqueue(
          url: myfile, savedDir: baseStorage!.path, fileName: 'video');
    } else {
      debugPrint("Access Denied");
    }
  }

  int progress = 0;
  ReceivePort receivePort = ReceivePort();

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, "downloadingvideo");
    receivePort.listen((message) {
      setState(() {
        progress = message;
      });
    });
    // TODO: implement initState
    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
    controller1.text = "";
    text = "";
  }

  static downloadCallback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloadingvideo");
    sendPort?.send(progress);
  }

  TextEditingController controller1 = TextEditingController();
  var text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange.shade900,
        elevation: 0,
        title: Text(
          "Reddit Video Saver",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 85,
                    backgroundImage: AssetImage(
                      "assets/images/logo.png",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    "Enter your post link here !",
                    style: TextStyle(
                        color: Colors.orange.shade900,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller1,
                  cursorColor: Colors.orange.shade900,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "reddit video link",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade900,
                      ),
                    ),
                    labelText: "Paste yor link here...",
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    if (controller1.text.length > 2) {
                      text = controller1.text
                              .substring(0, controller1.text.length - 1) +
                          ".json";
                      debugPrint(text);
                      getDataAndDownload();
                    } else {}
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: Icon(
                      Icons.download,
                      color: Colors.green,
                      size: 64,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
