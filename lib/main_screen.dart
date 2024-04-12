import 'package:bucketlist/addBucketList.dart';
import 'package:bucketlist/viewItem.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> bucketListData = [];
  bool isLoading = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    //Get data from api
    try {
      Response response = await Dio().get(
          "https://fir-demo-a449f-default-rtdb.firebaseio.com/bucketlist.json");

      bucketListData = response.data;
      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text(
                  'Cannot connect to server. Please try after few seconds'),
            );
          });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddBucketListScreen();
          }));
        },
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Bucket List'),
        actions: [
          InkWell(
              onTap: getData,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.refresh),
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getData();
        },
        child: isLoading
            ? const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(child: CircularProgressIndicator()),
              )
            : ListView.builder(
                itemCount: bucketListData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ViewItemScreen(
                              title: bucketListData[index]['item'] ?? "",
                              image: bucketListData[index]['image'] ?? "");
                        }));
                      },
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
      ),
    );
  }
}
