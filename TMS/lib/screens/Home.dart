// ignore_for_file: file_names, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tms/Api/NotificationApi.dart';
import 'package:tms/models/Projects.dart';
import 'package:tms/widgets/projects_items.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ProjectList = Projects.Pro_list();
  final ProController = TextEditingController();
  List<Projects> foundProject = [];
  final FlutterLocalNotificationsPlugin FLNP =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    foundProject = ProjectList;
    NotificationApi.initialize(FLNP);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void handleToDoChange(Projects pro) {
      setState(() {
        pro.isDone = !pro.isDone;
      });
    }

    void deleteProjectItems(String id) {
      setState(() {
        ProjectList.removeWhere((item) => item.id == id);
      });
    }

    void AddProjectItem(String proj) {
      setState(() {
        ProjectList.add(Projects(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            description: proj));
      });
      ProController.clear();
    }

    void _Fiter(String EnteredKeyword) {
      List<Projects> results = [];
      if (EnteredKeyword.isEmpty) {
        results = ProjectList;
      } else {
        results = ProjectList.where((item) => item.description
            .toLowerCase()
            .contains(EnteredKeyword.toLowerCase())).toList();
      }
      setState(() {
        foundProject = results;
      });
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 41, 67),
        title: const Text("TMS"),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 40, left: 20, right: 20, bottom: 40),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: TextField(
                          onChanged: (value) => _Fiter(value),
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 20,
                              ),
                              prefixIconConstraints:
                                  BoxConstraints(minHeight: 20, minWidth: 25),
                              border: InputBorder.none,
                              hintText: "Search",
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(141, 0, 0, 0))),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 18.0),
                        child: Text(
                          "All projects",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 30, left: 15, bottom: 20),
                      ),
                      for (Projects prooo in foundProject.reversed)
                        ProjectItems(
                          pro: prooo,
                          OnProjectChanged: handleToDoChange,
                          OnlDeleteItem: deleteProjectItems,
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: ProController,
                    decoration: const InputDecoration(
                        hintText: "Add project item", border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: 50, height: 50),
                    child: ElevatedButton(
                      onPressed: () {
                        AddProjectItem(ProController.text);
                        NotificationApi.showbigTextNotification(
                            title: "TMS",
                            body: "hey there u r successflly added projects to ur pro list",
                            Payload: "Payload",
                            FLN: FLNP);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 20,
                          backgroundColor:
                              const Color.fromARGB(255, 6, 38, 63)),
                      child: const Text(
                        "+",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
