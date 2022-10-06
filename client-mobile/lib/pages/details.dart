import 'package:flutter/material.dart';
import 'package:hallboking/constants.dart';
import 'package:hallboking/pages/eventView.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class Details extends StatefulWidget {
  final String event, time, date, hall, description;
  final bool iscompleted;

  const Details(
      {Key? key,
      required this.event,
      required this.time,
      required this.date,
      required this.hall,
      required this.description,
      required this.iscompleted})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      setState(() {
        imageFileList!.addAll(selectedImages);
      });
  }
  }

  Row dateAndTime(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon),
        Text(
          title,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:widget.iscompleted?FloatingActionButton.extended(
        backgroundColor: Constants.primaryColor,
        onPressed: (){
          selectImages();
        },
        icon: Icon(Icons.add),
        label: Text('Add Images'),

      ):null,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        title: widget.iscompleted
            ? Text("your past event")
            : Text("your upcoming event"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 4, 10, 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Text(
              widget.event,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              widget.hall,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                dateAndTime(Icons.access_time_outlined, widget.time),
                SizedBox(
                  width: 10,
                ),
                dateAndTime(Icons.date_range, widget.date),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              widget.description,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),

            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: imageFileList!.map((e) {
                  print(e.toString());
                  return Container(
                    margin: EdgeInsets.all(10),
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: FileImage(File(e.path))
                      )
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,0,20,0),
              child: TextFormField(
                decoration: InputDecoration(hintText: 'title'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20,0,20,0),
              child: TextFormField(
                decoration: InputDecoration(hintText: 'Link'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
