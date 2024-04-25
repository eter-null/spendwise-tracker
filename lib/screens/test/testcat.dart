import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var collection = FirebaseFirestore.instance.collection('categories');
  bool isLoaded = false;
  late List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    List<Map<String, dynamic>> categories = [];
    var data = await collection.get();
    data.docs.forEach((element) {
      var itemData = element.data();
      print("Fetched Data: $itemData"); // Printing fetched item data
      categories.add(itemData);
    });

    setState(() {
      items = categories;
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Data')),
      body: isLoaded
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                print("Displaying Item: $item"); // Printing item during list rendering
                return ListTile(
                  title: Text(item['name']?.toString() ?? "No Name"),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
