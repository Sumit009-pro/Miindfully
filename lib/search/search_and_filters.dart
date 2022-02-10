import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SearchAndFilters extends StatefulWidget {
  const SearchAndFilters({Key? key}) : super(key: key);

  @override
  _SearchAndFiltersState createState() => _SearchAndFiltersState();
}

class _SearchAndFiltersState extends State<SearchAndFilters> {
  final _searchController = TextEditingController();

  bool hide = false;

  List<dynamic> searchList = [
    {
      "image": "assets/images/fav1.jpg",
      "title": "The Wooden Ladder",
      "ages": "4-5",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "7m"
    },
    {
      "image": "assets/images/fav4.jpg",
      "title": "Twisty Slide",
      "ages": "6-8",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "12m"
    },
    {
      "image": "assets/images/fav2.jpg",
      "title": "Golden Plank Bridges",
      "ages": "All ages",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "21m"
    },
    {
      "image": "assets/images/fav3.jpg",
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

  int selectedMoodList = 0;

  String? lengthValue = "0-5 min";
  String? ageValue = "4-5";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xffFAD7A0),
        elevation: 1.0,
        title: Text(
          "Search & Filters",
          style: TextStyle(
              // fontFamily: "FuturaHeavy",
              color: Colors.black),
        ),
      ),
      body: SafeArea(
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
            Container(
              //color: Color(0xffFEF2EF),
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              child: Container(
                //color: Color(0xffFEF2EF),
                // padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.all(Radius.circular(
                                      5.0,
                                    )),
                                  ),
                                  child: new TextField(
                                    controller: _searchController,
                                    keyboardType: TextInputType.text,
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.start,
                                    //  autofocus: true,
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
                                              hide = false;
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
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: AutoSizeText(
                                    "I would like to feel…",
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
                                      itemCount:
                                          moodList.length > 0 ? moodList.length : 0,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  style:
                                                      TextStyle(color: Colors.black),
                                                  items: <String>[
                                                    "0-5 min",
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  style:
                                                      TextStyle(color: Colors.black),
                                                  items: <String>[
                                                    "4-5",
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
                              ],
                            ),
                          )),
                    ),

                    /*Container(
                        child: Row(
                          children: [

                            Expanded(
                              child: Container(
                                height: 35,
                                decoration:BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(5.0,)),
                                ),
                                child: new TextField(
                                  controller: _searchController,
                                  keyboardType: TextInputType.text,
                                  textAlignVertical: TextAlignVertical.center,
                                  textAlign: TextAlign.start,
                                //  autofocus: true,
                                  maxLines: 1,
                                  onSubmitted: (value){
                                    setState(() {
                                      hide=true;
                                    });
                                  },
                                  style: TextStyle(// fontFamily: "Roboto",fontSize:15,),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      suffixIcon: InkWell(
                                        onTap: (){
                                          setState(() {
                                            hide=false;
                                            _searchController.text="";
                                          });
                                        },
                                        child: Container(
                                            margin: EdgeInsets.all(5.0),
                                            decoration:BoxDecoration(shape: BoxShape.circle,color:Colors.grey),
                                            child:Icon(Icons.close,color: Colors.white,size:15,)),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 11.3, horizontal: 10.0),
                                      prefixIcon: Container(margin: EdgeInsets.all(3.0), child:Icon(Icons.search,color: Color(0xffFAD7A0),size:28,)),
                                      hintText:"Search"
                                  ),
                                ),
                              ),
                            ),

                           */ /* InkWell(
                              onTap: (){
                                setState(() {  //search=false;
                                   hide=false;
                                _searchController.text=""; });
                              },
                              child: Container(
                                child: Icon(Icons.close,  size: 30.0,color: Colors.grey,),
                              ),
                            ),*/ /*

                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: AutoSizeText("MOOD",
                          style: TextStyle(// fontFamily: "Roboto",fontWeight: FontWeight.bold),),
                      ),

                      Container(
                        height: MediaQuery.of(context).size.height/20,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:moodList.length>0 ? moodList.length : 0,
                            itemBuilder:(context,index){

                              return InkWell(
                                onTap: (){
                                  setState(() {
                                    selectedMoodList=index;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 10,),
                                  child: AutoSizeText("${moodList[index]["name"]}",
                                    style: TextStyle(// fontFamily: "Roboto",color: selectedMoodList==index ?  Color(0xffFAD7A0) : Colors.black87),),
                                ),
                              );

                            }
                        ),
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
                                      child: AutoSizeText("LENGTH",
                                        style: TextStyle(// fontFamily: "Roboto",fontWeight: FontWeight.bold),),
                                    ),

                                    Container(
                                      child: DropdownButton<String>(
                                        value: lengthValue,
                                        elevation: 5,
                                        style: TextStyle(color: Colors.black),
                                        items: <String>[
                                          '0-10m',
                                          '11-20m',
                                          '20-30m',
                                        ].map<DropdownMenuItem<String>>((String value) {
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
                                      child: AutoSizeText("AGES",
                                        style: TextStyle(// fontFamily: "Roboto",fontWeight: FontWeight.bold),),
                                    ),

                                    Container(
                                      child: DropdownButton<String>(
                                        value: ageValue,
                                        elevation: 5,
                                        style: TextStyle(color: Colors.black),
                                        items: <String>[
                                          '0-2',
                                          '3-4',
                                          '5-6',
                                        ].map<DropdownMenuItem<String>>((String value) {
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
*/
                    Visibility(
                        visible: hide ? true : false,
                        child: Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount:
                                    searchList.length > 0 ? searchList.length : 0,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              color: Color(0xffD0E0E3),
                                              height:
                                                  MediaQuery.of(context).size.height /
                                                      8,
                                              width:
                                                  MediaQuery.of(context).size.width /
                                                      3,
                                              child: Image.asset(
                                                "${searchList[index]["image"]}",
                                              ),
                                              /* Stack(
                                                  children: [

                                                    Positioned(
                                                      bottom: 0.0,
                                                      right: 0.0,
                                                      left: 0.0,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child:Image.asset("assets/images/black_ring.png",fit:BoxFit.fitHeight,height:MediaQuery.of(context).size.height/10),
                                                      ),
                                                    ),

                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Container(
                                                        child:AutoSizeText("${index+1}",
                                                          style: TextStyle(// fontFamily: "Roboto",),),
                                                      ),
                                                    )

                                                  ],
                                                ),*/
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    8.5,
                                                margin: EdgeInsets.only(left: 10),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: AutoSizeText(
                                                        "${searchList[index]["title"]}",
                                                        minFontSize: 15,
                                                        maxFontSize: 20,
                                                        style: TextStyle(
                                                            // fontFamily: "Roboto",
                                                            ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: AutoSizeText(
                                                        "Ages ${searchList[index]["ages"]}",
                                                        minFontSize: 8,
                                                        maxFontSize: 11,
                                                        style: TextStyle(
                                                            // fontFamily: "Roboto",
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: AutoSizeText(
                                                        "${searchList[index]["detail"]}",
                                                        minFontSize: 8,
                                                        maxFontSize: 11,
                                                        style: TextStyle(
                                                            // fontFamily: "Roboto",
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: AutoSizeText(
                                                        "${searchList[index]["length"]}",
                                                        minFontSize: 8,
                                                        maxFontSize: 11,
                                                        style: TextStyle(
                                                            // fontFamily: "Roboto",
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
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
