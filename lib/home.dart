import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/classes/classes.dart';
import 'package:miindfully/favourite/favourites.dart';
import 'package:miindfully/home_dash/home_dash.dart';
import 'package:miindfully/login/get_started.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:miindfully/profile/manage_profiles.dart';
// import 'package:miindfully/profile/profile.dart';
import 'package:miindfully/search/search_and_filters.dart';

class Home extends StatefulWidget {
  final UserModel? userData;
  final isSubscribed;
  final index;

  const Home({Key? key, this.userData, this.isSubscribed, this.index}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 4;
  var tabs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _currentIndex = widget.index;
    });
    if (widget.userData != null) {
      tabs = [
        HomeDash(userData: widget.userData,isSubscribed: widget.isSubscribed,),
        Classes(userData: widget.userData),
        Favourites(userData: widget.userData),
        SearchAndFilters(),
        widget.userData != null
            ? ManageProfiles(
                call: "BottomNav",
              )
            : GetStarted(
                call: "BottomNav",
              )
      ];
    } else {
      _currentIndex = 3;
      tabs = [
        Classes(userData: widget.userData),
        Favourites(userData: widget.userData),
        SearchAndFilters(),
        GetStarted(
          call: "BottomNav",
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            elevation: 6,
            backgroundColor: Colors.white, //Color(0xfffbe1b6),
            selectedItemColor: Color(0xfff7c36e),
            unselectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            currentIndex: _currentIndex,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            items: widget.userData != null
                ? [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Image.asset(
                        'assets/images/logo.png',
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width / 14,
                      ),
                      activeIcon: Image.asset(
                        'assets/images/logo.png',
                        color: Color(0xfff7c36e),
                        width: MediaQuery.of(context).size.width / 14,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Classes',
                      icon: Icon(Icons.play_circle_outline),
                    ),
                    BottomNavigationBarItem(
                      label: 'Favourites',
                      icon: Icon(Icons.favorite),
                    ),
                    BottomNavigationBarItem(
                      label: 'Search',
                      icon: Icon(Icons.search),
                    ),
                    BottomNavigationBarItem(
                      label: 'Profile',
                      icon: Icon(Icons.person),
                    ),
                  ]
                : [
                    BottomNavigationBarItem(
                      label: 'Classes',
                      icon: Icon(Icons.play_circle_outline),
                    ),
                    BottomNavigationBarItem(
                      label: 'Favourites',
                      icon: Icon(Icons.favorite),
                    ),
                    BottomNavigationBarItem(
                      label: 'Search',
                      icon: Icon(Icons.search),
                    ),
                    BottomNavigationBarItem(
                      label: 'Profile',
                      icon: Icon(Icons.person),
                    ),
                  ]),
      ),
    );
  }
}
