import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_whatsapp_stickers/flutter_whatsapp_stickers.dart';
import 'package:trendy_whatsapp_stickers/constants/colorconstants.dart';
import 'package:trendy_whatsapp_stickers/utils.dart';
import 'package:trendy_whatsapp_stickers/sticker_pack_info.dart';

class StaticContent extends StatefulWidget {
  @override
  _StaticContentState createState() => _StaticContentState();
}

class _StaticContentState extends State<StaticContent> {
  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerOpen = false;

  final WhatsAppStickers _waStickers = WhatsAppStickers();
  // ignore: deprecated_member_use
  List stickerList = new List();
  // ignore: deprecated_member_use
  List installedStickers = new List();

  void _loadStickers() async {
    String data =
        await rootBundle.loadString("sticker_packs/sticker_packs.json");
    final response = json.decode(data);
    // ignore: deprecated_member_use
    List tempList = new List();

    for (int i = 0; i < response['sticker_packs'].length; i++) {
      tempList.add(response['sticker_packs'][i]);
    }
    setState(() {
      stickerList.addAll(tempList);
    });
    _checkInstallationStatuses();
  }

  void _checkInstallationStatuses() async {
    print("Total Stickers : ${stickerList.length}");
    for (var j = 0; j < stickerList.length; j++) {
      var tempName = stickerList[j]['identifier'];
      bool tempInstall =
          await WhatsAppStickers().isStickerPackInstalled(tempName);

      if (tempInstall == true) {
        if (!installedStickers.contains(tempName)) {
          setState(() {
            installedStickers.add(tempName);
          });
        }
      } else {
        if (installedStickers.contains(tempName)) {
          setState(() {
            installedStickers.remove(tempName);
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadStickers();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: ListView.builder(
          itemCount: stickerList.length,
          itemBuilder: (context, index) {
            if (stickerList.length == 0) {
              return Container(
                child: CircularProgressIndicator(),
              );
            } else {
              var stickerId = stickerList[index]['identifier'];
              var stickerName = stickerList[index]['name'];
              var stickerPublisher = stickerList[index]['publisher'];
              var stickerTrayIcon = stickerList[index]['tray_image_file'];
              // ignore: deprecated_member_use
              var tempStickerList = List();

              bool stickerInstalled = false;
              if (installedStickers.contains(stickerId)) {
                stickerInstalled = true;
              } else {
                stickerInstalled = false;
              }
              tempStickerList.add(stickerList[index]['identifier']);
              tempStickerList.add(stickerList[index]['name']);
              tempStickerList.add(stickerList[index]['publisher']);
              tempStickerList.add(stickerList[index]['tray_image_file']);
              tempStickerList.add(stickerList[index]['stickers']);
              tempStickerList.add(stickerInstalled);
              tempStickerList.add(installedStickers);

              return stickerPack(
                tempStickerList,
                stickerName,
                stickerPublisher,
                stickerId,
                stickerTrayIcon,
                stickerInstalled,
              );
            }
          }),
    );
  }

  Widget stickerPack(List stickerList, String name, String publisher,
      String identifier, String stickerTrayIcon, bool installed) {
    Widget depInstallWidget;
    if (installed == true) {
      depInstallWidget = IconButton(
        icon: Icon(
          Icons.check,
        ),
        color: Colors.teal,
        tooltip: 'Add Sticker to WhatsApp',
        onPressed: () {},
      );
    } else {
      depInstallWidget = IconButton(
        icon: Icon(
          Icons.add,
        ),
        color: Colors.teal,
        tooltip: 'Add Sticker to WhatsApp',
        onPressed: () async {
          _waStickers.addStickerPack(
            packageName: WhatsAppPackage.Consumer,
            stickerPackIdentifier: identifier,
            stickerPackName: name,
            listener: (action, result, {error}) => processResponse(
              action: action,
              result: result,
              error: error,
              successCallback: () async {
                _checkInstallationStatuses();
              },
              context: context,
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        print(identifier);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) =>
              StickerPackInformation(stickerList),
        ));
      },
      child: Container(
        height: 160,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: (identifier == '3')
                          ? kPrimaryColor
                          : (identifier == '2')
                              ? Colors.orange
                              : (identifier == '4')
                                  ? Colors.amber
                                  : (identifier == '5')
                                      ? Colors.tealAccent
                                      : (identifier == '6')
                                          ? Colors.purpleAccent
                                          : Colors.blueAccent,
                      // identifier == '3'
                      //     ? kPrimaryColor
                      //     : Colors.brown, //Colors.blueGrey[300],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: shadowList,
                    ),
                    margin: EdgeInsets.only(top: 50),
                  ),
                  Align(
                    child: Image.asset(
                        "sticker_packs/$identifier/$stickerTrayIcon"),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(top: 60, bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowList,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            "$name",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Circular",
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      Expanded(child: depInstallWidget),
                    ],
                  ),
                  Text(
                    "$publisher",
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
