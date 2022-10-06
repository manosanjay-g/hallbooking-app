import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hallboking/constants.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:hallboking/pages/bookingpage.dart';

import '../component/cardComponent.dart';

class View extends StatefulWidget {
  final String img, hallname, location;

  const View(
      {Key? key,
      required this.img,
      required this.hallname,
      required this.location})
      : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  Widget TopImg() {
    return Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
                image: AssetImage(widget.img), fit: BoxFit.cover)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Details"),
        backgroundColor: Constants.primaryColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        child: ListView(children: [
          TopImg(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 0),
            child: Text(
              widget.hallname,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 10, 0, 8),
            child: Text(
              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 0),
            child: Text(
              "Pick A Date",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: DatePicker(
              DateTime.now(),
              width: 60,
              height: 80,
              controller: _controller,
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.green,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedValue = date;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Booking(selectedDate: _selectedValue.toString())));
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 10, 8, 0),
            child: Text(
              "Upcoming Events",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            width: MediaQuery.of(context).size.width,
            height: 330,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                upcomingEvents("Ml seminar", "6-8-22", "assest/img1.jpg",
                    '9am - 11am', context),
                upcomingEvents("Ai seminar", "6-6-22", "assest/img2.jpg",
                    '1pm - 3pm', context)
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 10, 8, 0),
            child: Text(
              "Recent Events",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            width: MediaQuery.of(context).size.width,
            height: 330,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                recentevent("Ml seminar", "6-8-22", "assest/img1.jpg", context),
                recentevent("Ai seminar", "6-6-22", "assest/img2.jpg", context)
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
