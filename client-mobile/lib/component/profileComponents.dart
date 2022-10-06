import 'package:flutter/material.dart';
import 'package:hallboking/pages/details.dart';


Widget profileupcomingEvents(String hallName,event, description,time, imgPath, date, context){
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(event: event, time: time, date: date, hall: hallName, description: description, iscompleted: false)));
    },
    child: Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(imgPath))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 3, 0, 0),
              child: Text(
                "${hallName}-${event}",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, overflow: TextOverflow.ellipsis),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 5, 0, 0),
              child: Text(
                "Timing: ${time}",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 5, 0, 0),
              child: Text(
                "Conducted on: ${date}",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget profileRecentEvent(String event, String hallName, String date, String imgPath, String description,context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(event: event, time: "completed", date: date, hall: hallName, description: description, iscompleted: true)));
    },
    child: Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(imgPath))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 0),
              child: Text(
                "${hallName}-${event}",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20,overflow: TextOverflow.ellipsis),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 0),
              child: Text(
                "Conducted on: ${date}",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
