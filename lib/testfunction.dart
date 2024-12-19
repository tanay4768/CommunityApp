import 'package:firebase_database/firebase_database.dart';

class Testfunction {
  static void performops() {
    final db = FirebaseDatabase.instance.ref("channels");
    DatabaseReference newPostRef = db.push();
    final response = newPostRef.set({
      "ChannelInfo": {
        "avatar":
            "https://flutter-ko.dev/assets/images/docs/catalog-widget-placeholder.png",
        "creation_date": "19/12/2024",
        "lastmessage": {
          "date": "04/12/2024",
          "message": "Welcome to Hackslash Community",
          "time": "7.42"
        },
        "name": "HackSlash Community #2024"
      }
    }).then((onValue) {
      print(newPostRef.key);
    });
  }
}
