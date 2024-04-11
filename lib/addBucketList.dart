import 'package:flutter/material.dart';

class AddBucketListScreen extends StatefulWidget {
  const AddBucketListScreen({super.key});

  @override
  State<AddBucketListScreen> createState() => _AddBucketListScreenState();
}

class _AddBucketListScreenState extends State<AddBucketListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add bucket list'),
      ),
    );
  }
}
