import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uniscan/models/qr_code.dart';
import 'package:uniscan/services/qr_code_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final QrCodeService qrCodeService = QrCodeService();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController urlTextController = TextEditingController();

  void openQrCodeBox() {
    nameTextController.clear();
    urlTextController.clear();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: Column(
                children: [
                  const Text(
                    'Add qr code',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextField(
                    controller: nameTextController,
                    decoration: const InputDecoration(
                        labelText: 'Name', hintText: 'Qr code name'),
                  ),
                  TextField(
                    controller: urlTextController,
                    decoration: const InputDecoration(
                        labelText: 'Url', hintText: 'https://example.com'),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      try {
                        QrCode qrCode = QrCode(
                            name: nameTextController.text,
                            url: urlTextController.text);
                        qrCodeService.addQrCode(qrCode);
                        Navigator.pop(context);
                      } catch (err) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text(err.toString()),
                                ));
                        urlTextController.clear();
                      }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30.0, top: 28.0),
              child: SvgPicture.asset(
                'assets/svg/logo_col.svg',
                height: 45,
              ),
            )
          ],
        ),
        actions: [
          Container(
              width: 40,
              height: 50,
              margin: const EdgeInsets.only(right: 30.0, top: 31.0),
              decoration: const BoxDecoration(color: Colors.transparent),
              child: SvgPicture.asset('assets/icons/menu_open.svg')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: openQrCodeBox,
          shape:
              const CircleBorder(side: BorderSide(color: Colors.transparent)),
          backgroundColor: const Color.fromARGB(255, 61, 94, 170),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: StreamBuilder<QuerySnapshot>(
        stream: qrCodeService.getQrCodesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List qrCodesList = snapshot.data!.docs;

            return ListView.builder(
                itemCount: qrCodesList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = qrCodesList[index];
                  String docID = document.id;

                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String name = data['name'];
                  String url = data['url'];
                  return ListBody(
                    children: [
                      Row(
                        children: [
                          Text("Name: $name "),
                          InkWell(
                            onTap: () => launchUrl(Uri.parse(url)),
                            child: Text("Url: $url "),
                          )
                        ],
                      )
                    ],
                  );
                });
          } else {
            return CircularProgressIndicator(); // Placeholder for loading indicator
          }
        },
      ),
    );
  }
}
