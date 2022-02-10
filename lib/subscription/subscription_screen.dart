import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:miindfully/models/picture.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:miindfully/resources/user_controller.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_extensions/string_extensions.dart';

import '../home.dart';

class SubscriptionScreen extends StatefulWidget {
  final index;
  const SubscriptionScreen({Key? key, this.index})
      : super(key: key);

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
  UserController con = UserController();
  bool flag = true;
  List subscriptionsTypeList = [];
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async{
    final prefs = await sharedPrefs;
    //userData = jsonDecode(prefs.getString("userData")!);
    final body = {"_id": prefs.getString("userID")};
    con.getSubscriptionType(body).then((value){
      setState(() {
        print(value);
        subscriptionsTypeList = value;
        flag = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xffFEF2EF),
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Home(
                              userData: UserController().user.value,
                              isSubscribed: false, index: widget.index,)));
                      },
                      child: CircleAvatar(
                          child: Icon(
                            Icons.close,
                            size: MediaQuery.of(context).size.height * 0.05,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
                    child: Text("Become a Premium",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.height * 0.03
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          //text: 'Get full access to Miindfully',
                          style: TextStyle(
                              color: Colors.black54
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Get full access to Miindfully with',),
                            TextSpan(text: '\nPremium Subscription',)
                          ]
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),),
                  subscriptionsTypeList.length == 0 ?
                      Center(child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Loading Plans..."),
                          ),
                        ],
                      ),) :
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: subscriptionsTypeList.length,
                    itemBuilder: (BuildContext context, int index){
                      return Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.025),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Container(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(subscriptionsTypeList[index]["subcription_type"]??"",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: MediaQuery.of(context).size.height * 0.022
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            style: TextStyle(
                                                color: Colors.black
                                            ),
                                            //text: 'Get full access to Miindfully',
                                            children: <TextSpan>[
                                              TextSpan(text: subscriptionsTypeList[index]["currency"],
                                                  style: TextStyle(
                                                      fontSize: MediaQuery.of(context).size.height * 0.02,
                                                      fontWeight: FontWeight.w300
                                                  )
                                              ),
                                              TextSpan(text: '${subscriptionsTypeList[index]["amount"]}',
                                                style: TextStyle(
                                                    fontSize: MediaQuery.of(context).size.height * 0.03,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                              /*TextSpan(text: '/month',
                                                  style: TextStyle(
                                                      fontSize: MediaQuery.of(context).size.height * 0.025,
                                                      fontWeight: FontWeight.w400
                                                  )
                                              )*/
                                            ]
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text("Recurring ${subscriptionsTypeList[index]["subcription_type"]} billing",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          //fontSize: MediaQuery.of(context).size.height * 0.02
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: (){

                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.02,
                                            vertical: MediaQuery.of(context).size.height * 0.015),
                                        decoration: BoxDecoration(
                                            color: Color(0xfff7c36e),
                                            borderRadius: BorderRadius.circular(25)
                                        ),
                                        child: Center(
                                          child: Text("Subscribe", ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  )
                ],
              ),
              flag ? Container() : Container(
                color: Colors.black12,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
