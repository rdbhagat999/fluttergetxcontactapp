import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttergetxcontactapp/mixins/mixins.dart';

class ContactModel with PrintLogMixin {
  List<Contacts> contacts;

  ContactModel({this.contacts});

  ContactModel.fromJson(Map<String, dynamic> json) {
    if (json['contacts'] != null) {
      contacts = new List<Contacts>();
      json['contacts'].forEach((v) {
        contacts.add(new Contacts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contacts != null) {
      data['contacts'] = this.contacts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contacts {
  String id;
  String userId;
  String name;
  String email;
  String primaryPhone;
  String secondaryPhone;
  String photoUrl;
  String photoId;

  Contacts({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.primaryPhone,
    this.secondaryPhone,
    this.photoUrl,
    this.photoId,
  });

  Contacts.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot["id"] ?? '';
    userId = documentSnapshot["userId"] ?? '';
    name = documentSnapshot["name"] ?? '';
    email = documentSnapshot["email"] ?? '';
    primaryPhone = documentSnapshot["primaryPhone"] ?? '';
    secondaryPhone = documentSnapshot["secondaryPhone"] ?? '';
    photoUrl = documentSnapshot["photoUrl"] ?? '';
    photoId = documentSnapshot["photoId"] ?? '';
  }

  Contacts.fromQueryDocumentSnapshot({QueryDocumentSnapshot queryDocSnapshot}) {
    var data = queryDocSnapshot.data();
    id = data["id"] ?? '';
    userId = data["userId"] ?? '';
    name = data["name"] ?? '';
    email = data["email"] ?? '';
    primaryPhone = data["primaryPhone"] ?? '';
    secondaryPhone = data["secondaryPhone"] ?? '';
    photoUrl = data["photoUrl"] ?? '';
    photoId = data["photoId"] ?? '';
  }

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    primaryPhone = json['primaryPhone'];
    secondaryPhone = json['secondaryPhone'];
    photoUrl = json['photoUrl'];
    photoId = json['photoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['primaryPhone'] = this.primaryPhone;
    data['secondaryPhone'] = this.secondaryPhone;
    data['photoUrl'] = this.photoUrl;
    data['photoId'] = this.photoId;
    return data;
  }
}
