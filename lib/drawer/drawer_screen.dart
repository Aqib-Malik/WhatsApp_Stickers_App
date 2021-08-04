import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('WhatsApp Stickers'),
            accountEmail: Text('hmaqib92@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //     image: AssetImage('assets/images/welcome1.jpg')),
            ),
          ),
          GestureDetector(
            onTap: () {
              launch("mailto:hmaqib92@gmail.com?subject=Hi&body=");
            },
            child: ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Feedback'),
            ),
          ),
          GestureDetector(
            onTap: () {
              launch("mailto:hmaqib92@gmail.com?subject=Hi&body=");
            },
            child: ListTile(
              leading: Icon(Icons.emoji_nature),
              title: Text('Request for more stickers'),
            ),
          ),
        ],
      ),
    );
  }
}
