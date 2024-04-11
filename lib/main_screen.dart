import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<void> getData() async {
    //Get data from api
    try {
      Response response = await Dio().get(
          "https://fir-demo-a449f-default-rtdb.firebaseio.kodsk/bucketlist.json");

      print(response.data);
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
      body: ElevatedButton(onPressed: getData, child: Text('Get Data')),
    );
  }
}
