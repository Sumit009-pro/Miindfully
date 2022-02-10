import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:miindfully/profile/add_profile.dart';
import 'package:miindfully/profile/profile.dart';
import 'package:miindfully/resources/user_controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_extensions/string_extensions.dart';

class ManageProfiles extends StatefulWidget {
  final String? call;

  const ManageProfiles({Key? key, this.call}) : super(key: key);

  @override
  _ManageProfilesState createState() => _ManageProfilesState();
}

class _ManageProfilesState extends State<ManageProfiles> {
  Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
  UserModel? childDetails;
  List childrenList = [];
  UserController con = UserController();
  bool flag = true;
  bool showAddChildText = false;

  @override
  void initState() {
    fetchChildDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFEF2EF),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: Builder(
              builder: (BuildContext context) {
                return widget.call != null
                    ? Container()
                    : IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
              },
            ),
            backgroundColor: Color(0xffFAD7A0),
            foregroundColor: Colors.brown,
            elevation: 1.0,
            title: Text("Manage Profiles")),
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
              padding: EdgeInsets.all(10),
              //height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: childrenList.isNotEmpty
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    if(showAddChildText && childrenList.isEmpty)Padding(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.15),
                      child: Text('Please add child!',
                        style: TextStyle(
                            //color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height * 0.025
                        ),
                      ),
                    ),
                    flag ? Padding(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.15),
                      child: CircularProgressIndicator(),
                    ) :
                    ListView.builder(
                        itemCount: childrenList.length,
                        shrinkWrap: true,
                        controller: ScrollController(),
                        itemBuilder: (BuildContext context, int index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(PageTransition(
                                  curve: Curves.decelerate,
                                  type: PageTransitionType.rightToLeft,
                                  child: Profile(userData: childrenList[index])));
                            },
                            child: Card(
                              elevation: 10,
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
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageTransition(
                            curve: Curves.decelerate,
                            type: PageTransitionType.rightToLeft,
                            child: AddProfile(fetchChildData: fetchChildData))).then((value){
                              fetchChildDetails();
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 14,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xffE1CA92),
                          borderRadius: BorderRadius.all(Radius.circular(
                            5.0,
                          )),
                        ),
                        margin:
                            EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          "Add Profile",
                          style: TextStyle(
                              // // fontFamily: "Roboto",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
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
        flag = false;
        if(childrenList.isEmpty){
          showAddChildText = true;
        }
      });
    });
  }

  Future<void> fetchChildData() async {

  }
}
