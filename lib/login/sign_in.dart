import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/resources/user_controller.dart';
import 'package:miindfully/subscription/subscription_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:page_transition/page_transition.dart';

import '../home.dart';
// import 'dart:convert';
// import 'package:miindfully/models/user_model.dart';

class SignIn extends StatefulWidget {
  final index;
  const SignIn({Key? key, this.index}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends StateMVC<SignIn> {
  UserController? con;
  final _formKey = GlobalKey<FormState>();
  bool isReadOnly = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  _SignInState() : super(UserController()) {
    con = controller as UserController;
  }
  bool flag = true;

  void loginTap() async {
    FocusScope.of(context).requestFocus(new FocusNode());

    if (_formKey.currentState!.validate()) {
      setState(() {
        flag = false;
      });
      con!.user.value.email = _emailController.text;
      con!.user.value.password = _passwordController.text;
      //con!.login();
      // if ("${_emailController.text}" ==
      //         "miindfully@creando.ca" &&
      //     "${_passwordController.text}" == "1hB6k@fV7") {
      //   var data = json.encode({
      //     "name": "Jake",
      //     "email": "miindfully@creando.ca",
      //     "createdDate": "${DateTime.now()}",
      //   });
      //
      //   await UserModel.saveStringPref(
      //       UserModel.prefUserData, json.encode(data));
      // } else
      //   ScaffoldMessenger.of(context).showSnackBar((SnackBar(
      //       content: Text(
      //           "Please enter correct email and password."))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        //autovalidate: false,
        key: _formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  color: Color(0xffFEF2EF),
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                  ),
                  child: TextFormField(
                    readOnly: isReadOnly,
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 11.5, horizontal: 10.0),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontWeight: FontWeight.w400,
                          height: (15 / 12),
                          // // fontFamily: "Roboto",
                        ),
                      ),
                      validator: (value) {
                        String pattern =
                            r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = new RegExp(pattern);

                        if (value == null || value.isEmpty) {
                          return 'Please enter a email';
                        } else if (value.length != 0 &&
                            !regExp.hasMatch(value.trim())) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      }),
                ),
                Container(
                  color: Color(0xffFEF2EF),
                  child: TextFormField(
                    readOnly: isReadOnly,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 11.5, horizontal: 10.0),
                      /* suffixIcon: IconButton(
                               iconSize: 18,
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(_passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)),*/
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Color(0XFF9D9D9D),
                        fontWeight: FontWeight.w400,
                        height: (15 / 12),
                        // // fontFamily: "Roboto",
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                ),
                flag ? Container() : Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
                  child: Container(color: Colors.transparent,
                    child: Center(child: CircularProgressIndicator()),),
                ),
                InkWell(
                  onTap: (){
                    if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && flag){
                      setState(() {
                        flag = false;
                        isReadOnly = true;
                      });
                      final body = {
                        "email": _emailController.text,
                        "password": _passwordController.text,
                        "deviceType": "APP",
                        "deviceToken" : "sdfgdfgd"
                      };
                      UserController().login(body).then((value){
                        setState(() {
                          isReadOnly = false;
                          flag = true;
                        });
                        if(value){
                          Navigator.of(context).push(PageTransition(
                              curve: Curves.decelerate,
                              type: PageTransitionType.rightToLeft,
                              child: SubscriptionScreen(index: widget.index,)));
                          /*Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => Home(userData: UserController().user.value, isSubscribed: true,)));*/
                        }
                      });
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 14,
                    decoration: BoxDecoration(
                      color: Color(0xffE1CA92),
                      borderRadius: BorderRadius.all(Radius.circular(
                        5.0,
                      )),
                    ),
                    margin: EdgeInsets.only(top: 25, bottom: 10),
                    alignment: Alignment.center,
                    child: AutoSizeText("Log In",
                        textAlign: TextAlign.center,
                        minFontSize: 20,
                        style: TextStyle(color: Colors.brown
                            // // ,fontFamily: "Roboto",
                            )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
