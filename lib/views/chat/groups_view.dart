// import 'package:communityapp/controllers/groups_controller.dart';
// import 'package:communityapp/widgets/animatedbuttonbar.dart';
// import 'package:communityapp/widgets/groupbox.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class GroupsView extends StatefulWidget {
//   const GroupsView({super.key});
//   @override
//   State<GroupsView> createState() => _GroupsViewState();
// }

// GroupsController controller = Get.put(GroupsController());

// class _GroupsViewState extends State<GroupsView> {
//   @override
//   void initState() {
//     super.initState();
//     controller.getGroupIds();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.groups_2_rounded, size: 35),
//             SizedBox(
//               width: 20,
//             ),
//             Text(
//               "Community",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(20),
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             AnimatedButtonBar(),
//             const SizedBox(
//               height: 40,
//             ),
//             Obx(() => Container(
//                   alignment: Alignment.topCenter,
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height * 0.7,
//                   child: ListView.builder(
//                     itemCount: controller.groups.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           Center(
//                               child: GroupBox(
//                                   avatar: controller.groups[index].avatar
//                                       .toString(),
//                                   channelName:
//                                       controller.groups[index].name.toString(),
//                                   lastMessage: controller
//                                       .groups[index].lastmessage!.message
//                                       .toString(),
//                                   unreads:
//                                       controller.groups[index].unreads!.toInt(),
//                                   time: controller
//                                       .groups[index].lastmessage!.time!
//                                       .toString())),
//                           const SizedBox(
//                             height: 20,
//                           )
//                         ],
//                       );
//                     },
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:communityapp/controllers/groups_controller.dart';
import 'package:communityapp/widgets/animatedbuttonbar.dart';
import 'package:communityapp/widgets/groupbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});
  @override
  State<GroupsView> createState() => _GroupsViewState();
}

GroupsController controller = Get.put(GroupsController());

class _GroupsViewState extends State<GroupsView> {
  @override
  void initState() {
    super.initState();
    controller.getGroupIds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.groups_2_rounded, size: 35),
            SizedBox(width: 20),
            Text(
              "Community",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedButtonBar(),
            const SizedBox(height: 40),
            Obx(() => Expanded( // Wrap the ListView.builder with Expanded
              child: ListView.builder(
                itemCount: controller.groups.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Center(
                        child: GroupBox(
                          avatar: controller.groups[index].avatar.toString(),
                          channelName: controller.groups[index].name.toString(),
                          lastMessage: controller.groups[index].lastmessage!.message.toString(),
                          unreads: controller.groups[index].unreads!.toInt(),
                          time: controller.groups[index].lastmessage!.time!.toString(),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}