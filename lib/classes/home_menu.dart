import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/home.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:miindfully/profile/manage_profiles.dart';
import 'package:miindfully/settings/settings.dart';
import 'package:miindfully/shop/product_lists.dart';
import 'package:page_transition/page_transition.dart';

class HomeMenu extends StatefulWidget {
  final userData;

  const HomeMenu({Key? key, this.userData}) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageTransition(
                              curve: Curves.decelerate,
                              type: PageTransitionType.rightToLeft,
                              child: ManageProfiles()));
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 5, bottom: 5, right: 5),
                                child: AutoSizeText(
                                  "Manage Profiles",
                                  minFontSize: 18,
                                  style: TextStyle(
                                      // // fontFamily: "Roboto",
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                child: InkWell(
                  onTap: () {
                    /*  Navigator.of(context).push(PageTransition(curve: Curves.decelerate,type: PageTransitionType.rightToLeft,
                          child:Profile(userData:widget.userData,call:"From Home")));*/
                  },
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Image.asset(
                            "assets/images/profile.png",
                            height: 25,
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: AutoSizeText(
                              "${widget.userData["name"]}",
                              minFontSize: 18,
                              style: TextStyle(
                                  // // fontFamily: "Roboto",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      curve: Curves.decelerate,
                      type: PageTransitionType.rightToLeft,
                      child: Settings()));
                },
                child: Container(
                    margin: EdgeInsets.only(top: 30, bottom: 15, left: 25),
                    child: AutoSizeText(
                      "Settings",
                      style: TextStyle(
                          // // fontFamily: "Roboto",
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      curve: Curves.decelerate,
                      type: PageTransitionType.rightToLeft,
                      child: ProductLists(
                        userData: widget.userData,
                      )));
                },
                child: Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 25),
                    child: AutoSizeText(
                      "Shop",
                      style: TextStyle(
                          // // fontFamily: "Roboto",
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15, left: 25),
                  child: AutoSizeText(
                    "About",
                    style: TextStyle(
                        // // fontFamily: "Roboto",
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15, left: 25),
                  child: AutoSizeText(
                    "Support",
                    style: TextStyle(
                        // // fontFamily: "Roboto",
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
              InkWell(
                onTap: () async {
                  await UserModel.saveStringPref(UserModel.prefUserData, "");
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Home()));
                },
                child: Container(
                    margin: EdgeInsets.only(top: 25, left: 25),
                    child: AutoSizeText(
                      "Logout",
                      minFontSize: 17,
                      style: TextStyle(
                          // // fontFamily: "Roboto",
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ));
  }
}
