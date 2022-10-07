// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tms/models/Projects.dart';

class ProjectItems extends StatelessWidget {
  const ProjectItems({
    Key? key,
    required this.pro,
    this.OnProjectChanged,
    this.OnlDeleteItem,
  }) : super(key: key);
  final Projects pro;
  final OnProjectChanged;
  final OnlDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
      child: ListTile(
        onTap: () {
          OnProjectChanged(pro);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        textColor: const Color.fromARGB(255, 9, 40, 65),
        leading: Icon(
          pro.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Color.fromARGB(255, 4, 26, 44),
        ),
        title: Text(
          pro.description,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: pro.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
              onPressed: () {
                OnlDeleteItem(pro.id);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 18,
              )),
        ),
      ),
    );
  }
}
