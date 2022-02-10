import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/login/get_started.dart';
import 'package:miindfully/login/sign_in.dart';
import 'package:miindfully/resources/user_controller.dart';
import 'package:miindfully/subscription/subscription_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:page_transition/page_transition.dart';

import '../home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends StateMVC<SignUp> {
  UserController? con;
  final _formKey = GlobalKey<FormState>();
  bool flag = true;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  _SignUpState() : super(UserController()) {
    con = controller as UserController;
  }

  void registerTap() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState!.validate()) {
      con!.user.value.email = _emailController.text;
      con!.user.value.password = _passwordController.text;
      con!.user.value.name = _nameController.text;
      //con!.register();
      // if("${_emailController.text}"=="miindfully@creando.ca" && "${_passwordController.text}"=="1hB6k@fV7"){
      //
      //                                   var data = json.encode({
      //                                     "name": "Jake",
      //                                     "image": "assets/images/profile.png",
      //                                     "email":"miindfully@creando.ca",
      //                                     "createdDate":"${DateTime.now()}",
      //                                     "dateOfBirth":"2000-10-05",
      //                                     "gender":"Male"
      //                                   });
      //
      //                                   await User.saveStringPref(User.prefUserData, json.encode(data));
      //
      //                                 }
      //                                 else

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xffFEF2EF),
        child: ListView(
          shrinkWrap: true,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 15),
                  child: Icon(
                    Icons.close,
                    size: 30.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              child: Image.asset(
                "assets/images/logo.png",
                height: MediaQuery.of(context).size.height / 6,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
              child: AutoSizeText(
                "Sign Up",
                minFontSize: 25,
                style: TextStyle(
                    // // fontFamily: "Roboto",
                    color: Colors.grey),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
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
                            bottom: 10,
                          ),
                          child: TextFormField(
                              readOnly: !flag,
                              controller: _nameController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 11.5, horizontal: 10.0),
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                  color: Color(0XFF9D9D9D),
                                  fontWeight: FontWeight.w400,
                                  height: (15 / 12),
                                  // // fontFamily: "Roboto",
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a name';
                                }
                                return null;
                              }),
                        ),
                        Container(
                          color: Color(0xffFEF2EF),
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: TextFormField(
                              readOnly: !flag,
                              controller: _emailController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 20,
                          ),
                          color: Color(0xffFEF2EF),
                          child: TextFormField(
                            readOnly: !flag,
                            controller: _passwordController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        Container(
                          color: Color(0xffFEF2EF),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            readOnly: !flag,
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 11.5, horizontal: 10.0),
                              border: OutlineInputBorder(),
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                color: Color(0XFF9D9D9D),
                                fontWeight: FontWeight.w400,
                                height: (15 / 12),
                                // // fontFamily: "Roboto",
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter confirm password';
                              } else if (
                                  _passwordController.text !=
                                      _confirmPasswordController.text) {
                                return 'Password not matched with confirm password';
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
                            if(_formKey.currentState!.validate() && flag){
                              setState(() {
                                flag = false;
                              });
                              final body = {
                                "name": _nameController.text,
                                "email": _emailController.text,
                                "password": _passwordController.text,
                                "deviceType": "APP",
                              };
                              UserController().register(body).then((value){
                                setState(() {
                                  flag = true;
                                });
                                if(value){
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    Navigator.of(context).push(PageTransition(
                                        curve: Curves.decelerate,
                                        type: PageTransitionType.rightToLeft,
                                        child: GetStarted(call: "Login", index: 4,)));
                                  });
                                  /*
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => Home(userData: UserController().user.value, isSubscribed: false,)));*/
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
                            child: AutoSizeText(
                              "Sign Up",
                              textAlign: TextAlign.center,
                              minFontSize: 20,
                              style: TextStyle(
                                  // // fontFamily: "Roboto",
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: AutoSizeText(
                "Already have an account?",
                minFontSize: 20,
                style: TextStyle(
                    // // fontFamily: "Roboto",
                    color: Colors.grey),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 25),
                child: AutoSizeText(
                  "Sign In",
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
    );
  }
}
