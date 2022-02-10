import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/classes/home_footer.dart';
import 'package:miindfully/classes/home_header.dart';
import 'package:miindfully/home_dash/category_details.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:miindfully/resources/user_controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Classes extends StatefulWidget {
  final UserModel? userData;
  const Classes({Key? key, this.userData}) : super(key: key);

  @override
  _ClassesState createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  List cardList = [];
  UserController con = UserController();
  Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
  var userData = {};
  List categoriesList = [];
  List subCategoriesList = [];
  var subCategories = {};
  List subCatKeys = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List<dynamic> favoritesList = [
    {"image": "assets/images/fav1.jpg", "name": "The Wooden Ladder"},
    {"image": "assets/images/fav2.jpg", "name": "Golden Plank Bridge"},
    {"image": "assets/images/fav3.jpg", "name": "Wobbly Table"},
    {"image": "assets/images/fav4.jpg", "name": "Infinite Lookout"},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createCard();
    getCategories();
  }

  void getCategories() async{
    final prefs = await sharedPrefs;
    userData = jsonDecode(prefs.getString("userData")!);
    final body = {"_id": prefs.getString("userID")};
    await con.waitForCategories(body).then((value){
      setState(() {
        categoriesList = value;
        //flag = true;
      });
    });
    for(var data in categoriesList){
      await fetchSubCategories(data['_id']).then((value){
        setState(() {
          subCategories[data['_id']] = value;
        });
      });
    }
    setState(() {
      subCatKeys = subCategories.keys.toList();
      print(subCatKeys);
      print(subCategories);
    });
  }

  Future fetchSubCategories(catId) async{
    final prefs = await sharedPrefs;
    final body = {
      "category_id": catId,
      "_id": prefs.getString("userID")
    };
    await con.waitForSubCategories(body).then((value){
      setState(() {
        subCategoriesList = value;
        //flag = true;
      });
    });
    return subCategoriesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xffFEF2EF),
          child: Stack(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Color(0xffFEF2EF),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          height: MediaQuery.of(context).size.height / 3,
                          reverse: false,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {},
                          pauseAutoPlayOnTouch: true,
                        ),
                        items: cardList.map(
                          (card) {
                            return Builder(builder: (BuildContext context) {
                              return Container(
                                color: Color(0xffFEF2EF),
                                child: Card(
                                  child: card,
                                ),
                              );
                            });
                          },
                        ).toList(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: HomeFooter(
                        user: userData,
                        subCatList: [],
                        catName: "favorite",
                        //userData: widget.userData,
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: categoriesList.length,
                        controller: ScrollController(),
                        //physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            //padding: EdgeInsets.only(top: 5),
                            child: HomeFooter(
                              user: userData,
                              subCatList: subCategories[categoriesList[index]['_id']] != null ?
                              subCategories[categoriesList[index]['_id']] : [],
                              catName: categoriesList[index]['name'],
                              //userData: widget.userData,
                            ),
                          );
                        },
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createCard() {
    for (int i = 0; i < bannersList.length; i++) {
      cardList.add(Container(
        child: HomeHeader(
            userData: widget.userData,
            call: "FromHome",
            image:  i < 4 ? favoritesList[i]["image"] : favoritesList[i%4]["image"],
            title: bannersList[i]["title"],
            desc: bannersList[i]["description"],
        ),
      ));
    }
  } //func

}
