import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/settings/change_password.dart';
import 'package:page_transition/page_transition.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
        backgroundColor: Color(0xffFAD7A0),
        elevation: 1.0,
        title: Text(
          "Settings",
          style: TextStyle(
              // fontFamily: "FuturaHeavy",
              color: Colors.black),
        ),
      ),
      body: Container(
        color: Color(0xffFEF2EF),
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(PageTransition(
                    curve: Curves.decelerate,
                    type: PageTransitionType.rightToLeft,
                    child: ChangePassword()));
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: AutoSizeText(
                        "Change Password",
                        minFontSize: 18,
                        style: TextStyle(
                            // fontFamily: "Roboto",color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                    Container(
                      child: Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
