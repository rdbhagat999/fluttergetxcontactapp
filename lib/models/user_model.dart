import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttergetxcontactapp/mixins/mixins.dart';

class UserModel with PrintLogMixin {
  String id;
  String email;

  UserModel({
    @required this.id,
    @required this.email,
  });

  UserModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    email = documentSnapshot["email"];
  }
}
