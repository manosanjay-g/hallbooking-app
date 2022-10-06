import 'package:flutter/material.dart';

import '../pages/view.dart';

Widget cards(String imgpath,String hallName, String blockName, context ){
  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>View(img: imgpath, hallname: hallName, location: blockName)));
    },
    child: Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5.0,
      child:Container(
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
                      fit: BoxFit.cover,
                      image: AssetImage(imgpath)
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0,12,0,3),
              child: Text(hallName, style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
              child: Text(blockName, style: TextStyle(
                fontSize: 17,
              ),),
            )
          ],
        ),
      ) ,
    ),
  );

}

Widget recentevent(String event, String date, String imgPath, context) {
  return GestureDetector(
    onTap: () {},
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
                event,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
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



Widget upcomingEvents(String event, String date, String imgPath, String time,context) {
  return GestureDetector(
    onTap: () {},
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
                event,
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 0),
              child: Text(
                "Timing: ${time}",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
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