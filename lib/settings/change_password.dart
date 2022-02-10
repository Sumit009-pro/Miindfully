import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
                "Change Password",
                minFontSize: 25,
                style: TextStyle(
                    // fontFamily: "Roboto",
                    color: Colors.grey),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
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
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 20,
                          ),
                          color: Color(0xffFEF2EF),
                          child: TextFormField(
                            controller: _oldPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 11.5, horizontal: 10.0),
                              hintText: 'Old Password',
                              hintStyle: TextStyle(
                                color: Color(0XFF9D9D9D),
                                fontWeight: FontWeight.w400,
                                height: (15 / 12),
                                // fontFamily: "Roboto",
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
                          margin: EdgeInsets.only(
                            bottom: 20,
                          ),
                          color: Color(0xffFEF2EF),
                          child: TextFormField(
                            controller: _newPasswordController,
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
                              hintText: 'New Password',
                              hintStyle: TextStyle(
                                color: Color(0XFF9D9D9D),
                                fontWeight: FontWeight.w400,
                                height: (15 / 12),
                                // fontFamily: "Roboto",
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
                                // fontFamily: "Roboto",
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter confirm password';
                              } else if (value != null &&
                                  _newPasswordController.text !=
                                      _confirmPasswordController.text) {
                                return 'Password not matched with confirm password';
                              }
                              return null;
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            if (_formKey.currentState!.validate()) {}
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 14,
                            decoration: BoxDecoration(
                              color: Color(0xffE1CA92),
                              borderRadius: BorderRadius.all(Radius.circular(
                                5.0,
                              )),
                            ),
                            margin: EdgeInsets.only(top: 35, bottom: 10),
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              "Continue",
                              textAlign: TextAlign.center,
                              minFontSize: 20,
                              style: TextStyle(
                                  // fontFamily: "Roboto",
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
          ],
        ),
      ),
    );
  }
}
