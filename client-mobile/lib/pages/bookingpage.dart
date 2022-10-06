import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hallboking/constants.dart';
import 'package:hallboking/pages/finalizepage.dart';

class Booking extends StatefulWidget {
  final String selectedDate;

  const Booking({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  List<String> slots = [];

  Widget slotchecker(String slot) {
    bool checked = false;
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (slots.contains(slot)) {
              setState(() {
                setState(() {
                  slots.remove(slot);
                });
              });
            } else {
              setState(() {
                setState(() {
                  slots.add(slot);
                });
              });
            }
          },
          icon: !slots.contains(slot)
              ? Icon(Icons.check_box_outline_blank)
              : Icon(
                  Icons.check,
                  color: Colors.green,
                ),
        ),
        Text(
          slot,
          style: TextStyle(fontSize: 20),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print(slots);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.primaryColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>FinalizingPage(slots: slots)));
        },
        label: Text("continue booking"),
        icon: Icon(Icons.arrow_forward_ios),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Pick a slot",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
        backgroundColor: Constants.primaryColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30, 50, 20, 0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              widget.selectedDate.split(" ")[0],
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            slotchecker("full day"),
            slotchecker("8am - 9am"),
            slotchecker("10am - 11am"),
            slotchecker("11am - 12am"),
            slotchecker("1pm - 2pm"),
            slotchecker("2pm - 3pm"),
            slotchecker("4pm - 5pm"),
          ],
        ),
      ),
    );
  }
}
