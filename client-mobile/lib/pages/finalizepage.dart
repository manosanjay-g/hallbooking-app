import 'package:flutter/material.dart';
import 'package:hallboking/constants.dart';

class FinalizingPage extends StatefulWidget {
  final List<String> slots;

  const FinalizingPage({Key? key, required this.slots}) : super(key: key);

  @override
  State<FinalizingPage> createState() => _FinalizingPageState();
}

class _FinalizingPageState extends State<FinalizingPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        centerTitle: true,
        title: Text("finalize booking"),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(width: 0.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Title of event",
                      fillColor: Colors.grey[300],
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: TextFormField(
                      // keyboardType: TextInputType.multiline,
                      controller: nameController,
                      maxLines: 150,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(width: 0.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Description",
                        fillColor: Colors.grey[300],
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    alignment: Alignment.center,
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text("Finalize booking", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
