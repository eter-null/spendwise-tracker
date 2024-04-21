import 'package:cloud_firestore/cloud_firestore.dart';

class MockFirestore {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  static Future<void> setupMockData() async {
    // Create a collection named 'analytics'
    CollectionReference analytics = _instance.collection('analytics');

    // Add sample documents to the collection
    await analytics.doc('1').set({'day': 'Mn', 'left': 5, 'right': 12});
    await analytics.doc('2').set({'day': 'Te', 'left': 16, 'right': 12});
    await analytics.doc('3').set({'day': 'Wd', 'left': 18, 'right': 5});
    await analytics.doc('4').set({'day': 'Tu', 'left': 20, 'right': 16});
    await analytics.doc('5').set({'day': 'Fr', 'left': 17, 'right': 6});
    await analytics.doc('6').set({'day': 'St', 'left': 19, 'right': 1.5});
    await analytics.doc('7').set({'day': 'Su', 'left': 10, 'right': 1.5});
  }
}
