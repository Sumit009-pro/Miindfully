import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/animation.dart';
import 'package:miindfully/item_details/item_list.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:page_transition/page_transition.dart';

class HomeFooter extends StatefulWidget {
  final UserModel? userData;
  final user;
  final String catName;
  final List subCatList;

  const HomeFooter({Key? key, this.userData, required this.catName, required this.subCatList, required this.user}) : super(key: key);

  @override
  _HomeFooterState createState() => _HomeFooterState();
}

class _HomeFooterState extends State<HomeFooter> {
  List<Color> bgColors = [
    Color(0xffA9CCE3),
    Color(0xff34495E),
    Color(0xff808B96),
    Color(0xff7FB3D5),
    Color(0xffFAD7A0)
  ];

  List<dynamic> breatheList = [
    {"name": "Square breathing"},
    {"name": "Triangle breathing"},
    {"name": "Infinity-8 breathing"},
    {"name": "Star breathing"},
    {"name": "Other breathing"},
  ];

  List<dynamic> favoritesList = [
    {"image": "assets/images/fav1.jpg", "name": "The Wooden Ladder"},
    {"image": "assets/images/fav2.jpg", "name": "Golden Plank Bridge"},
    {"image": "assets/images/fav3.jpg", "name": "Wobbly Table"},
    {"image": "assets/images/fav4.jpg", "name": "Infinite Lookout"},
  ];

  List<dynamic> mantraList = [
    {"image": "assets/images/mantra1.jpg", "name": "I am loved"},
    {"image": "assets/images/mantra2.jpg", "name": "I am gentle"},
    {"image": "assets/images/mantra3.jpg", "name": "I am kind"},
    {"image": "assets/images/mantra4.jpg", "name": "I am strong"},
    {"image": "assets/images/mantra5.jpg", "name": "I am enough"},
    {"image": "assets/images/mantra6.jpg", "name": "I can do it"},
  ];

  List<dynamic> adventureList = [
    {"image": "assets/images/adventure1.jpg", "name": "Magical Treehouse"},
    {"image": "assets/images/adventure2.jpg", "name": "Fantasy Forest"},
    {"image": "assets/images/adventure3.jpg", "name": "Ocean"},
    {"image": "assets/images/adventure4.jpg", "name": "Beach"},
    {"image": "assets/images/adventure5.jpg", "name": "Sports"},
    {"image": "assets/images/adventure6.jpg", "name": "Sky"},
  ];

  List<dynamic> searchList = [
    {
      "title": "The Wooden Ladder",
      "ages": "4-5",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "7m"
    },
    {
      "title": "Twisty Slide",
      "ages": "6-8",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "12m"
    },
    {
      "title": "Golden Plank Bridges",
      "ages": "All ages",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "21m"
    },
    {
      "title": "Wobbly Table",
      "ages": "All ages",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "11m"
    },
  ];

  List<dynamic> moodList = [
    {"name": "All"},
    {"name": "Safe"},
    {"name": "Loved"},
    {"name": "Focus"},
    {"name": "Confident"},
    {"name": "Happy"},
    {"name": "Sleepy"},
    {"name": "Cozy"},
    {"name": "Active"},
    {"name": "Forgiving"},
  ];

  final _searchController = TextEditingController();
  bool search = false;
  bool hide = false;

  int selectedMoodList = 0;

  String? lengthValue = "0-5 min";
  String? ageValue = "4-5";

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Color(0xffFEF2EF),
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ListView(
        controller: ScrollController(),
        shrinkWrap: true,
        children: [
          /*Visibility(
            visible: !hide ? true : false,
            child: Container(
              child: mood(),
            ),
          ),*/

          /* Container(
            child: searchUI(),
          ),*/

          widget.catName == "favorite" ? Visibility(
            visible: !hide ? true : false,
            child: Container(
              child: favorites(),
            ),
          ) :
          Visibility(
            visible: !hide ? true : false,
            child: Container(
              child: mantra(),
            ),
          ),
          /*Visibility(
            visible: !hide ? true : false,
            child: Container(
              child: adventure(),
            ),
          ),
          Visibility(
            visible: !hide ? true : false,
            child: Container(
              child: breathe(),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget mood() {
    return Container(
      height: MediaQuery.of(context).size.height / 20,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount:
              moodList != null && moodList.length > 0 ? moodList.length : 0,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedMoodList = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: 20,
                ),
                child: AutoSizeText(
                  "${moodList[index]["name"]}",
                  style: TextStyle(
                      // // fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      color: selectedMoodList == index
                          ? Color(0xffFAD7A0)
                          : Colors.black87),
                ),
              ),
            );
          }),
    );
  }

  Widget searchUI() {
    return Container(
      child: search
          ? Container(
              color: Color(0xffFEF2EF),
              child: Card(
                elevation: 5,
                child: Container(
                  color: Color(0xffFEF2EF),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(
                                    5.0,
                                  )),
                                ),
                                child: new TextField(
                                  controller: _searchController,
                                  keyboardType: TextInputType.text,
                                  textAlignVertical: TextAlignVertical.center,
                                  textAlign: TextAlign.start,
                                  autofocus: true,
                                  maxLines: 1,
                                  onSubmitted: (value) {
                                    setState(() {
                                      hide = true;
                                    });
                                  },
                                  style: TextStyle(
                                    // // fontFamily: "Roboto",
                                    fontSize: 15,
                                  ),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _searchController.text = "";
                                          });
                                        },
                                        child: Container(
                                            margin: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 15,
                                            )),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 11.3, horizontal: 10.0),
                                      prefixIcon: Container(
                                          margin: EdgeInsets.all(3.0),
                                          child: Icon(
                                            Icons.search,
                                            color: Color(0xffFAD7A0),
                                            size: 28,
                                          )),
                                      hintText: "Search"),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  search = false;
                                  hide = false;
                                  _searchController.text = "";
                                });
                              },
                              child: Container(
                                child: Icon(
                                  Icons.close,
                                  size: 30.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: AutoSizeText(
                          "MOOD",
                          style: TextStyle(
                              // // fontFamily: "Roboto",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 20,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: moodList != null && moodList.length > 0
                                ? moodList.length
                                : 0,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedMoodList = index;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: AutoSizeText(
                                    "${moodList[index]["name"]}",
                                    style: TextStyle(
                                        // // fontFamily: "Roboto",
                                        color: selectedMoodList == index
                                            ? Color(0xffFAD7A0)
                                            : Colors.black87),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: AutoSizeText(
                                        "LENGTH",
                                        style: TextStyle(
                                            // // fontFamily: "Roboto",
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: DropdownButton<String>(
                                        value: lengthValue,
                                        elevation: 5,
                                        style: TextStyle(color: Colors.black),
                                        items: <String>[
                                          '0-5 min',
                                          '6-10 min',
                                          '11-20 min',
                                          '20+ min'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            lengthValue = value;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: AutoSizeText(
                                        "AGES",
                                        style: TextStyle(
                                            // // fontFamily: "Roboto",
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: DropdownButton<String>(
                                        value: ageValue,
                                        elevation: 5,
                                        style: TextStyle(color: Colors.black),
                                        items: <String>[
                                          '4-5',
                                          '6-8',
                                          '9-12',
                                          '13+'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            ageValue = value;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: hide ? true : false,
                          child: Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: searchList.length > 0
                                    ? searchList.length
                                    : 0,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              color: Color(0xffD0E0E3),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    bottom: 0.0,
                                                    right: 0.0,
                                                    left: 0.0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Image.asset(
                                                          "assets/images/black_ring.png",
                                                          fit: BoxFit.fitHeight,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              10),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      child: AutoSizeText(
                                                        "${index + 1}",
                                                        style: TextStyle(
                                                            // // fontFamily: "Roboto",
                                                            ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    8.5,
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: AutoSizeText(
                                                        "${searchList[index]["title"]}",
                                                        minFontSize: 15,
                                                        maxFontSize: 20,
                                                        style: TextStyle(
                                                            // // fontFamily: "Roboto",
                                                            ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: AutoSizeText(
                                                        "Ages ${searchList[index]["ages"]}",
                                                        minFontSize: 8,
                                                        maxFontSize: 11,
                                                        style: TextStyle(
                                                            // fontFamily:
                                                            //     "Roboto",
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: AutoSizeText(
                                                        "${searchList[index]["detail"]}",
                                                        minFontSize: 8,
                                                        maxFontSize: 11,
                                                        style: TextStyle(
                                                            // fontFamily:
                                                            //     "Roboto",
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: AutoSizeText(
                                                        "${searchList[index]["length"]}",
                                                        minFontSize: 8,
                                                        maxFontSize: 11,
                                                        style: TextStyle(
                                                            // fontFamily:
                                                            //     "Roboto",
                                                            color: Colors.grey),
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
                          ))
                    ],
                  ),
                ),
              ),
            )
          : InkWell(
              onTap: () {
                setState(() {
                  search = true;
                });
              },
              child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Icon(Icons.search),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: AutoSizeText(
                          "Search & Filters",
                          style: TextStyle(
                              // // fontFamily: "Roboto",
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )),
            ),
    );
  }

  Widget favorites() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10,bottom: 10),
            child: AutoSizeText(
              "Favorites",
              minFontSize: 18,
              style: TextStyle(
                  // // fontFamily: "Roboto",
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 7,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: favoritesList.length > 0 ? favoritesList.length : 0,
                itemBuilder: (context, index) {
                  return Animator(
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: OpenContainer(
                            closedShape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0.0)),
                            ),
                            transitionType: ContainerTransitionType.fade,
                            transitionDuration:
                                const Duration(milliseconds: 600),
                            closedBuilder:
                                (BuildContext c, VoidCallback action) {
                              return Container(
                                child: Stack(
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        "${favoritesList[index]["image"]}",
                                        fit: BoxFit.fill,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0.0,
                                      left: 0.0,
                                      child: Container(
                                        padding:
                                            EdgeInsets.only(left: 5, bottom: 5),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: AutoSizeText(
                                          "${favoritesList[index]["name"]}",
                                          minFontSize: 15,
                                          softWrap: true,
                                          style: TextStyle(
                                              // // fontFamily: "Roboto",
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            tappable: true,
                            openBuilder: (BuildContext c, VoidCallback action) {
                              return ItemList(
                                subCatId: "",
                                userData: widget.userData,
                                title: favoritesList[index]["name"],
                                image: favoritesList[index]["image"],
                              );
                            }),
                      ),
                      Duration(milliseconds: 300),
                      Curves.easeIn);
                }),
          )
        ],
      ),
    );
  }

  Widget mantra() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: AutoSizeText(widget.user['name']+"'s "+
              widget.catName,
              minFontSize: 18,
              style: TextStyle(
                  // // fontFamily: "Roboto",
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 7,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                controller: ScrollController(),
                //physics: NeverScrollableScrollPhysics(),
                itemCount: widget.subCatList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(PageTransition(
                          curve: Curves.decelerate,
                          type: PageTransitionType.rightToLeft,
                          child: ItemList(
                            subCatId: widget.subCatList[index]["_id"],
                            userData: widget.userData,
                            title: widget.subCatList[index]["title"],
                            image: mantraList[index]["image"],
                          )));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: 10,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            child: Image.asset(
                              "${mantraList[index]["image"]}",
                              width: MediaQuery.of(context).size.width / 2.5,
                              fit: BoxFit.fill,
                              height: MediaQuery.of(context).size.height / 2.5,
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            child: Container(
                              padding: EdgeInsets.only(left: 5, bottom: 5),
                              width: MediaQuery.of(context).size.width / 3,
                              child: AutoSizeText(
                                "${widget.subCatList[index]["title"]}",
                                minFontSize: 15,
                                softWrap: true,
                                style: TextStyle(
                                    // // fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget adventure() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 25, bottom: 10),
            child: AutoSizeText(
              "Tate's adventure meditations",
              minFontSize: 18,
              style: TextStyle(
                  // // fontFamily: "Roboto",
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 7,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: adventureList.length > 0 ? adventureList.length : 0,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      right: 10,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          child: Image.asset("${adventureList[index]["image"]}",
                              fit: BoxFit.fill,
                              height: MediaQuery.of(context).size.height / 2.5,
                              width: MediaQuery.of(context).size.width / 2.5),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          child: Container(
                            padding: EdgeInsets.only(left: 5, bottom: 5),
                            width: MediaQuery.of(context).size.width / 3,
                            child: AutoSizeText(
                              "${adventureList[index]["name"]}",
                              minFontSize: 15,
                              softWrap: true,
                              style: TextStyle(
                                  // // fontFamily: "Roboto",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget breathe() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 25, bottom: 10),
            child: AutoSizeText(
              "Breathe with Tate",
              minFontSize: 18,
              style: TextStyle(
                  // // fontFamily: "Roboto",
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 7,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: favoritesList.length > 0 ? favoritesList.length : 0,
                itemBuilder: (context, index) {
                  return Container(
                      color: bgColors[index],
                      height: MediaQuery.of(context).size.height / 2.5,
                      margin: EdgeInsets.only(
                        right: 10,
                      ),
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(left: 5, bottom: 5),
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: AutoSizeText(
                          "${breatheList[index]["name"]}",
                          minFontSize: 15,
                          softWrap: true,
                          style: TextStyle(
                              // // fontFamily: "Roboto",
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ));
                }),
          )
        ],
      ),
    );
  }
}
