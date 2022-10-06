import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hallboking/pages/home.dart';
import 'package:hallboking/preferences/sharedprefs.dart';
import 'package:uuid/uuid.dart';
import '../constants.dart';

import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var header = Uuid().v4();
  String token = '', header_str = '', username = '';
  Widget textField(
      String hinttext, TextEditingController textEditingController) {
    return TextFormField(
      validator: (val) {
        if (val!.isEmpty) {
          return "this field is needed";
        }
        if (hinttext == "email") {
          if (!val.contains("@")) {
            return "enter a valid email";
          }
        }

        if (hinttext == "password") {
          if (val.length < 6) {
            return "password must be grater than 6 chars";
          }
          if (val.length < 6) {
            return "password must be less than 12 chars";
          }
        }
      },
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hinttext,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Constants.primaryColor)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Constants.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.green),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }

  //127.0.0.1 : 10.0.2.2
  // Uri.parse('http://10.0.2.2:3030/auth/login')
  loginUser() async {
    final response = await http
        .post(Uri.parse("http://10.0.2.2:3030/auth/login"),
            headers: {
              'Authorization': header,
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              "email": "200701142@rajalakshmi.edu.in",
              "password": "REC2020Mano"
            }))
        .then((value) {
        setState(() {
          token = jsonDecode(value.body)['token'];
          header_str = header;
          username = jsonDecode(value.body)['username'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20, 90, 20, 0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assest/logo2.png')),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                textField("email", emailController),
                SizedBox(
                  height: 10,
                ),
                textField("password", passwordController),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  // onTap: ()=>loginUser(),
                  onTap: () async {
                    loginUser();
                    print(header_str );
                    print(token );
                    print(username );
                    
                    Preference.setToken(token);
                    Preference.setHeader(header_str);
                    
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(token: token)));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Constants.primaryColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
