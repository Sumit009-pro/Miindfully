import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/item_details/item_list.dart';
import 'package:miindfully/login/get_started.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:miindfully/classes/home_menu.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeHeader extends StatefulWidget {
  final String? call;
  final UserModel? userData;
  final String? image;
  final String title;
  final String desc;

  const HomeHeader({
    Key? key,
    this.userData,
    this.call,
    this.image,
    required this.title, required this.desc,
  }) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int? userExist;
  Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
  var userData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    if (widget.userData != null)
      userExist = 1;
    else
      userExist = 0;
  }

  getUserData() async{
    final prefs = await sharedPrefs;
    setState(() {
      userData = jsonDecode(prefs.getString("userData")!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        /*Navigator.of(context).push(PageTransition(
            curve: Curves.decelerate,
            type: PageTransitionType.rightToLeft,
            child: ItemList(
              subCatId: "",
              userData: widget.userData,
              title: widget.title,
              image: widget.image,
            )));*/
      },
      child: Container(
        color: Colors.grey[200],
        height: MediaQuery.of(context).size.height / 3,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset("${widget.image}",
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height / 3),
            ),

            /* Positioned(
                top:0.0,
                left: 0.0,
                child:InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home(userData: widget.userData,)));
                    },
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Container(
                        margin: EdgeInsets.only(top:10),
                        child:Image.asset("assets/images/logo.png",height: 40,),
                      ),
                    )
                ),
              ),*/

            Visibility(
              visible: userExist == 1 && widget.call != null ? true : false,
              child: Positioned(
                top: 0.0,
                left: 0.0,
                child: InkWell(
                    onTap: () async {
                      var alertStyle = AlertStyle(
                        animationType: AnimationType.grow,
                        isButtonVisible: false,
                        isOverlayTapDismiss: true,
                        alertPadding: EdgeInsets.all(20),
                        descStyle:
                            TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                        animationDuration: Duration(milliseconds: 400),
                        alertBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.transparent),
                        ),
                        backgroundColor: Colors.black.withOpacity(0.2),
                        titleStyle: TextStyle(
                          color: Color(0xffE1CA92),
                          fontSize: 20,
                          // fontFamily: "Roboto"
                        ),
                      );

                      Alert(
                        context: context,
                        title: "",
                        style: alertStyle,
                        padding: EdgeInsets.zero,
                        content: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: HomeMenu(
                              userData: userData,
                            )),
                        buttons: [],
                      ).show();

                      // return await showDialog(
                      //   context: context,
                      //   builder: (_) {
                      //     return AlertDialog(
                      //         contentPadding: EdgeInsets.zero,
                      //         backgroundColor:Colors.yellow,//Color(0x00ffffff),
                      //         content: Container(
                      //             child: Menu(userData:widget.userData)
                      //         )
                      //     );
                      //   },
                      // );

                      /* showGeneralDialog(
                            barrierLabel: "Label",
                            barrierDismissible: true,
                            transitionDuration: Duration(milliseconds: 400),
                            context: context,
                            transitionBuilder: (context, anim1, anim2,widget) {

                              return Transform.scale(
                                  scale: anim1.value,
                                  alignment: Alignment.bottomRight,
                                  child:Align(
                                    alignment: Alignment.bottomRight,
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: Container(
                                        height:MediaQuery.of(context).size.height,
                                      //  margin: EdgeInsets.only(bottom: 120, left: 100,right: 10),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [

                                            GestureDetector(
                                              onTap:()async{
                                                await User.saveStringPref(User.prefUserData, "");
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
                                              },
                                              child: Container(
                                                child:AutoSizeText("Logout",
                                                  style: TextStyle(// fontFamily: "Roboto",),),
                                              ),
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              );
                            },
                            pageBuilder: (context, anim1, anim2) { return Container();}
                        );*/
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Container(
                          decoration: BoxDecoration(
                              color: Color(0xffFAD7A0), shape: BoxShape.circle),
                          margin: EdgeInsets.only(top: 10),
                          child: widget.userData == null
                              ? Container()
                              : Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.menu,
                                    size: 20,
                                  )) //Image.asset("${widget.userData?.image}",height: 40,),
                          ),
                    )),
              ),
            ),

            /* Visibility(
                  visible: widget.call!=null ? true : false,
                  child: Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: 50,
                    child:   Container(
                    //  color: Color(0xffFEF2EF),
                      child: AutoSizeText(" I am grateful for the resources that continue to show up to help me be a great parent. ",
                        textAlign:TextAlign.center,minFontSize:20,
                        style: TextStyle(// fontFamily: "Roboto",color: Colors.white,fontWeight: FontWeight.bold)),
                    ),
                  )
              ),*/

            SafeArea(
              child: Visibility(
                visible: widget.call != null ? false : true,
                child: Positioned(
                  top: 0.0,
                  left: 0.0,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: new Container(
                          //margin: EdgeInsets.only(top: 15),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )),
                ),
              ),
            ),
            Visibility(
              visible: userExist == 0 ? true : false,
              child: Positioned(
                top: 0.0,
                right: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new IconButton(
                      icon: Icon(
                        Icons.vpn_key,
                        color: Color(0xffFAD7A0),
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(PageTransition(
                            curve: Curves.decelerate,
                            type: PageTransitionType.rightToLeft,
                            child: GetStarted()));
                      }),
                ),
              ),
            ),
            Visibility(
              visible: widget.call != null ? true : false,
              child: Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          alert(
                              context,
                              widget.title,
                            widget.desc
                          );
                        })),
              ),
            ),
            Visibility(
              visible: widget.call != null ? true : false,
              child: Positioned(
                bottom: 50.0,
                left: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      if (widget.call != null)
                        Navigator.of(context).push(PageTransition(
                            curve: Curves.decelerate,
                            type: PageTransitionType.rightToLeft,
                            child: ItemList(
                              subCatId: "",
                              userData: widget.userData,
                              call: "FromHome",
                              title: widget.title,
                              image: widget.image,
                            )));
                    },
                    child: Container(
                      color: Color(0xffFAD7A0),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: AutoSizeText(
                        "Featured",
                        minFontSize: 15,
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.brown, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: AutoSizeText(
                    "${widget.title}",
                    minFontSize: 20,
                    softWrap: true,
                    style: TextStyle(
                        // // fontFamily: "Roboto",
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  alert(BuildContext context, String title, String desc) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      isButtonVisible: false,
      //  isCloseButton: false,
      //   isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey),
      ),
      titleStyle: TextStyle(color: Color(0xffE1CA92), fontSize: 20
        // , fontFamily: "Roboto"
      ),
    );

    return Alert(
      context: context,
      title: "$title",
      style: alertStyle,
      content: Container(
        margin: EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height / 10,
        width: MediaQuery.of(context).size.width,
        child: AutoSizeText(
          desc,
          style: TextStyle(
            // // fontFamily: "Roboto",
              color: Colors.black87),
        ),
      ),
      buttons: [],
    ).show();
  }
}
