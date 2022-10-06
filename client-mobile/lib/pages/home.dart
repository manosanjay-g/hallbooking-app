import 'package:flutter/material.dart';
import 'package:hallboking/constants.dart';
import 'package:hallboking/pages/halllistpage.dart';
import 'package:hallboking/pages/profile.dart';
import 'package:hallboking/preferences/sharedprefs.dart';

class Home extends StatefulWidget {
  final String token;
  const Home({Key? key, required this.token}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    ConstantDetails.tokenString =
    await Preference.getToken();
    ConstantDetails.headerString =
    await Preference.getHeader();
  }

  List pageList = [
    HallList(),
    Profile(),
  ];
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    print(ConstantDetails.tokenString);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:Constants.primaryColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Constants.primaryColor,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(onPressed: (){
              setState(() {
                currentindex = 0;
              });
            }, icon: Icon(Icons.home, size: 30, color: Colors.white,)),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: IconButton(onPressed: (){
              setState(() {
                currentindex = 1;
              });
            }, icon: Icon(Icons.person, size: 30, color: Colors.white,)),
            label: '',
          ),
        ],
      ),
      body: pageList[currentindex],
    );
  }
}
