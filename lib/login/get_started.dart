import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/login/lost_password.dart';
import 'package:miindfully/login/sign_in.dart';
import 'package:miindfully/login/sign_up.dart';
import 'package:page_transition/page_transition.dart';

class GetStarted extends StatefulWidget {
  final String? call;
  final index;
  const GetStarted({Key? key, this.call, this.index}) : super(key: key);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFEF2EF),
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
              color: Color(0xffFEF2EF),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: widget.call == null ? true : false,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Container(
                          child: Icon(
                            Icons.close,
                            size: 30.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: MediaQuery.of(context).size.height / 6,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: AutoSizeText(
                      "Sign In",
                      minFontSize: 25,
                      style: TextStyle(
                          // // fontFamily: "Roboto",
                          color: Colors.grey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: SignIn(index: widget.index,),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageTransition(
                          curve: Curves.decelerate,
                          type: PageTransitionType.rightToLeft,
                          child: LostPassword()));
                    },
                    child: Container(
                      child: AutoSizeText(
                        "Lost password?",
                        style: TextStyle(
                          // // fontFamily: "Roboto",
                          color: Color(0xffE1CA92),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    width: MediaQuery.of(context).size.width / 4,
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    child: AutoSizeText(
                      "New to Miindfully?",
                      minFontSize: 20,
                      style: TextStyle(
                          // // fontFamily: "Roboto",
                          color: Colors.grey),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageTransition(
                          curve: Curves.decelerate,
                          type: PageTransitionType.rightToLeft,
                          child: SignUp()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      child: AutoSizeText(
                        "Sign Up",
                        minFontSize: 18,
                        style: TextStyle(
                            // // fontFamily: "Roboto",
                            color: Color(0xffE1CA92)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
