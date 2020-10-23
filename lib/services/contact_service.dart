import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttergetxcontactapp/mixins/mixins.dart';
import 'package:fluttergetxcontactapp/models/models.dart';

class ContactService with PrintLogMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchContacts(String userId) {
    return _firestore
        .collection("users")
        .doc(userId.toString())
        .collection('contacts')
        .snapshots();
  }

  Future<Contacts> createNewContact(dynamic contact) async {
    DocumentReference docRef = _firestore
        .collection("users")
        .doc(contact.userId.toString())
        .collection('contacts')
        .doc();

    await docRef.set({
      "id": docRef.id,
      "userId": contact.userId,
      "name": contact.name,
      "primaryPhone": contact.primaryPhone,
      "secondaryPhone": contact.secondaryPhone,
      "email": contact.email,
      "photoUrl": contact?.photoUrl,
      "photoId": contact?.photoId,
    });
    return contact;
  }

  Future<Contacts> updateContact(dynamic contact) async {
    DocumentReference docRef = _firestore
        .collection("users")
        .doc(contact.userId.toString())
        .collection('contacts')
        .doc(contact.id);

    await docRef.update({
      "name": contact.name,
      "primaryPhone": contact.primaryPhone,
      "secondaryPhone": contact.secondaryPhone,
      "email": contact.email,
      // "photoUrl": contact?.photoUrl,
      "photoId": contact?.photoId,
    });
    return contact;
  }

  Future<Contacts> deleteContact(dynamic contact) async {
    await _firestore
        .collection("users")
        .doc(contact.userId.toString())
        .collection('contacts')
        .doc(contact.id)
        .delete();
    return contact;
  }
}
