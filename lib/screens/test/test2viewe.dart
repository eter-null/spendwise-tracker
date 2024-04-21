import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewExpense extends StatefulWidget {
  const ViewExpense({Key? key}) : super(key: key);

  @override
  State<ViewExpense> createState() => _ViewExpenseState();
}

class _ViewExpenseState extends State<ViewExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc('kcOCOXbxLIOC1lxqYMSGN3gQDX83') // Replace with actual UID
            .collection('expenses')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              String expenseID = document.id;
              return ListTile(
                title: Text('Amount: \$${data['amount']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date: ${data['date'].toString()}'),
                    Text('Expense ID: $expenseID'),
                    // finding the category name from category collection of the expense
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc('kcOCOXbxLIOC1lxqYMSGN3gQDX83') // Replace with actual UID
                          .collection('categories')
                          .doc(data['categoryID'])
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> categorySnapshot) {
                        if (categorySnapshot.connectionState == ConnectionState.waiting) {
                          return Text('Category: Loading...');
                        }
                        if (!categorySnapshot.hasData || !categorySnapshot.data!.exists) {
                          return Text('Category: Not found');
                        }
                        Map<String, dynamic> categoryData = categorySnapshot.data!.data() as Map<String, dynamic>;
                        return Text('Category: ${categoryData['name']}');
                      },
                    ),
                  ],
                ),
                leading: Icon(Icons.money),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
