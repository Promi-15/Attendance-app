import 'package:attendance_app/ReadData/get_user_details.dart';
import 'package:attendance_app/screens/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];
  bool docIDsLoaded = false; // Add a flag to track if docIDs are loaded

  Future<void> getDocId() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    docIDs = snapshot.docs.map((doc) => doc.id).toList();
    setState(() {
      docIDsLoaded = true; // Set the flag when docIDs are loaded
    });
  }

  @override
  void initState() {
    super.initState();
    getDocId(); // Load docIDs when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Students List',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!docIDsLoaded)
              const CircularProgressIndicator() // Show loading indicator while docIDs are loading
            else
              Expanded(
                  child: ListView.builder(
                itemCount: docIDs.length,
                itemBuilder: (context, index) {
                  return GetUserDetails(documentID: docIDs[index]);
                },
              )),
          ],
        ),
      ),
    );
  }
}
