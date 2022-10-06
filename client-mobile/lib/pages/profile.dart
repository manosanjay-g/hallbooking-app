import 'package:flutter/material.dart';
import 'package:hallboking/component/profileComponents.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          children: [
            TextFormField(
                decoration: InputDecoration(
                  hintText: "search",
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your activity",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            profileupcomingEvents(
                'Main seminar Hall',
                "Devopps",
                'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. Wikipedia',
                '9am-12pm',
                "assest/img1.jpg",
                "21-8-2022",
                context),
            profileRecentEvent(
                "AI ML", "purple Hall", "4-6-2022", 'assest/img2.jpg',
                'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. Wikipedia',context)
          ],
        ));
  }
}
