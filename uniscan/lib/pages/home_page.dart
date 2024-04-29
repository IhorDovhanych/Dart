import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma_squircle/figma_squircle.dart';
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

  void openQrCodeBox({String? docID}) async {
    if (docID == null) {
      nameTextController.clear();
      urlTextController.clear();
    } else {
      dynamic qrCode = await qrCodeService.getQrCodeById(docID);
      nameTextController.text = qrCode['name'];
      urlTextController.text = qrCode['url'];
    }
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: Column(
                children: [
                  if (docID == null)
                    const Text(
                      'Add qr code',
                      style: TextStyle(fontSize: 20),
                    )
                  else
                    const Text(
                      'Edit qr code',
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
                      if (docID == null) {
                        qrCodeService.addQrCode(qrCode);
                      } else {
                        qrCodeService.updateQrCode(docID, qrCode);
                      }
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
                  child: docID == null
                      ? const Text(
                          'Add',
                          style: TextStyle(color: Colors.black),
                        )
                      : const Text(
                          'Update',
                          style: TextStyle(
                              color:
                                  Colors.black), // Customize color for update
                        ),
                )
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
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          margin: const EdgeInsets.only(top: 20.0),
                          decoration: ShapeDecoration(
                              shape: SmoothRectangleBorder(
                                  borderRadius: SmoothBorderRadius(
                                      cornerRadius: 15, cornerSmoothing: 0.6)),
                              color: const Color.fromARGB(255, 200, 212, 255)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(name,
                                      style: const TextStyle(fontSize: 30),
                                      overflow: TextOverflow.ellipsis),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      alignment: Alignment.centerRight,
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () => qrCodeService
                                                .deleteQrCode(docID),
                                            icon: SvgPicture.asset(
                                              'assets/icons/delete.svg',
                                              // ignore: deprecated_member_use
                                              color: Colors.black,
                                              width: 30,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () =>
                                                openQrCodeBox(docID: docID),
                                            icon: SvgPicture.asset(
                                              'assets/icons/edit.svg',
                                              // ignore: deprecated_member_use
                                              color: Colors.black,
                                              width: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                      child: InkWell(
                                    onTap: () => launchUrl(Uri.parse(url)),
                                    child: Text("Url: $url ",
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis),
                                  ))
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                });
          } else {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator()); // Placeholder for loading indicator
          }
        },
      ),
    );
  }
}
