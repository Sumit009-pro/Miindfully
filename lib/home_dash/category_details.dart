import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/item_details/item_list.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:miindfully/resources/user_controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  final int index;
  final String catId;
  final String userId;
  final UserModel? userData;
  const CategoryDetails({Key? key, this.title, required this.catId, this.userData, required this.userId, required this.index})
      : super(key: key);

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  List<dynamic> favoritesList = [
    {
      "image": "assets/images/fav1.jpg",
      "name": "The Wooden Ladder",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/fav2.jpg",
      "name": "Golden Plank Bridge",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/fav3.jpg",
      "name": "Wobbly Table",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/fav4.jpg",
      "name": "Infinite Lookout",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
  ];

  List<dynamic> breatheList = [
    {
      "image": "assets/images/adventure2.jpg",
      "name": "Square breathing",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/adventure3.jpg",
      "name": "Triangle breathing",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/adventure4.jpg",
      "name": "Infinity-8 breathing",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/adventure5.jpg",
      "name": "Star breathing",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/adventure6.jpg",
      "name": "Other breathing",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
  ];

  List<dynamic> mantraList = [
    {
      "image": "assets/images/mantra1.jpg",
      "name": "I am loved",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/mantra2.jpg",
      "name": "I am gentle",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/mantra3.jpg",
      "name": "I am kind",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/mantra4.jpg",
      "name": "I am strong",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/mantra5.jpg",
      "name": "I am enough",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/mantra6.jpg",
      "name": "I can do it",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
  ];

  List<dynamic> adventureList = [
    {
      "image": "assets/images/adventure1.jpg",
      "name": "Magical Treehouse",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/adventure2.jpg",
      "name": "Fantasy Forest",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/adventure3.jpg",
      "name": "Ocean",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/adventure4.jpg",
      "name": "Beach",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/adventure5.jpg",
      "name": "Sports",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/adventure6.jpg",
      "name": "Sky",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
  ];
  Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
  UserController con = UserController();
  List subCategoriesList = [];
  List<dynamic> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSubCategories();
    if (widget.index == 0)
      list = favoritesList;
    else if (widget.index == 1)
      list = mantraList;
    else if (widget.index == 2)
      list = adventureList;
    else if (widget.index == 3) list = breatheList;
  }

  fetchSubCategories() async{
    final prefs = await sharedPrefs;
    final body = {
      "category_id": widget.catId,
      "_id": prefs.getString("userID")
    };
    await con.waitForSubCategories(body).then((value){
      setState(() {
        subCategoriesList = value;
        //flag = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xffFAD7A0),
        foregroundColor: Colors.brown,
        elevation: 1.0,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 30,
              // color: Colors.grey[800],
              onPressed: () {
                Navigator.of(context).pop();
              });
        }),
        title: Text(
          "${widget.title}",
          style: TextStyle(
              // fontFamily: "FuturaHeavy"
              ),
        ),
      ),
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
            //color: Color(0xffFEF2EF),
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(15),
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: subCategoriesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageTransition(
                          curve: Curves.decelerate,
                          type: PageTransitionType.rightToLeft,
                          child: ItemList(
                            subCatId: subCategoriesList[index]["_id"],
                            userData: widget.userData,
                            title: list[index]["name"],
                            image: list[index]["image"],
                          )));
                    },
                    child: Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            Container(
                              color: Color(0xffD0E0E3),
                              width: MediaQuery.of(context).size.width / 3,
                              child: Image.asset("${list[index]["image"]}",
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height / 8),
                            ),
                            Expanded(
                              child: Container(
                                height: MediaQuery.of(context).size.height / 8.5,
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: AutoSizeText(
                                        "${subCategoriesList[index]["title"]}",
                                        minFontSize: 15,
                                        maxFontSize: 20,
                                        style: TextStyle(
                                            // // fontFamily: "Roboto",
                                            ),
                                      ),
                                    ),
                                    Container(
                                      child: AutoSizeText(
                                        "${list[index]["detail"]}",
                                        minFontSize: 8,
                                        maxFontSize: 11,
                                        style: TextStyle(
                                            // // fontFamily: "Roboto",
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
