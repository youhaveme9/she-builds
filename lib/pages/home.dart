import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prega/pages/entry_page.dart';
import 'package:prega/pages/signin_page.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              createUser();
              return const EntryPage();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong!"),
              );
            } else {
              return const SignIn();
            }
          },
        ),
      );
  Future createUser() async {
    final user = FirebaseAuth.instance.currentUser!;

    final finalUser =
        FirebaseFirestore.instance.collection('user').doc(user.uid);
    FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (!documentSnapshot.exists) {
        final data = {
          'account_created': DateTime.now(),
          'age': '',
          'allergies': [],
          'blood_group': '',
          'complications': '',
          'current_medicines': [],
          'diseases': [],
          'email': user.email,
          'name': user.displayName,
          'starting_date': DateTime.now(),
          'uid': user.uid,
          'image': user.photoURL
        };
        await finalUser.set(data);
      }
    });
  }
}
