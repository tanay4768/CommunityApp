import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communityapp/models/group_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GroupsController extends GetxController {
  final box = GetStorage();
  String get username => box.read('username') ?? '';

  RxList<Group> groups = <Group>[].obs;
  RxList meetings = [].obs;
  RxBool isGroup = true.obs;

  Set<String> activeListeners = {}; // Set to track active listeners

  void setListeners(String groupName, int unreads) {
    String user = username;
    final db = FirebaseFirestore.instance.collection("users").doc(user);

    // Check if a listener is already set for this group
    if (activeListeners.contains(groupName)) {
      print("Listener already set for $groupName. Skipping...");
      return; // Exit if listener is already set
    } else {
      activeListeners.add(groupName); // Add to active listeners
    }

    try {
      final DatabaseReference channelRef =
          FirebaseDatabase.instance.ref("channels/$groupName/ChannelInfo");
      channelRef.onValue.listen((event) async {
        final dataSnapshot = event.snapshot.value;
        if (dataSnapshot is Map<Object?, Object?>) {
          Map<String, dynamic> data = {};
          dataSnapshot.forEach((key, value) {
            data[key as String] = value;
          });
          print(data);

          // Check if the group already exists in the list
          int existingGroupIndex =
              groups.indexWhere((group) => group.name == data['name']);

          if (existingGroupIndex != -1) {
            // Group exists, update its unread count
            int updatedUnreads =
                groups[existingGroupIndex].unreads!.toInt() + 1;
            Group updatedGroup = Group.fromJson(data, updatedUnreads);
            groups.removeAt(existingGroupIndex);

            groups.insert(0, updatedGroup); // Update the group in the list
            db.update({'joinedGroups.$groupName': updatedUnreads});
          } else {
            // New group, add it to the list
            print("New group $groupName");
            Group newGroup = Group.fromJson(data, unreads);
            groups.add(newGroup);
          }
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> getGroupIds() async {
    String user = username;
    final db = FirebaseFirestore.instance.collection("users").doc(user);

    db.get().then((querySnapshot) async {
      if (querySnapshot['joinedGroups'] is Map) {
        querySnapshot['joinedGroups'].forEach((key, value) async {
          setListeners(key, value);
        });
      }
    });
  }
}
