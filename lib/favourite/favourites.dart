import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/item_details/item_list.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:miindfully/resources/user_controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favourites extends StatefulWidget {
  final UserModel? userData;
  const Favourites({
    Key? key,
    this.userData,
  }) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
  UserController con = UserController();
  List favoritesListResponse = [];
  bool showLoader = true;
  List childrenList = [];
  var childId = '';
  String selectedChild = 'Select Child ↓';

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

  @override
  void initState() {
    super.initState();
    fetchChildDetails();
  }

  fetchFavorites() async{
    final prefs = await sharedPrefs;
    final body = {
      "child_id": childId,
      "parent_id": prefs.getString("userID")
    };
    await con.getFavorites(body).then((value){
      setState(() {
        favoritesListResponse = value;
        print(favoritesListResponse);
        showLoader = false;
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
        elevation: 1.0,
        title: Text(
          "Favourites ",
          style: TextStyle(
              // fontFamily: "FuturaHeavy",
              color: Colors.brown),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              _pickChild(context);
            },
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffFEF2EF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black)
                ),
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.007),
                child: Center(
                  child: Text(
                    "$selectedChild",
                    style: TextStyle(
                        /*decoration: title != "Favorites" ? TextDecoration.underline
                            : TextDecoration.none,*/
                        // fontFamily: "FuturaHeavy",
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                        color: Colors.brown),
                  ),
                ),
              ),
            ),
          ),
        ],
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
          showLoader ? Center(
            child: CircularProgressIndicator(),
          ) :
          favoritesListResponse.isEmpty ? Center(
            child: Text(selectedChild == "Select Child ↓" ?
            "Please select a child to see favourites !" :
                "No favorites for ${selectedChild.split(' ')[0]} !"),
          ) :
          Container(
            //color: Color(0xffFEF2EF),
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(15),
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: favoritesListResponse.length > 0 ? favoritesListResponse.length : 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageTransition(
                          curve: Curves.decelerate,
                          type: PageTransitionType.rightToLeft,
                          child: ItemList(
                            subCatId: "",
                            userData: widget.userData,
                            title: favoritesList[index]["name"],
                            image: favoritesList[index]["image"],
                          )));
                    },
                    child: Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            Container(
                              color: Color(0xffD0E0E3),
                              width: MediaQuery.of(context).size.width / 3,
                              child: Image.asset("${favoritesList[index]["image"]}",
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
                                        "${favoritesListResponse[index]["title"]}",
                                        minFontSize: 15,
                                        maxFontSize: 20,
                                        style: TextStyle(
                                            // // fontFamily: "Roboto",
                                            ),
                                      ),
                                    ),
                                    Container(
                                      child: AutoSizeText(
                                        "${favoritesList[index]["detail"]}",
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
        if(childrenList.isNotEmpty){
          //showDialog = true;
            _pickChild(context);
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
                  onTap: (){
                    setState(() {
                      childId = childrenList[index]["_id"];
                      selectedChild = childrenList[index]["name"]+" ↓";
                      showLoader = true;
                    });
                    fetchFavorites();
                    Navigator.pop(context);
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
}
