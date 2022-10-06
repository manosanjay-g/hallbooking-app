import 'package:flutter/material.dart';
import 'package:hallboking/pages/view.dart';

import '../component/cardComponent.dart';


class HallList extends StatefulWidget {
  const HallList({Key? key}) : super(key: key);

  @override
  State<HallList> createState() => _HallListState();
}

class _HallListState extends State<HallList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child:ListView(
          children: [
            TextFormField(
                decoration:  InputDecoration(
                  hintText: "search",
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                )
            ),
            cards("assest/img1.jpg", "main seminar hall", "Work shop block", context),
            cards("assest/img2.jpg", "PurpleHall", "AdminBlock", context)
          ],
        ) ,
      ),
    );
  }
}
