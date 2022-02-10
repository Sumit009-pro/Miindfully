import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class LostPassword extends StatefulWidget {
  const LostPassword({Key? key}) : super(key: key);

  @override
  _LostPasswordState createState() => _LostPasswordState();
}

class _LostPasswordState extends State<LostPassword> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

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
                "Lost Password",
                minFontSize: 25,
                style: TextStyle(
                    // // fontFamily: "Roboto",
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
                          color: Color(0xffFEF2EF),
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 11.5, horizontal: 10.0),
                                border: OutlineInputBorder(),
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
                        InkWell(
                          onTap: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            if (_formKey.currentState!.validate()) {
                              /* if("${_emailController.text}"=="miindfully@creando.ca" && "${_passwordController.text}"=="1hB6k@fV7"){

                                        var data = json.encode({
                                          "name": "Jake",
                                          "image": "assets/images/profile.png",
                                          "email":"miindfully@creando.ca",
                                          "createdDate":"${DateTime.now()}",
                                          "dateOfBirth":"2000-10-05",
                                          "gender":"Male"
                                        });

                                        await User.saveStringPref(User.prefUserData, json.encode(data));

                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home(userData:User.fromJson(json.decode(data)) ,)));

                                      }
                                      else
                                        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                                            content: Text("Please enter correct email and password."))));*/
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
                            margin: EdgeInsets.only(top: 35, bottom: 10),
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              "Continue",
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
          ],
        ),
      ),
    );
  }
}
