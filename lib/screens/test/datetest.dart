import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTest extends StatefulWidget {
  const DateTest({Key? key}) : super(key: key);

  @override
  State<DateTest> createState() => _DateTestState();
}

class _DateTestState extends State<DateTest> {
  String documentId = "/Users/kcOCOXbxLIOC1lxqYMSGN3gQDX83/totals/January 2024";

  DateTime parseDocumentIdToDate(String documentId) {
    // Split the document ID to get the month and year
    List<String> parts = documentId.split('/');
    String monthAndYear = parts[parts.length - 1];

    // Parse the month and year into a DateTime object
    DateFormat format = DateFormat("MMMM yyyy");
    return format.parse(monthAndYear);
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateFromDocumentId = parseDocumentIdToDate(documentId);
    return Scaffold(
      appBar: AppBar(
        title: Text("Date Test"),
      ),
      body: Center(
        child: Text("Date from Document ID: $dateFromDocumentId"),
      ),
    );
  }
}
