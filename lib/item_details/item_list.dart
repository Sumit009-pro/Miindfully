import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/bluetooth/bluetooth_screen.dart';
import 'package:miindfully/classes/home_header.dart';
import 'package:miindfully/home.dart';
import 'package:miindfully/item_details/playback.dart';
import 'package:miindfully/login/get_started.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:miindfully/resources/user_controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_blue/flutter_blue.dart';

class ItemList extends StatefulWidget {
  final UserModel? userData;
  final String subCatId;
  final String? call;
  final String? title;
  final String? image;
  const ItemList({Key? key, this.userData, this.call, this.title, this.image, required this.subCatId})
      : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  //FlutterBlue flutterBlue = FlutterBlue.instance;
  Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
  UserController con = UserController();
  bool minimize = false;
  bool play = true;
  List childrenList = [];
  var snackBar = SnackBar(
    content: Text('Yay! A SnackBar!'),
  );
  List<dynamic> itemList = [
    {
      "image": "assets/images/fav1.jpg",
      "title": "The Wooden Ladder",
      "ages": "4-5",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "7m"
    },
    {
      "image": "assets/images/fav2.jpg",
      "title": "Twisty Slide",
      "ages": "6-8",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "12m"
    },
    {
      "image": "assets/images/fav3.jpg",
      "title": "Golden Plank Bridges",
      "ages": "All ages",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "21m"
    },
    {
      "image": "assets/images/fav4.jpg",
      "title": "Wobbly Table",
      "ages": "All ages",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "11m"
    },
  ];
  var subCategoriesDetails = {};
  bool showDialog = false;
  bool showLoader = true;
  bool addToFavoritesFlag = false;
  var childId = '';
  var catId = '';
  var subCatId = '';
  Map favoritesResponse = {};
  @override
  void initState() {
    super.initState();
    fetchChildDetails();
    fetchSubCategoriesDetails();
  }

//   scanDevices() async{
//     flutterBlue.startScan(timeout: Duration(seconds: 4));
//
// // Listen to scan results
//     // ignore: cancel_subscriptions
//     var subscription = flutterBlue.scanResults.listen((results) async {
//       // do something with scan results
//       for (ScanResult r in results) {
//         print('${r.device.id.id} found! rssi: ${r.rssi}');
//         await r.device.connect();
//       }
//     });
//   }

  fetchSubCategoriesDetails() async{
    final prefs = await sharedPrefs;
    final body = {
      "subcatId": widget.subCatId,
      "_id": prefs.getString("userID")
    };
    await con.waitForSubCategoriesDetails(body).then((value){
      setState(() {
        subCategoriesDetails = value[0];
        catId = subCategoriesDetails['category_id'];
        subCatId = subCategoriesDetails['_id'];
        print(subCategoriesDetails);
        //flag = true;
      });
    });
  }

  addToFavorites(context) async{
    final prefs = await sharedPrefs;
    final body = {
      "child_id": childId,
      "parent_id": prefs.getString("userID"),
      'cat_id': catId,
      'sub_cat_id': subCatId,
      'isActive': 'yes'
    };
    await con.addToFavorites(body).then((value){
      setState(() {
        Future.delayed(const Duration(milliseconds: 500), () {
          /*if(value){
            _buildPopupDialog(context, "Success!!!", "Video added to favorites "
                "successfully", false);
          }else{
            _buildPopupDialog(context, "Oops..!!!", "failed to add to favorites "
                , false);
          }*/
        });

        favoritesResponse = value!;
        print(favoritesResponse);
        showLoader = false;
        //flag = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: HomeHeader(
                    userData: widget.userData,
                    title: subCategoriesDetails['title']??"---",
                    image: widget.image,
                    desc: "",
                  ),
                ),
                Visibility(
                  visible: widget.call != null ? false : true,
                  child: Container(
                    color: Colors.black,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: MediaQuery.of(context).size.height / 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  addToFavoritesFlag = false;
                                });
                                _pickChild(context);
                                // Navigator.of(context).push(PageTransition(
                                //     curve: Curves.decelerate,
                                //     type: PageTransitionType.rightToLeft,
                                //     child: FindDevicesScreen()));
                                /*if (widget.userData != null)

                                  *//*Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PlayBack(
                                            minimize: minimizeCallback,
                                          )));*//*
                                else
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => GetStarted()));*/
                              },
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width / 1.5,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xffE1CA92),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                    5.0,
                                  )),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.play_arrow,
                                        size: 20.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      alignment: Alignment.center,
                                      child: AutoSizeText("PLAY",
                                        //"${widget.userData != null ? "PLAY" : "LOG IN TO PLAY"}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            // // fontFamily: "Roboto",
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: IconButton(
                                  icon: Icon(
                                    favoritesResponse['response_code'] == 200
                                    || favoritesResponse['response_code'] == 502
                                        ? Icons.favorite :
                                      Icons.favorite_border,
                                      size: 25.0,
                                      color: favoritesResponse['response_code'] == 200
                                          || favoritesResponse['response_code'] == 502
                                          ? Colors.red :
                                      Color(0xffFAD7A0)),
                                  onPressed: (){
                                    setState(() {
                                      //showLoader = true;
                                      addToFavoritesFlag = true;
                                    });
                                    _pickChild(context);
                                  },
                                )
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Icon(Icons.cloud_download_outlined,
                                    size: 25.0, color: Color(0xffFAD7A0)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                        child: Stack(
                  children: [
                    Container(
                      child: listDetails(),
                    ),
                    Visibility(
                      visible: minimize ? true : false,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () async{
                            final prefs = await sharedPrefs;
                            final body = {
                              "child_id": childId,
                              "parent_id": prefs.getString("userID"),
                              'cat_id': catId,
                              'sub_cat_id': subCatId,
                              'isActive': 'yes'
                            };
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PlayBack(
                                      minimize: minimizeCallback, body: body,
                                  subCategoriesDetails: subCategoriesDetails,
                                    )));
                          },
                          child: Container(
                            color: Colors.black54,
                            height: MediaQuery.of(context).size.height / 11,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  child: Image.asset("assets/images/fav1.jpg",
                                      fit: BoxFit.fitHeight,
                                      height:
                                          MediaQuery.of(context).size.height / 6),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  child: AutoSizeText(
                                    "The Wooden Ladder",
                                    minFontSize: 8,
                                    maxFontSize: 10,
                                    style: TextStyle(
                                        // // fontFamily: "Roboto",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  height: 3,
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width / 9,
                                ),
                                Container(
                                  height: 3,
                                  color: Colors.black87,
                                  width: MediaQuery.of(context).size.width / 15,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  child: AutoSizeText(
                                    "0.43",
                                    minFontSize: 8,
                                    maxFontSize: 10,
                                    style: TextStyle(
                                        // // fontFamily: "Roboto",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      play = !play;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10, right: 10),
                                    child: Icon(
                                        play ? Icons.play_arrow : Icons.pause,
                                        size: 20.0,
                                        color: Colors.white),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      minimize = false;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10, right: 10),
                                    child: Icon(Icons.close,
                                        size: 20.0, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))),
              ],
            ),
          ),
          if(showDialog)Container(
              color: Colors.white30,
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: _buildPopupDialog(context, "No child profile found!",
                  "Please add profile(s) to proceed", true)
          ),
          if(showLoader)Container(
            color: Colors.white30,
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }

  Widget listDetails() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      //color: Color(0xffFEF2EF),
      child: ListView(
        children: [
          Container(
            child: AutoSizeText(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              style: TextStyle(
                  // // fontFamily: "Roboto",
                  color: Colors.black87),
            ),
          ),
          Visibility(
            visible: widget.call != null ? false : true,
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: AutoSizeText(
                "59 m",
                style: TextStyle(
                    // // fontFamily: "Roboto",
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Visibility(
            visible: false /* widget.call!=null ?  : true*/,
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: AutoSizeText(
                "More like this",
                style: TextStyle(
                    // // fontFamily: "Roboto",
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Visibility(
            visible: false /*widget.call != null ?  : true*/,
            child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      margin: EdgeInsets.only(left: 20),
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child: AutoSizeText(
                                "Under 10m",
                                minFontSize: 8,
                                maxFontSize: 11,
                                style: TextStyle(
                                    // // fontFamily: "Roboto",
                                    color: Colors.black87),
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      margin: EdgeInsets.only(left: 20),
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child: AutoSizeText(
                                "All",
                                minFontSize: 8,
                                maxFontSize: 11,
                                style: TextStyle(
                                    // // fontFamily: "Roboto",
                                    color: Colors.black87),
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
//           Container(
//             margin: EdgeInsets.only(top: 10),
//             child: ListView.builder(
//                 shrinkWrap: true,
//                 physics: ClampingScrollPhysics(),
//                 itemCount: itemList.length > 0 ? itemList.length : 0,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {},
//                     child: Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         child: Row(
//                           children: [
//                             Container(
//                               color: Color(0xffD0E0E3),
//                               // height:MediaQuery.of(context).size.height/8,
//                               width: MediaQuery.of(context).size.width / 3,
//                               child: Image.asset("${itemList[index]["image"]}",
//                                   fit: BoxFit.fitHeight,
//                                   height:
//                                       MediaQuery.of(context).size.height / 8),
//                               /*Stack(
//                               children: [
//
//                                 Positioned(
//                                   bottom: 0.0,
//                                   right: 0.0,
//                                   left: 0.0,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child:Image.asset("${itemList[index]["image"]}",fit:BoxFit.fitHeight,
//                                         height:MediaQuery.of(context).size.height/10),
//                                   ),
//                                 ),
//
//                                 Align(
//                                     alignment: Alignment.center,
//                                     child: Container(
//                                       child:AutoSizeText("${index+1}",
//                                         style: TextStyle(// fontFamily: "Roboto",),),
//                                     ),
//
//
//                               ],
//                             ),
// */
//                             ),
//                             Expanded(
//                               child: Container(
//                                 height:
//                                     MediaQuery.of(context).size.height / 8.5,
//                                 margin: EdgeInsets.only(left: 10),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: AutoSizeText(
//                                         "${itemList[index]["title"]}",
//                                         minFontSize: 15,
//                                         maxFontSize: 20,
//                                         style: TextStyle(
//                                             // // fontFamily: "Roboto",
//                                             ),
//                                       ),
//                                     ),
//                                     Container(
//                                       child: AutoSizeText(
//                                         "Ages ${itemList[index]["ages"]}",
//                                         minFontSize: 8,
//                                         maxFontSize: 11,
//                                         style: TextStyle(
//                                             // // fontFamily: "Roboto",
//                                             color: Colors.grey),
//                                       ),
//                                     ),
//                                     Container(
//                                       child: AutoSizeText(
//                                         "${itemList[index]["detail"]}",
//                                         minFontSize: 8,
//                                         maxFontSize: 11,
//                                         style: TextStyle(
//                                             // // fontFamily: "Roboto",
//                                             color: Colors.black54),
//                                       ),
//                                     ),
//                                     Container(
//                                       child: AutoSizeText(
//                                         "${itemList[index]["length"]}",
//                                         minFontSize: 8,
//                                         maxFontSize: 11,
//                                         style: TextStyle(
//                                             // // fontFamily: "Roboto",
//                                             color: Colors.grey),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         )),
//                   );
//                 }),
//           )
        ],
      ),
    );
  }

  void fetchChildDetails() async {
    final prefs = await sharedPrefs;
    final body = {
      "parent_id": prefs.get("_id")
    };
    print(prefs.get("_id"));
    await con.getChildren(body).then((value){
      setState(() {
        childrenList = value;
        showLoader = false;
        if(childrenList.isEmpty){
          showDialog = true;
        }
      });
    });
  }

  Future<void> _pickChild(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return ListView.builder(
              itemCount: childrenList.length,
              shrinkWrap: true,
              controller: ScrollController(),
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: () async{
                    final prefs = await sharedPrefs;
                    setState(() {
                      childId = childrenList[index]["_id"];
                      if(!addToFavoritesFlag){
                        showLoader = true;
                      }
                    });
                    final body = {
                      "child_id": childId,
                      "parent_id": prefs.getString("userID"),
                      'cat_id': catId,
                      'sub_cat_id': subCatId,
                      'isActive': 'yes'
                    };
                    if(!addToFavoritesFlag){
                      favoritesResponse = {};
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlayBack(
                            minimize: minimizeCallback, body: body,
                            subCategoriesDetails: subCategoriesDetails,
                          ))).then((value){
                        setState(() {
                          showLoader = false;
                        });
                      });
                    }else{
                      Navigator.pop(context);
                      addToFavorites(context);
                    }
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(childrenList[index]["image"].toString().contains("assets/images/") ?
                            childrenList[index]["image"] :
                            "assets/images/profile.png"),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.01),),
                        Text(childrenList[index]["name"],
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                              fontWeight: FontWeight.w400
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
          );
        });
  }

  Widget _buildPopupDialog(BuildContext context, String title, String msg, bool flag) {
    return new AlertDialog(
      title: Text('$title'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("$msg"),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
        if(flag)FlatButton(
          onPressed: () {
            Navigator.of(context).push(PageTransition(
                curve: Curves.decelerate,
                type: PageTransitionType.rightToLeft,
                child: Home(userData: UserController().user.value,
                  isSubscribed: false, index: 4,)));
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Add Child'),
        ),
      ],
    );
  }

  void minimizeCallback(bool data) {
    setState(() {
      minimize = data;
    });
  }
}
