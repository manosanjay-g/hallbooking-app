import 'package:flutter/material.dart';

class EventView extends StatefulWidget {
  final String eventName, date;

  const EventView({Key? key, required this.eventName, required this.date}) : super(key: key);

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      ),
    );
  }
}
