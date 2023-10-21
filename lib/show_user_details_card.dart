import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDetailsCard extends StatefulWidget {
  final String userName;
  final String email;
  final String roll;
  final String documentID;

  UserDetailsCard(
      {required this.userName,
      required this.email,
      required this.roll,
      required this.documentID});

  @override
  State<UserDetailsCard> createState() => _UserDetailsCardState();
}

class _UserDetailsCardState extends State<UserDetailsCard> {
  bool isButtonPressed = false; // Track button press state

  void onPressedFunction() {}
  Future<void> incrementCount() async {
    // Get the current count from Firestore
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.documentID)
        .get();

    // Increment the count
    int currentCount = userDoc['count'] as int;
    currentCount++;

    // Update the count in Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.documentID)
        .update({'count': currentCount});

    setState(() {
      isButtonPressed = !isButtonPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.userName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Roll: ${widget.roll}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'email: ${widget.email}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: incrementCount,
              child: Text(
                  isButtonPressed ? 'Present' : 'Absent'), // Change button text
              style: ElevatedButton.styleFrom(
                primary: isButtonPressed
                    ? Colors.green // Change button color when pressed
                    : Colors.red, // Reset button color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
