import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miindfully/home.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/get_started.dart';

Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
SharedPreferences? prefs;
void main() async {
  //prefs = await sharedPrefs;
  final w = WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  print(w);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool splashProcess = true;
  var expanded = false;
  final transitionDuration = Duration(seconds: 1);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2))
        .then((value) => setState(() => expanded = true))
        .then((value) => Duration(seconds: 2))
        .then((value) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          splashProcess = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Miindfully',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: "Euclid Circular A",
            primarySwatch: Colors.brown,
            primaryColor: Color(0xffFAD7A0),
            // secondaryHeaderColor:,
            scaffoldBackgroundColor: Color(0xffFEF2EF),
            bottomAppBarColor: Color(0xffFAD7A0)),
        home:
        Scaffold(
            body: splashProcess
                ? Container(
                    color: Colors.white,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedCrossFade(
                            firstCurve: Curves.fastOutSlowIn,
                            crossFadeState: expanded
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: transitionDuration,
                            firstChild: Container(
                              child: Image.asset(
                                  "assets/images/mindfully_logo.jpg",
                                  width: 200),
                            ),
                            secondChild: Container(),
                            alignment: Alignment.centerLeft,
                            sizeCurve: Curves.easeInOut,
                          ),
                          AnimatedCrossFade(
                            firstCurve: Curves.fastOutSlowIn,
                            crossFadeState: expanded
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: transitionDuration,
                            firstChild: Container(),
                            secondChild: _logoRemainder(),
                            alignment: Alignment.centerLeft,
                            sizeCurve: Curves.easeInOut,
                          ),
                        ],
                      ),
                    ),
                  )
                : FutureBuilder<UserModel?>(
                    future: UserModel.readStringPref(UserModel.prefUserData),
                    builder: contentBuilder)));
  }

  Widget _logoRemainder() {
    return Container(
        margin: EdgeInsets.only(left: 10),
        child: Image.asset("assets/images/logo.png", width: 50));
  }

  Widget contentBuilder(
      BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
    return snapshot.connectionState == ConnectionState.done
        ? (snapshot.hasData
            ? Home(userData: snapshot.data)
            : GetStarted(call: "Login", index: 0,))
        : Container(
            color: Colors.white,
            child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Container(
                      child: Image.asset("assets/images/mindfully_logo.jpg",
                          width: 200)),
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Image.asset("assets/images/logo.png", width: 50))
                ])));
  }
}
