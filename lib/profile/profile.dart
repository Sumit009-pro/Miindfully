import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:miindfully/profile/edit_profile.dart';
import 'package:string_extensions/string_extensions.dart';

class Profile extends StatefulWidget {
  final userData;

  const Profile({Key? key, this.userData})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var childDetails = {};

  final Color leftBarColor = const Color(0xff8c8c8c);
  final Color rightBarColor = const Color(0xffE1CA92);
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  List<dynamic> recentlyList = [
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

  @override
  void initState() {
    super.initState();

    setState(() {
      childDetails = widget.userData;
    });

    final barGroup1 = makeGroupData(0, 1.5, 1.2);
    final barGroup2 = makeGroupData(1, 1.6, 1.8);
    final barGroup3 = makeGroupData(2, 2.3, 2.4);
    final barGroup4 = makeGroupData(3, 2.0, 2.1);
    final barGroup5 = makeGroupData(4, 1.7, 1.5);
    final barGroup6 = makeGroupData(5, 1.9, 2.1);
    final barGroup7 = makeGroupData(6, 3.3, 3.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

  Future<bool> onBack() async {
    //widget.fetchChildData!();
    Navigator.of(context, rootNavigator: true).pop();

    return await true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBack,
      child: Scaffold(
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
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          InkWell(
                            onTap: () {
                              onBack();
                            },
                            child: Container(
                                child: Icon(
                              Icons.close,
                              size: 25,
                              color: Colors.black,
                            )),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: ListView(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: Image.asset('${childDetails['image']}'),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 10,
                            ),
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              "${(childDetails['name'])}",
                              style: TextStyle(
                                  // // fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          /*Container(
                            margin: EdgeInsets.only(
                              top: 5,
                            ),
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              "Miindful since ${DateFormat("MMMM yyyy").format(DateFormat("yyyy-MM-dd").parse("${childDetails?.createdDate}"))} ",
                              style: TextStyle(
                                  // // fontFamily: "Roboto",
                                  ),
                            ),
                          ),*/
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                          userData: childDetails,
                                          //setChildData: setChildData,
                                        )));
                              },
                              child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE1CA92),
                                    borderRadius: BorderRadius.all(Radius.circular(
                                      5.0,
                                    )),
                                  ),
                                  margin: EdgeInsets.only(top: 10, bottom: 20),
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          child: Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: AutoSizeText(
                                            "Edit Profile",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                // // fontFamily: "Roboto",
                                                ),
                                          ),
                                        ),
                                      ])),
                            ),
                          ),

                          /*  Container(
                                child: AutoSizeText("I am grateful for the resources that continue to show up to help me be a great power. ",textAlign:TextAlign.center,minFontSize:20,
                                  style: TextStyle(// fontFamily: "Roboto",color: Colors.grey),),
                              ),*/

                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 10),
                            child: AutoSizeText(
                              "Recently played",
                              style: TextStyle(
                                  // // fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount:
                                    recentlyList != null && recentlyList.length > 0
                                        ? recentlyList.length
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
                                              child: Image.asset(
                                                  "${recentlyList[index]["image"]}",
                                                  fit: BoxFit.fitHeight,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      10),
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
                                                  children: [
                                                    Container(
                                                      child: AutoSizeText(
                                                        "${recentlyList[index]["title"]}",
                                                        minFontSize: 15,
                                                        maxFontSize: 20,
                                                        style: TextStyle(
                                                            // fontFamily: "Roboto",
                                                            ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: AutoSizeText(
                                                        "${recentlyList[index]["detail"]}",
                                                        minFontSize: 8,
                                                        maxFontSize: 11,
                                                        style: TextStyle(
                                                            // fontFamily: "Roboto",
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: AutoSizeText(
                                                        "${recentlyList[index]["length"]}",
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
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: AutoSizeText(
                              "14h 07m",
                              minFontSize: 20,
                              textAlign: TextAlign.center,
                              style: TextStyle(// fontFamily: "Roboto",
                                  ),
                            ),
                          ),
                          Container(
                            child: AutoSizeText(
                              "meditation (last 7 days)",
                              minFontSize: 8,
                              maxFontSize: 11,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  // fontFamily: "Roboto",
                                  color: Colors.grey),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 15, bottom: 15),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        child: Row(children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        color: Color(0xffE1CA92),
                                      ),
                                      Container(
                                        child: AutoSizeText(
                                          " THIS WEEK",
                                          minFontSize: 5,
                                          maxFontSize: 8,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              // fontFamily: "Roboto",
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ])),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 10,
                                            width: 10,
                                            color: Color(0xff8c8c8c),
                                          ),
                                          Container(
                                            child: AutoSizeText(
                                              " LAST WEEK",
                                              minFontSize: 5,
                                              maxFontSize: 8,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  // fontFamily: "Roboto",
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])),
                          Container(
                            child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  height: MediaQuery.of(context).size.height / 3,
                                  child: BarChart(
                                    BarChartData(
                                      maxY: 4,
                                      barTouchData: BarTouchData(
                                          touchTooltipData: BarTouchTooltipData(
                                            tooltipBgColor: Colors.grey,
                                            getTooltipItem: (_a, _b, _c, _d) =>
                                                null,
                                          ),
                                          touchCallback:
                                              (FlTouchEvent event, response) {
                                            if (response == null ||
                                                response.spot == null) {
                                              setState(() {
                                                touchedGroupIndex = -1;
                                                showingBarGroups =
                                                    List.of(rawBarGroups);
                                              });
                                              return;
                                            }

                                            touchedGroupIndex =
                                                response.spot!.touchedBarGroupIndex;

                                            setState(() {
                                              if (!event
                                                  .isInterestedForInteractions) {
                                                touchedGroupIndex = -1;
                                                showingBarGroups =
                                                    List.of(rawBarGroups);
                                                return;
                                              }
                                              showingBarGroups =
                                                  List.of(rawBarGroups);
                                              if (touchedGroupIndex != -1) {
                                                var sum = 0.0;
                                                for (var rod in showingBarGroups[
                                                        touchedGroupIndex]
                                                    .barRods) {
                                                  sum += rod.y;
                                                }
                                                final avg = sum /
                                                    showingBarGroups[
                                                            touchedGroupIndex]
                                                        .barRods
                                                        .length;

                                                showingBarGroups[
                                                        touchedGroupIndex] =
                                                    showingBarGroups[
                                                            touchedGroupIndex]
                                                        .copyWith(
                                                  barRods: showingBarGroups[
                                                          touchedGroupIndex]
                                                      .barRods
                                                      .map((rod) {
                                                    return rod.copyWith(y: avg);
                                                  }).toList(),
                                                );
                                              }
                                            });
                                          }),
                                      titlesData: FlTitlesData(
                                        show: true,
                                        rightTitles: SideTitles(showTitles: false),
                                        topTitles: SideTitles(showTitles: false),
                                        bottomTitles: SideTitles(
                                          showTitles: true,
                                          getTextStyles: (context, value) =>
                                              const TextStyle(
                                                  color: Color(0xff7589a2),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                          getTitles: (double value) {
                                            switch (value.toInt()) {
                                              case 0:
                                                return 'Mon';
                                              case 1:
                                                return 'Tue';
                                              case 2:
                                                return 'Wed';
                                              case 3:
                                                return 'Thu';
                                              case 4:
                                                return 'Fri';
                                              case 5:
                                                return 'Sat';
                                              case 6:
                                                return 'Sun';
                                              default:
                                                return '';
                                            }
                                          },
                                        ),
                                        leftTitles: SideTitles(
                                          showTitles: true,
                                          getTextStyles: (context, value) =>
                                              const TextStyle(
                                                  color: Color(0xff7589a2),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10),
                                          margin: 5,
                                          reservedSize: 30,
                                          interval: 0.5,
                                          getTitles: (value) {
                                            return '$value';
                                          },
                                        ),
                                      ),
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      barGroups: showingBarGroups,
                                      gridData: FlGridData(show: false),
                                    ),
                                  ),
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: AutoSizeText(
                                          "12d",
                                          minFontSize: 15,
                                          style: TextStyle(
                                              // fontFamily: "Roboto",
                                              color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                          child: Icon(
                                        Icons.thumb_up,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                      Container(
                                        child: AutoSizeText(
                                          "STREAK",
                                          minFontSize: 8,
                                          maxFontSize: 11,
                                          style: TextStyle(
                                              // fontFamily: "Roboto",
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: AutoSizeText(
                                          "132h",
                                          minFontSize: 15,
                                          style: TextStyle(
                                              // fontFamily: "Roboto",
                                              color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                          child: Icon(
                                        Icons.thumb_up,
                                        color: Colors.grey,
                                        size: 40,
                                      )),
                                      Container(
                                        child: AutoSizeText(
                                          "TOTAL",
                                          minFontSize: 8,
                                          maxFontSize: 11,
                                          style: TextStyle(
                                              // fontFamily: "Roboto",
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setChildData() async {
    UserModel? data = await UserModel.readStringPref(UserModel.prefChildData);
    setState(() {
      //childDetails = data;
    });
  }
}
