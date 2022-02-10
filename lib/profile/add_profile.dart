import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:miindfully/models/picture.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:miindfully/resources/user_controller.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_extensions/string_extensions.dart';

class AddProfile extends StatefulWidget {
  final UserModel? childDetails;
  final Function()? fetchChildData;
  const AddProfile({Key? key, this.fetchChildData, this.childDetails})
      : super(key: key);

  @override
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
  File? imageFile;
  String? selectedGender;
  Picture? picture;
  bool editName = false;
  bool flag = true;
  String imagePath = "";

  final nameController = TextEditingController();

  var dob;

  List<dynamic> fascinateList = [
    {"id": "1", "name": "Adventures"},
    {"id": "2", "name": "Animals"},
    {"id": "3", "name": "Breathing exercises"},
    {"id": "4", "name": "Colors"},
    {"id": "5", "name": "Counting + math"},
    {"id": "6", "name": "Feeling Strong"},
    {"id": "7", "name": "Nature"},
    {"id": "8", "name": "Seasons"},
    {"id": "9", "name": "Princesses and prince"},
    {"id": "10", "name": "Relaxing music"},
    {"id": "11", "name": "School"},
    {"id": "12", "name": "Shapes"},
    {"id": "13", "name": "Space"},
    {"id": "14", "name": "Sports"},
    {"id": "15", "name": "Special and secret places"},
    {"id": "16", "name": "Under the sea"},
    {"id": "17", "name": "Stretching and moving our body"},
  ];
  String selectedFascinates = "";
  List<dynamic> _selectedList = [];

  var _items;
  List<Picture> picList = <Picture>[
    Picture.fromMap({
      "image": "assets/images/fish11.jpg",
      "name": "Fish 1",
    }),
    Picture.fromMap({
      "image": "assets/images/fish12.jpg",
      "name": "Fish 2",
    }),
    Picture.fromMap({
      "image": "assets/images/froggyjump.jpg",
      "name": "Frog",
    }),
    Picture.fromMap({
      "image": "assets/images/Horse (4).jpg",
      "name": "Horse",
    }),
    Picture.fromMap({
      "image": "assets/images/rabbits38.jpg",
      "name": "Bunny",
    }),
    Picture.fromMap({
      "image": "assets/images/Tiger (6).jpg",
      "name": "Tiger",
    }),
    Picture.fromMap({
      "image": "assets/images/Eagle (1).jpg",
      "name": "Eagle",
    }),
    Picture.fromMap({
      "image": "assets/images/rhinos40.jpg",
      "name": "Rhinos",
    }),
  ];

  @override
  void initState() {
    _items = fascinateList
        .map((item) => MultiSelectItem<dynamic>(item, item["name"]))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //color: Color(0xffFEF2EF),
          padding: EdgeInsets.all(10),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListView(
                    //physics: AlwaysScrollableScrollPhysics(),
                      controller: ScrollController(),
                    shrinkWrap: true,
                    children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Container(
                            child: Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.black,
                        )),
                      ),
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          _showImagePicker(context);
                        },
                        child: imageFile != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: FileImage(imageFile!),
                                          fit: BoxFit.cover)),
                                ),
                              )
                            : widget.childDetails != null &&
                                    widget.childDetails!.image != ""
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "${widget.childDetails?.image!}"),
                                              fit: BoxFit.cover)),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage(picture == null
                                        ? "assets/images/profile.png"
                                        : picture!.path),
                                  ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),),
                    GridView.count(
                      controller: ScrollController(),
                      shrinkWrap: true,
                        crossAxisCount: 4,
                        children: List<Picture>.from(picList)
                            .map<Widget>((e) => GestureDetector(
                                child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(e.path)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    height:
                                        MediaQuery.of(context).size.height /
                                            40),
                                onTap: () {
                                  setState(() {
                                    imagePath = e.path;
                                    picture = e;
                                    print(picture!.path);
                                  });
                                }))
                            .toList(),
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4),

                    Visibility(
                      visible: widget.childDetails == null ? true : false,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            editName = true;
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 30, bottom: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: AutoSizeText(
                                      "Child name",
                                      style: TextStyle(
                                          // // fontFamily: "Roboto",
                                          ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: !editName
                                        ? Container(
                                            child: AutoSizeText(
                                              "${nameController.text == "" ? "Add name" : (nameController.text).toTitleCase()}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  // // fontFamily: "Roboto",
                                                  color:
                                                      nameController.text != ""
                                                          ? Colors.black
                                                          : Colors.grey),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              setState(() {
                                                editName = false;
                                              });
                                            },
                                            child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            15,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        margin: EdgeInsets.only(
                                                            right: 5),
                                                        child: new TextField(
                                                          controller:
                                                              nameController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textAlign:
                                                              TextAlign.start,
                                                          autofocus: true,
                                                          maxLines: 1,
                                                          decoration:
                                                              InputDecoration(),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(3),
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .white),
                                                        child: Icon(
                                                          Icons.check,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ])),
                                          ),
                                  ),
                                ])),
                      ),
                    ),

                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),

                    InkWell(
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1950, 1, 1),
                            maxTime: DateTime(2019, 12, 31),
                            theme: DatePickerTheme(
                                headerColor: Color(0xffE1CA92),
                                //  backgroundColor: Colors.blue,
                                itemStyle: TextStyle(
                                  color: Colors.black,
                                  //  fontWeight: FontWeight.bold,
                                ),
                                doneStyle: TextStyle(
                                  color: Colors.black,
                                )),
                            // onChanged: (date) { print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());},
                            onConfirm: (date) {
                          setState(() {
                            dob = date;
                          });
                          print('confirm $date');
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: AutoSizeText(
                                    "Date of birth",
                                    style: TextStyle(
                                        // // fontFamily: "Roboto",
                                        ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: AutoSizeText(
                                    "${dob != null && dob != "" ? DateFormat("dd MMM, yyyy").format(DateFormat("yyyy-MM-dd").parse("$dob")) : "Add birthday"}",
                                    style: TextStyle(
                                        // // fontFamily: "Roboto",
                                        color: dob != null && dob != ""
                                            ? Colors.black
                                            : Colors.grey),
                                  ),
                                ),
                              ])),
                    ),

                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),

                    // Container(
                    //     margin: EdgeInsets.only(top: 10,bottom: 10),
                    //     child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children:[
                    //
                    //           Container(
                    //             child: AutoSizeText("Gender",
                    //               style: TextStyle(// fontFamily: "Roboto",),),
                    //           ),
                    //
                    //           Container(
                    //               margin: EdgeInsets.only(left: 5),
                    //               child:  DropdownButtonHideUnderline(
                    //                 child: new DropdownButton(
                    //                   icon: Container(),
                    //                   hint: new Text("Choose",style: TextStyle(color: Colors.grey),),
                    //                   isDense: true,
                    //                   value: selectedGender,
                    //                   onChanged: (String? newValue) {
                    //                     setState(() {
                    //                       selectedGender = "$newValue";
                    //                     });
                    //                   },
                    //                   items: <String>['Female','Male',
                    //                   ].map((String data) {
                    //                     return new DropdownMenuItem(
                    //                         value: data,
                    //                         child: Text("$data",style: new TextStyle(color: Colors.black),)
                    //                     );
                    //                   }).toList(),
                    //                 ),
                    //
                    //               ))
                    //         ]
                    //     )
                    // ),
                    //
                    // Divider(thickness: 1,color: Colors.grey,),
                      Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      child: AutoSizeText(
                        "What fascinates me....",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // // fontFamily: "Roboto",
                            fontWeight: FontWeight.w600),
                      ),
                    ),

                    ListView(
                      shrinkWrap: true,
                      controller: ScrollController(),
                      //physics: ClampingScrollPhysics(),
                      children: [
                        MultiSelectChipField(
                          items: _items,
                          initialValue: _selectedList,
                          title: Text(""),
                          scroll: false,
                          showHeader: false,
                          headerColor: Colors.transparent,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey, width: 1.2),
                          ),
                          selectedChipColor:
                              Color(0xffE1CA92).withOpacity(0.5),
                          selectedTextStyle: TextStyle(color: Colors.black87),
                          onTap: (values) {
                            _selectedList = values;
                            print(_selectedList);
                          },
                        ),
                      ],
                    ),
                    ],
                    ),
                    InkWell(
                      onTap: () async {
                        if(nameController.text.isNotEmpty && dob != null){
                          final prefs = await sharedPrefs;
                          setState(() {
                            flag = false;
                            for(int i = 0; i < _selectedList.length; i++){
                              selectedFascinates += _selectedList[i]['name'];
                              if(i < _selectedList.length - 1){
                                selectedFascinates += ',';
                              }
                            }
                          });
                          final body = {
                            "name": nameController.text,
                            "dob": dob.toString(),
                            "fascinate": selectedFascinates,
                            "parent_id": prefs.getString('_id'),
                            "profile_pic": imagePath,
                            "default_pic": imagePath
                          };
                          print(body);
                          UserController().addChild(body).then((value){
                            setState(() {
                              flag = true;
                            });
                            if(value){
                              print(value);
                              Navigator.pop(context);
                            }
                          });
                        }
                        /*if (nameController.text != "") {
                          var data = json.encode({
                            "name": "${nameController.text}",
                            "image": "assets/images/profile.png",
                            "dateOfBirth": dob != null ? "$dob" : null,
                            "gender":
                                selectedGender != null ? "$selectedGender" : null,
                            "createdDate": "${DateTime.now()}",
                          });

                          await UserModel.saveStringPref(
                              UserModel.prefChildData, json.encode(data));

                          widget.fetchChildData!();

                          Navigator.of(context).pop();
                        } else
                          ScaffoldMessenger.of(context).showSnackBar(
                              (SnackBar(content: Text("Name is required."))));*/
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
                            EdgeInsets.only(top: 10, bottom: 5, left: 15, right: 15),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          "Save Profile",
                          style: TextStyle(
                              // fontFamily: "Roboto",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              flag ? Container() : Container(
                color: Colors.black12,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }
}
