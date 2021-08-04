//import 'package:firebase_admob/firebase_admob.dart';

//import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
//import 'package:trendy_whatsapp_stickers/Widgets/Drawer.dart';
import 'package:trendy_whatsapp_stickers/constants/colorconstants.dart';
import 'package:trendy_whatsapp_stickers/drawer/drawer_screen.dart';
//import 'package:trendy_whatsapp_stickers/mob_add/ad_helper.dart';
import 'package:trendy_whatsapp_stickers/sticker_list.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'WhatsApp Stickers';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primaryColor: primaryGreen,
        fontFamily: 'Circular',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
          image: Image.asset(
            'assets/images/logo.png', //welcome1.jpg',
            height: 90,
          ),
          seconds: 5,
          photoSize: 150.0,
          title: new Text(
            'Welcome In \nWhatsApp Stickers',
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
                fontFamily: "Lobster",
                color: primaryGreen),
          ),
          backgroundColor: Colors.white,
          loaderColor: primaryGreen,
          navigateAfterSeconds: MyHomePage()),
    ); //MyHomePage(),
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //BannerAd _add;
  //bool _isLoaded;

  @override
  // @override
  // void initState() {
  //   super.initState();
  //   AdmobAd.initialize();
  //   AdmobAd.showBannerAd();
  // }

  // @override
  // void dispose() {
  //   AdmobAd.hideBannerAd();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    //List<Widget> fakeBottomButtons = new List<Widget>();
    // fakeBottomButtons.add(
    //   Container(
    //     height: 50.0,
    //   ),
    // );
    return Scaffold(
      //backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        title: Text("WhatsApp Stickers"),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: NavBar(), //MyDrawer(),
      body: StaticContent(),
      // drawer: Drawer(
      //   child: MyDrawer(),
      // ),
      //persistentFooterButtons: fakeBottomButtons,
    );
  }
}
//5.1.1