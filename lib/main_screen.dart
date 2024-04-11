import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> bucketListData = [];

  Future<void> getData() async {
    //Get data from api
    try {
      Response response = await Dio().get(
          "https://fir-demo-a449f-default-rtdb.firebaseio.com/bucketlist.json");

      bucketListData = response.data;

      setState(() {});
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                  'Cannot connect to server. Please try after few seconds'),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bucket List'),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: getData, child: Text('Get Data')),
          Expanded(
            child: ListView.builder(
                itemCount: bucketListData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(bucketListData[index]['image'] ?? ""),
                      ),
                      title: Text(bucketListData[index]['item'] ?? ""),
                      trailing:
                          Text(bucketListData[index]['cost'].toString() ?? ""),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
