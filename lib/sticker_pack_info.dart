import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp_stickers/flutter_whatsapp_stickers.dart';
import 'package:trendy_whatsapp_stickers/constants/colorconstants.dart';
import 'package:trendy_whatsapp_stickers/utils.dart';

class StickerPackInformation extends StatefulWidget {
  final List stickerPack;

  StickerPackInformation(this.stickerPack);
  @override
  _StickerPackInformationState createState() =>
      _StickerPackInformationState(stickerPack);
}

class _StickerPackInformationState extends State<StickerPackInformation> {
  List stickerPack;
  final WhatsAppStickers _waStickers = WhatsAppStickers();

  _StickerPackInformationState(this.stickerPack); //constructor

  void _checkInstallationStatuses() async {
    print("Total Stickers : ${stickerPack.length}");
    var tempName = stickerPack[0];
    bool tempInstall =
        await WhatsAppStickers().isStickerPackInstalled(tempName);

    if (tempInstall == true) {
      if (!stickerPack[6].contains(tempName)) {
        setState(() {
          stickerPack[6].add(tempName);
        });
      }
    } else {
      if (stickerPack[6].contains(tempName)) {
        setState(() {
          stickerPack[6].remove(tempName);
        });
      }
    }
    print("${stickerPack[6]}");
  }

  @override
  Widget build(BuildContext context) {
    List totalStickers = stickerPack[4];
    // ignore: deprecated_member_use
    List<Widget> fakeBottomButtons = new List<Widget>();
    fakeBottomButtons.add(
      Container(
        height: 50.0,
      ),
    );
    Widget depInstallWidget;
    if (stickerPack[5] == true) {
      depInstallWidget = Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
          onTap: () {
            print(stickerPack[0]);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/images/whatsapp-icon-logo.png')),
              SizedBox(
                width: 5,
              ),
              Text("Already Added",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18)), // TextStyle(
              //     color: Colors.green,
              //     fontSize: 16.0,
              //     fontWeight: FontWeight.bold,
              //     fontFamily: 'Roboto'),
            ],
          ),
        ),
      );
    } else {
      depInstallWidget = SizedBox(
        height: 60,
        // ignore: deprecated_member_use
        child: GestureDetector(
          onTap: () async {
            _waStickers.addStickerPack(
              packageName: WhatsAppPackage.Consumer,
              stickerPackIdentifier: stickerPack[0],
              stickerPackName: stickerPack[1],
              listener: (action, result, {error}) => processResponse(
                action: action,
                result: result,
                error: error,
                successCallback: () async {
                  setState(() {
                    _checkInstallationStatuses();
                  });
                },
                context: context,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: primaryGreen, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/images/whatsapp-icon-logo.png'),
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Add to WhatsApp",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),
        ),
        // textColor: Colors.white,
        // color: Colors.teal[900],
      );
    }
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
            child: Column(
          children: [
            Expanded(
              child: Container(
                //color: kPrimaryColor
                color: (stickerPack[0] == '3')
                    ? kPrimaryColor
                    : (stickerPack[0] == '2')
                        ? Colors.orange
                        : (stickerPack[0] == '4')
                            ? Colors.amber
                            : (stickerPack[0] == '5')
                                ? Colors.tealAccent
                                : (stickerPack[0] == '6')
                                    ? Colors.purpleAccent
                                    : Colors.blueAccent,
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                  ),
                  itemCount: totalStickers.length,
                  itemBuilder: (context, index) {
                    var stickerImg =
                        "sticker_packs/${stickerPack[0]}/${totalStickers[index]['image_file']}";
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        stickerImg,
                        width: 100,
                        height: 100,
                      ),
                    );
                  }),
            )
          ],
        )),
        // Container(
        //   margin: EdgeInsets.only(top: 40),
        //   child: Align(
        //     alignment: Alignment.topCenter,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         IconButton(
        //             icon: Icon(Icons.arrow_back_ios),
        //             onPressed: () {
        //               Navigator.pop(context);
        //             }),
        //         IconButton(icon: Icon(Icons.share), onPressed: () {})
        //       ],
        //     ),
        //   ),
        // ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Align(
            alignment: Alignment.topCenter,
            child: Hero(
                tag: 1,
                child: Image.asset(
                    "sticker_packs/${stickerPack[0]}/${stickerPack[3]}")),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 100,
            width: 500,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowList,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Text(
                    "${stickerPack[1]} Stickers",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Circular",
                        fontSize: 30,
                        color: Colors.black),
                  ),
                  Text(
                    "${stickerPack[2]}",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 120,
            child: Row(
              children: [
                // Container(
                //   height: 60,
                //   width: 70,
                //   decoration: BoxDecoration(
                //       color: primaryGreen,
                //       borderRadius: BorderRadius.circular(20)),
                //   child: Icon(
                //     Icons.favorite_border,
                //     color: Colors.white,
                //   ),
                // ),
                // SizedBox(
                //   width: 10,
                // ),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: primaryGreen,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: depInstallWidget,
                      //     child: Text(
                      //   'Adoption',
                      //   style: TextStyle(color: Colors.white, fontSize: 24),
                      // )
                    ),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
          ),
        )
      ],
    ));

    /*Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        title: Text("${stickerPack[1]} Stickers"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "sticker_packs/${stickerPack[0]}/${stickerPack[3]}",
                  width: 100,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${stickerPack[1]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[900],
                      ),
                    ),
                    Text(
                      "${stickerPack[2]}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                    ),
                    depInstallWidget,
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                ),
                itemCount: totalStickers.length,
                itemBuilder: (context, index) {
                  var stickerImg =
                      "sticker_packs/${stickerPack[0]}/${totalStickers[index]['image_file']}";
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      stickerImg,
                      width: 100,
                      height: 100,
                    ),
                  );
                }),
          ),
        ],
      ),
      persistentFooterButtons: fakeBottomButtons,
    );*/
  }
}
//http://kethod.com/apps/trending-stickers/privacy-policy.html