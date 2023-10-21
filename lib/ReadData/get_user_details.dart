import 'package:attendance_app/show_user_details_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserDetails extends StatefulWidget {
  final String documentID;
  GetUserDetails({required this.documentID});

  @override
  State<GetUserDetails> createState() => _GetUserDetailsState();
}

class _GetUserDetailsState extends State<GetUserDetails> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentID).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            String userName = data["user-name"];
            String email = data["email"];
            String roll = data["roll"];
            int pin = data["pin"];

            if (pin == 20) {
              return UserDetailsCard(
                userName: userName,
                email: email,
                roll: roll,
                documentID: widget
                    .documentID, // Pass the document ID to UserDetailsCard
              );
            }
          } else {
            return const Text('Document not found');
          }
        }
        return Container();
      },
    );
  }
}
