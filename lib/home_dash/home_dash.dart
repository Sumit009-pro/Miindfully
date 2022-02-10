import 'dart:convert';
import 'dart:ui';
import 'package:miindfully/home_dash/category_details.dart';
import 'package:miindfully/resources/user_controller.dart';
import 'package:miindfully/subscription/subscription_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDash extends StatefulWidget {
  final UserModel? userData;
  final isSubscribed;
  const HomeDash({Key? key, this.userData, this.isSubscribed}) : super(key: key);

  @override
  _HomeDashState createState() => _HomeDashState();
}

class _HomeDashState extends StateMVC<HomeDash> {
  UserController con = UserController();
  Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
  var userData = {};
  List categoriesList = [];
  bool flag = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 50), () {
      getCategories();
      fetchAllBanners();
    });
    super.initState();
  }

  void getCategories() async{
    final prefs = await sharedPrefs;
    userData = jsonDecode(prefs.getString("userData")!);
    final body = {"_id": prefs.getString("userID")};
    await con.waitForCategories(body).then((value){
      setState(() {
        categoriesList = value;
        flag = true;
      });
    });
  }

  Future fetchAllBanners() async{
    final prefs = await sharedPrefs;
    final body = {
      "_id": prefs.getString("userID")
    };
    await con.waitForBannersList(body).then((value){
      setState(() {
        bannersList = value;
        //flag = true;
      });
    });
    return bannersList;
  }

  alert(BuildContext context, String title) {
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
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          style: TextStyle(
              // // fontFamily: "Roboto",
              color: Colors.black87),
        ),
      ),
      buttons: [],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Image.asset("assets/images/logo.png",
                      color: Color(0xffFEF2EF),
                      colorBlendMode: BlendMode.plus,
                      height: MediaQuery.of(context).size.height / 2.5,
                    ),
                  ),
                ),
                SingleChildScrollView(
                    //padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(elevation: 5,
                            color: Colors.green,
                            child: Column(
                              children: [
                                Text('❞',
                                  style: TextStyle(
                                      color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.height * 0.05
                                  ),
                                ),
                                Container(
                                    //color: Colors.white,
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, bottom: 5, top: 5),
                                    child: AutoSizeText(
                                        ' I am grateful for the resources that continue to show up to help me be a great parent... ',
                                        textAlign: TextAlign.center,
                                        minFontSize: 18,
                                        style: TextStyle(
                                            // // fontFamily: "Roboto",
                                            //fontStyle: FontStyle.italic,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400)),
                                    height: MediaQuery.of(context).size.height / 8),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        !flag ? Center(child: Padding(
                          padding: const EdgeInsets.all(100.0),
                          child: CircularProgressIndicator(),
                        ),) :
                        categoriesList.isEmpty
                            ? Text("No Categories")
                            : ListView.builder(
                                shrinkWrap: true,
                                controller: ScrollController(),
                                //physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async{
                                      final prefs = await sharedPrefs;
                                      Navigator.of(context).push(PageTransition(
                                          curve: Curves.decelerate,
                                          type: PageTransitionType.rightToLeft,
                                          child: CategoryDetails(
                                            userData: widget.userData,
                                            catId: categoriesList[index]['_id'],

                                            title: userData["name"] +
                                                "'s " +
                                                categoriesList[index]['name'],
                                            userId: prefs.getString("userID")??"",
                                            index: index,
                                          )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 10,
                                        child: Container(
                                          color: Color(0xffFAD7A0),
                                          //height: MediaQuery.of(context).size.height *0.2,
                                          width: double.infinity,
                                          child: Row(mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    child: categoriesList[index]['image']
                                                            .startsWith("http")
                                                        ? Image.network(
                                                        categoriesList[index]['image'],
                                                            fit: BoxFit.fill,
                                                            // height: MediaQuery.of(context)
                                                            //         .size
                                                            //         .height /
                                                            //     2.5,
                                                            // width: MediaQuery.of(context)
                                                            //     .size
                                                            //     .width
                                                    )
                                                        :
                                                    Padding(
                                                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                                                      child: CircleAvatar(
                                                        radius: 50,
                                                        backgroundColor: Colors.white,
                                                        backgroundImage: AssetImage(index < 3 ? con.images[index] : con.images[index%3]),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        color:
                                                            Color(0xffFAD7A0),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: AutoSizeText(
                                                        userData["name"] +
                                                            "'s " +
                                                            categoriesList[index]['name'],
                                                        minFontSize: 18,
                                                        softWrap: true,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            // // fontFamily: "Roboto",
                                                            color: Colors.brown,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              /*Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    alert(
                                                        context,
                                                        userData["name"] +
                                                            "'s " +
                                                            categoriesList[index]['name']);
                                                  },
                                                  child: Container(
                                                    child: Icon(
                                                      Icons.info_outline,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                              )*/
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: categoriesList.length),
                        //   SizedBox(
                        //       child: InkWell(
                        //         onTap: () {
                        //           Navigator.of(context).push(PageTransition(
                        //               curve: Curves.decelerate,
                        //               type: PageTransitionType.rightToLeft,
                        //               child: CategoryDetails(
                        //                 userData: widget.userData,
                        //                 index: 0,
                        //                 title: "Tate’s Miindful Pick of the Day",
                        //               )));
                        //         },
                        //         child: Container(
                        //           color: Color(0xffFAD7A0),
                        //           width: MediaQuery.of(context).size.width,
                        //           child: Stack(
                        //             children: [
                        //               Align(
                        //                 alignment: Alignment.centerRight,
                        //                 child: Container(
                        //                   child: Image.asset("assets/images/fav2.jpg",
                        //                       fit: BoxFit.fill,
                        //                       height:
                        //                           MediaQuery.of(context).size.height /
                        //                               2.5,
                        //                       width:
                        //                           MediaQuery.of(context).size.width),
                        //                 ),
                        //               ),
                        //               Align(
                        //                   alignment: Alignment.bottomLeft,
                        //                   child: Container(
                        //                     margin: EdgeInsets.only(
                        //                         left: 10, bottom: 10, right: 10),
                        //                     child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.spaceBetween,
                        //                       children: [
                        //                         Container(
                        //                           decoration: BoxDecoration(
                        //                             borderRadius: BorderRadius.all(
                        //                                 Radius.circular(5)),
                        //                             color: Color(0xffFAD7A0),
                        //                           ),
                        //                           padding: EdgeInsets.all(5),
                        //                           width: MediaQuery.of(context)
                        //                                   .size
                        //                                   .width /
                        //                               1.6,
                        //                           child: AutoSizeText(
                        //                             "Tate’s Miindful Pick of the Day",
                        //                             minFontSize: 15,
                        //                             softWrap: true,
                        //                             textAlign: TextAlign.center,
                        //                             style: TextStyle(
                        //                                 // // fontFamily: "Roboto",
                        //                                 color: Colors.brown,
                        //                                 fontWeight: FontWeight.bold),
                        //                           ),
                        //                         ),
                        //                         InkWell(
                        //                           onTap: () {
                        //                             alert(context,
                        //                                 "Tate’s Miindful Pick of the Day");
                        //                           },
                        //                           child: Container(
                        //                             child: Icon(
                        //                               Icons.info_outline,
                        //                               color: Colors.white,
                        //                               size: 30,
                        //                             ),
                        //                           ),
                        //                         )
                        //                       ],
                        //                     ),
                        //                   )),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       height: MediaQuery.of(context).size.height / 4),
                        //   SizedBox(height: 10),
                        //   SizedBox(
                        //       child: InkWell(
                        //         onTap: () {
                        //           Navigator.of(context).push(PageTransition(
                        //               curve: Curves.decelerate,
                        //               type: PageTransitionType.rightToLeft,
                        //               child: CategoryDetails(
                        //                 userData: widget.userData,
                        //                 index: 1,
                        //                 title: "Tate’s Miindful Mantras",
                        //               )));
                        //         },
                        //         child: Container(
                        //           color: Color(0xffFAD7A0),
                        //           width: MediaQuery.of(context).size.width,
                        //           child: Stack(
                        //             children: [
                        //               Align(
                        //                 alignment: Alignment.centerRight,
                        //                 child: Container(
                        //                   child: Image.asset(
                        //                     "assets/images/mantra4.jpg",
                        //                     fit: BoxFit.fill,
                        //                     height:
                        //                         MediaQuery.of(context).size.height /
                        //                             2.5,
                        //                     width: MediaQuery.of(context).size.width,
                        //                   ),
                        //                 ),
                        //               ),
                        //               Align(
                        //                 alignment: Alignment.bottomLeft,
                        //                 child: Container(
                        //                   margin: EdgeInsets.only(
                        //                       left: 10, bottom: 10, right: 10),
                        //                   child: Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                     children: [
                        //                       Container(
                        //                         decoration: BoxDecoration(
                        //                           borderRadius: BorderRadius.all(
                        //                               Radius.circular(5)),
                        //                           color: Color(0xffFAD7A0),
                        //                         ),
                        //                         padding: EdgeInsets.all(5),
                        //                         width: MediaQuery.of(context)
                        //                                 .size
                        //                                 .width /
                        //                             1.6777216,
                        //                         child: Text(
                        //                           "Tate’s Miindful Mantras",
                        //                           // minFontSize: 10,
                        //                           softWrap: true,
                        //                           textAlign: TextAlign.center,
                        //                           style: TextStyle(
                        //                               fontSize: 14.4115188075855872,
                        //                               color: Colors.brown,
                        //                               fontWeight: FontWeight.bold),
                        //                         ),
                        //                       ),
                        //                       InkWell(
                        //                         onTap: () {
                        //                           alert(context,
                        //                               "Tate’s Miindful Mantras");
                        //                         },
                        //                         child: Container(
                        //                           child: Icon(
                        //                             Icons.info_outline,
                        //                             color: Colors.white,
                        //                             size: 30,
                        //                           ),
                        //                         ),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       height: MediaQuery.of(context).size.height / 4),
                        //   SizedBox(height: 10),
                        //   SizedBox(
                        //       child: InkWell(
                        //         onTap: () {
                        //           Navigator.of(context).push(PageTransition(
                        //               curve: Curves.decelerate,
                        //               type: PageTransitionType.rightToLeft,
                        //               child: CategoryDetails(
                        //                 userData: widget.userData,
                        //                 index: 2,
                        //                 title: "Tate’s Miindful Adventures",
                        //               )));
                        //         },
                        //         child: Container(
                        //           color: Color(0xffFAD7A0),
                        //           width: MediaQuery.of(context).size.width,
                        //           child: Stack(
                        //             children: [
                        //               Align(
                        //                 alignment: Alignment.centerRight,
                        //                 child: Container(
                        //                   child: Image.asset(
                        //                     "assets/images/adventure4.jpg",
                        //                     fit: BoxFit.fill,
                        //                     height:
                        //                         MediaQuery.of(context).size.height /
                        //                             2.5,
                        //                     width: MediaQuery.of(context).size.width,
                        //                   ),
                        //                 ),
                        //               ),
                        //               Align(
                        //                 alignment: Alignment.bottomLeft,
                        //                 child: Container(
                        //                   margin: EdgeInsets.only(
                        //                       left: 10, bottom: 10, right: 10),
                        //                   child: Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                     children: [
                        //                       Container(
                        //                         decoration: BoxDecoration(
                        //                           borderRadius: BorderRadius.all(
                        //                               Radius.circular(5)),
                        //                           color: Color(0xffFAD7A0),
                        //                         ),
                        //                         margin: EdgeInsets.only(
                        //                             left: 5, bottom: 10),
                        //                         padding: EdgeInsets.all(5),
                        //                         width: MediaQuery.of(context)
                        //                                 .size
                        //                                 .width /
                        //                             1.6777216,
                        //                         child: Text(
                        //                           "Tate’s Miindful Adventures",
                        //                           // minFontSize: 10,
                        //                           softWrap: true,
                        //                           textAlign: TextAlign.center,
                        //                           style: TextStyle(
                        //                               fontSize: 14.4115188075855872,
                        //                               color: Colors.brown,
                        //                               fontWeight: FontWeight.bold),
                        //                         ),
                        //                       ),
                        //                       InkWell(
                        //                         onTap: () {
                        //                           alert(context,
                        //                               "Tate’s Miindful Adventures");
                        //                         },
                        //                         child: Container(
                        //                           child: Icon(
                        //                             Icons.info_outline,
                        //                             color: Colors.white,
                        //                             size: 30,
                        //                           ),
                        //                         ),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       height: MediaQuery.of(context).size.height / 4),
                        //   SizedBox(height: 10),
                        //   SizedBox(
                        //       child: InkWell(
                        //         onTap: () {
                        //           Navigator.of(context).push(PageTransition(
                        //               curve: Curves.decelerate,
                        //               type: PageTransitionType.rightToLeft,
                        //               child: CategoryDetails(
                        //                 userData: widget.userData,
                        //                 index: 3,
                        //                 title: "Tate’s Miindful Breathing",
                        //               )));
                        //         },
                        //         child: Container(
                        //           color: Color(0xffFAD7A0),
                        //           width: MediaQuery.of(context).size.width,
                        //           child: Stack(
                        //             children: [
                        //               Align(
                        //                 alignment: Alignment.centerRight,
                        //                 child: Container(
                        //                   child: Image.asset(
                        //                     "assets/images/adventure6.jpg",
                        //                     fit: BoxFit.fill,
                        //                     height:
                        //                         MediaQuery.of(context).size.height /
                        //                             2.5,
                        //                     width: MediaQuery.of(context).size.width,
                        //                   ),
                        //                 ),
                        //               ),
                        //               Align(
                        //                 alignment: Alignment.bottomLeft,
                        //                 child: Container(
                        //                   margin: EdgeInsets.only(
                        //                       left: 10, bottom: 10, right: 10),
                        //                   child: Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                     children: [
                        //                       Container(
                        //                         decoration: BoxDecoration(
                        //                           borderRadius: BorderRadius.all(
                        //                               Radius.circular(5)),
                        //                           color: Color(0xffFAD7A0),
                        //                         ),
                        //                         padding: EdgeInsets.all(5),
                        //                         width: MediaQuery.of(context)
                        //                                 .size
                        //                                 .width /
                        //                             2.048,
                        //                         child: AutoSizeText(
                        //                           "Tate’s Miindful Breathing",
                        //                           minFontSize: 12,
                        //                           softWrap: true,
                        //                           textAlign: TextAlign.center,
                        //                           style: TextStyle(
                        //                               // // fontFamily: "Roboto",
                        //                               color: Colors.brown,
                        //                               fontWeight: FontWeight.bold),
                        //                         ),
                        //                       ),
                        //                       InkWell(
                        //                         onTap: () {
                        //                           alert(context,
                        //                               "Tate’s Miindful Breathing");
                        //                         },
                        //                         child: Container(
                        //                           child: Icon(
                        //                             Icons.info_outline,
                        //                             color: Colors.white,
                        //                             size: 30,
                        //                           ),
                        //                         ),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       height: MediaQuery.of(context).size.height / 4),
                        //   SizedBox(height: 10),
                        //   SizedBox(
                        //       child: InkWell(
                        //         onTap: () {
                        //           Navigator.of(context).push(PageTransition(
                        //               curve: Curves.decelerate,
                        //               type: PageTransitionType.rightToLeft,
                        //               child: CategoryDetails(
                        //                 userData: widget.userData,
                        //                 index: 4,
                        //                 title: "Tate’s Miindful Music",
                        //               )));
                        //         },
                        //         child: Container(
                        //           color: Color(0xffFAD7A0),
                        //           width: MediaQuery.of(context).size.width,
                        //           child: Stack(
                        //             children: [
                        //               Align(
                        //                 alignment: Alignment.centerRight,
                        //                 child: Container(
                        //                   child: Image.asset(
                        //                     "assets/images/mountain.jpg",
                        //                     fit: BoxFit.fill,
                        //                     height:
                        //                         MediaQuery.of(context).size.height /
                        //                             2.5,
                        //                     width: MediaQuery.of(context).size.width,
                        //                   ),
                        //                 ),
                        //               ),
                        //               Align(
                        //                 alignment: Alignment.bottomLeft,
                        //                 child: Container(
                        //                   margin: EdgeInsets.only(
                        //                       left: 10, bottom: 10, right: 10),
                        //                   child: Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                     children: [
                        //                       Container(
                        //                         decoration: BoxDecoration(
                        //                           borderRadius: BorderRadius.all(
                        //                               Radius.circular(5)),
                        //                           color: Color(0xffFAD7A0),
                        //                         ),
                        //                         padding: EdgeInsets.all(5),
                        //                         width: MediaQuery.of(context)
                        //                                 .size
                        //                                 .width /
                        //                             2.048,
                        //                         child: AutoSizeText(
                        //                           "Tate’s Miindful Music",
                        //                           minFontSize: 12,
                        //                           softWrap: true,
                        //                           textAlign: TextAlign.center,
                        //                           style: TextStyle(
                        //                               // // fontFamily: "Roboto",
                        //                               color: Colors.brown,
                        //                               fontWeight: FontWeight.bold),
                        //                         ),
                        //                       ),
                        //                       InkWell(
                        //                         onTap: () {
                        //                           alert(context,
                        //                               "Tate’s Miindful Music");
                        //                         },
                        //                         child: Container(
                        //                           child: Icon(
                        //                             Icons.info_outline,
                        //                             color: Colors.white,
                        //                             size: 30,
                        //                           ),
                        //                         ),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       height: MediaQuery.of(context).size.height / 4),
                        //   SizedBox(height: 10),
                        //   SizedBox(
                        //       child: InkWell(
                        //         onTap: () {
                        //           Navigator.of(context).push(PageTransition(
                        //               curve: Curves.decelerate,
                        //               type: PageTransitionType.rightToLeft,
                        //               child: CategoryDetails(
                        //                 userData: widget.userData,
                        //                 index: 5,
                        //                 title: "Tate’s Miindful Seasons",
                        //               )));
                        //         },
                        //         child: Container(
                        //           color: Color(0xffFAD7A0),
                        //           width: MediaQuery.of(context).size.width,
                        //           child: Stack(
                        //             children: [
                        //               Align(
                        //                 alignment: Alignment.centerRight,
                        //                 child: Container(
                        //                   child: Image.asset(
                        //                     "assets/images/fiords.jpg",
                        //                     fit: BoxFit.fill,
                        //                     height:
                        //                         MediaQuery.of(context).size.height /
                        //                             2.5,
                        //                     width: MediaQuery.of(context).size.width,
                        //                   ),
                        //                 ),
                        //               ),
                        //               Align(
                        //                 alignment: Alignment.bottomLeft,
                        //                 child: Container(
                        //                   margin: EdgeInsets.only(
                        //                       left: 10, bottom: 10, right: 10),
                        //                   child: Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                     children: [
                        //                       Container(
                        //                         decoration: BoxDecoration(
                        //                           borderRadius: BorderRadius.all(
                        //                               Radius.circular(5)),
                        //                           color: Color(0xffFAD7A0),
                        //                         ),
                        //                         padding: EdgeInsets.all(5),
                        //                         width: MediaQuery.of(context)
                        //                                 .size
                        //                                 .width /
                        //                             2.048,
                        //                         child: AutoSizeText(
                        //                           "Tate’s Miindful Seasons",
                        //                           minFontSize: 12,
                        //                           softWrap: true,
                        //                           textAlign: TextAlign.center,
                        //                           style: TextStyle(
                        //                               // // fontFamily: "Roboto",
                        //                               color: Colors.brown,
                        //                               fontWeight: FontWeight.bold),
                        //                         ),
                        //                       ),
                        //                       InkWell(
                        //                         onTap: () {
                        //                           alert(context,
                        //                               "Tate’s Miindful Seasons");
                        //                         },
                        //                         child: Container(
                        //                           child: Icon(
                        //                             Icons.info_outline,
                        //                             color: Colors.white,
                        //                             size: 30,
                        //                           ),
                        //                         ),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       height: MediaQuery.of(context).size.height / 4)
                      ],
                    )),
              ],
            ),
            backgroundColor: Color(0xffFEF2EF)));
  }
}
