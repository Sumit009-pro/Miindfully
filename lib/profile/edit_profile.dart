import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:string_extensions/string_extensions.dart';

class EditProfile extends StatefulWidget {
  final userData;
  final Function()? setChildData;

  const EditProfile({Key? key, this.userData, this.setChildData})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? imageFile;
  String? selectedGender;

  bool editName = false;

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

  List<dynamic> _selectedList = [];

  var _items;

  @override
  void initState() {
    _items = fascinateList
        .map((item) => MultiSelectItem<dynamic>(item, item["name"]))
        .toList();
    super.initState();
    if (widget.userData != null) {
      nameController.text = "${widget.userData['name']}";
      dob = widget.userData['dob'];
      print(widget.userData);
      //selectedGender = widget.userData!.gender;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Container(
                    child: ListView(
                      physics: AlwaysScrollableScrollPhysics(),
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

                              /*showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),),
                              context: context,
                              isDismissible: true,
                              isScrollControlled: false,
                              elevation: 8,
                              enableDrag: false,
                              builder: (BuildContext buildContext) {

                                return Container(
                                  color:Color(0xffFEF2EF),
                                  child: Column(
                                    children: [

                                      Container(
                                        margin:EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:[

                                              Container(),

                                              Container(
                                                margin: EdgeInsets.only(left: 5),
                                                child: AutoSizeText("Choose an Image",
                                                  style: TextStyle(// fontFamily: "Roboto",),),
                                              ),

                                              InkWell(
                                                onTap: (){Navigator.of(context).pop();},
                                                child: Container(
                                                  child: Icon(Icons.close,size: 20,),
                                                ),
                                              ),

                                            ]
                                        ),
                                      ),

                                      Expanded(
                                        child: Container(
                                          child: GridView.builder(
                                            itemCount: images.length,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                             // crossAxisSpacing: 5.0,
                                            //  mainAxisSpacing: 5.0,
                                            ),
                                            itemBuilder: (BuildContext context, int index) {
                                              return Image.asset(images[index]["image"],fit: BoxFit.fitHeight,
                                                height: MediaQuery.of(context).size.height/6,);
                                            },
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                );

                              }
                          );*/
                            },
                            child: imageFile != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.black,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: FileImage(imageFile!),
                                              fit: BoxFit.cover)),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.black,
                                    backgroundImage:
                                        AssetImage("${widget.userData['image']}"),
                                    /* child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white70,
                                    child: Icon(Icons.edit),
                                  ),
                                ),
                              ]
                          ),*/
                                  ),
                          ),
                        ),
                        Visibility(
                          visible: !editName ? true : false,
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  editName = true;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 10),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: AutoSizeText(
                                            "${(nameController.text).toTitleCase()}",
                                            style: TextStyle(
                                                // // fontFamily: "Roboto",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                        ),
                                      ])),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: editName ? true : false,
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  editName = false;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 30,
                                          width:
                                              MediaQuery.of(context).size.width / 3,
                                          margin: EdgeInsets.only(right: 5),
                                          child: new TextField(
                                            controller: nameController,
                                            keyboardType: TextInputType.text,
                                            //  textAlignVertical: TextAlignVertical.center,
                                            textAlign: TextAlign.start,
                                            autofocus: true,
                                            maxLines: 1,
                                            // style: TextStyle(// fontFamily: "Roboto",fontSize:15,),
                                            decoration: InputDecoration(),
                                          ),
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.check,
                                            size: 20,
                                          ),
                                        ),
                                      ])),
                            ),
                          ),
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
                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: AutoSizeText(
                                      "Gender",
                                      style: TextStyle(
                                          // // fontFamily: "Roboto",
                                          ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: DropdownButtonHideUnderline(
                                        child: new DropdownButton(
                                          icon: Container(),
                                          hint: new Text(
                                            "Choose",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          isDense: true,
                                          value: selectedGender,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedGender = "$newValue";
                                            });
                                          },
                                          items: <String>[
                                            'Female',
                                            'Male',
                                          ].map((String data) {
                                            return new DropdownMenuItem(
                                                value: data,
                                                child: Text(
                                                  "$data",
                                                  style: new TextStyle(
                                                      color: Colors.black),
                                                ));
                                          }).toList(),
                                        ),
                                      ))
                                ])),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
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
                        Container(
                          //height: MediaQuery.of(context).size.height / 2.5,
                          child: ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
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
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                  InkWell(
                    onTap: () async {
                      if (nameController.text != "") {
                        var data = json.encode({
                          "name": "${nameController.text}",
                          "image": imageFile != null ? imageFile!.path : widget.userData["image"],
                          "dateOfBirth": dob != null ? "$dob" : null,
                          "gender":
                              selectedGender != null ? "$selectedGender" : null,
                          "createdDate": "${DateTime.now()}",
                        });

                        await UserModel.saveStringPref(
                            UserModel.prefChildData, json.encode(data));

                        //widget.setChildData!();

                        Navigator.of(context).pop();
                      } else
                        ScaffoldMessenger.of(context).showSnackBar(
                            (SnackBar(content: Text("Name is required."))));
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
                            // // fontFamily: "Roboto",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
