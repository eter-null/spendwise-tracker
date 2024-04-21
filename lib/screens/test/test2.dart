import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Test2 extends StatefulWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  Stream<Map<String, Map<String, double>>> _getCategoryTotalsByMonthStream() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc('kcOCOXbxLIOC1lxqYMSGN3gQDX83') // Replace with actual UID
        .collection('categories')
        .snapshots()
        .asyncMap((categoriesSnapshot) async {
      Map<String, Map<String, double>> categoryTotalsByMonth = {};

      for (QueryDocumentSnapshot categoryDoc in categoriesSnapshot.docs) {
        List<dynamic> expenseIDs = categoryDoc['expenseID'];

        for (dynamic expenseID in expenseIDs) {
          DocumentSnapshot expenseDoc = await FirebaseFirestore.instance
              .collection('Users')
              .doc('kcOCOXbxLIOC1lxqYMSGN3gQDX83') // Replace with actual UID
              .collection('expenses')
              .doc(expenseID)
              .get();

          Timestamp timestamp = expenseDoc['date'];
          DateTime date = timestamp.toDate();
          String monthYear = DateFormat('yyyy-MM').format(date);

          double expenseAmount = expenseDoc['amount'].toDouble(); // Convert to double

          categoryTotalsByMonth.putIfAbsent(categoryDoc['name'], () => {});

          categoryTotalsByMonth[categoryDoc['name']]!.update(
            monthYear,
                (value) => value + expenseAmount,
            ifAbsent: () => expenseAmount,
          );
        }
      }

      return categoryTotalsByMonth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Totals by Month'),
      ),
      body: StreamBuilder<Map<String, Map<String, double>>>(
        stream: _getCategoryTotalsByMonthStream(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, Map<String, double>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          Map<String, Map<String, double>>? categoryTotalsByMonth = snapshot.data;

          if (categoryTotalsByMonth == null || categoryTotalsByMonth.isEmpty) {
            return Center(child: Text('No categories found'));
          }

          return ListView(
            children: categoryTotalsByMonth.entries.map((categoryEntry) {
              return ExpansionTile(
                title: Text(categoryEntry.key),
                children: categoryEntry.value.entries.map((monthEntry) {
                  return ListTile(
                    title: Text(monthEntry.key),
                    subtitle: Text('Total Expenses: \$${monthEntry.value.toStringAsFixed(2)}'),
                  );
                }).toList(),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
