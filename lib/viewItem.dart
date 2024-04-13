import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ViewItemScreen extends StatefulWidget {
  String title;
  String image;
  int index;

  ViewItemScreen(
      {super.key,
      required this.title,
      required this.image,
      required this.index});

  @override
  State<ViewItemScreen> createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {
  Future<void> deleteData() async {
    Navigator.pop(context);
    try {
      Response response = await Dio().delete(
          "https://fir-demo-a449f-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json");
      Navigator.pop(context);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(onSelected: (value) {
            if (value == 1) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Sure you wanna delete?'),
                      actions: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel')),
                        InkWell(onTap: deleteData, child: Text('Confirm'))
                      ],
                    );
                  });
            }
          }, itemBuilder: (context) {
            return [
              PopupMenuItem(value: 1, child: Text('Delete')),
              PopupMenuItem(value: 2, child: Text('Mark as done'))
            ];
          })
        ],
        title: Text('${widget.title}'),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(widget.image))),
          ),
        ],
      ),
    );
  }
}
