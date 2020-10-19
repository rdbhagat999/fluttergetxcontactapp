import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttergetxcontactapp/controllers/controllers.dart';
import 'package:fluttergetxcontactapp/helpers/helpers.dart';
import 'package:fluttergetxcontactapp/mixins/mixins.dart';
import 'package:fluttergetxcontactapp/models/models.dart';
import 'package:fluttergetxcontactapp/services/services.dart';
import 'package:fluttergetxcontactapp/views/views.dart';
import 'package:get/get.dart';

class ContactController extends GetxController with PrintLogMixin {
  RxInt _contactListCount = 0.obs;
  RxInt get contactListCount => _contactListCount;
  void setContactListCount(int val) => _contactListCount.value = val;

  AuthController _authController = Get.find();
  ContactService _contactService = ContactService();

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  Stream<QuerySnapshot> fetchContacts() {
    Stream<QuerySnapshot> qSnapStream =
        _contactService.fetchContacts(_authController?.user?.uid);

    qSnapStream.forEach((QuerySnapshot qSnapItem) {
      setContactListCount(qSnapItem.size);
    });

    return qSnapStream;
  }

  void saveContact({
    String userId,
    String name,
    String email,
    String primaryPhone,
    String secondaryPhone,
    String photoUrl,
    String photoId,
  }) async {
    try {
      Contacts _contact = Contacts(
        userId: _authController?.user?.uid,
        name: name,
        email: email,
        primaryPhone: primaryPhone,
        secondaryPhone: secondaryPhone,
        photoUrl: photoUrl,
        photoId: photoId,
      );

      await _contactService.createNewContact(_contact);
      Get.back(); // dismiss loading indicator
      Get.offNamed(HomeScreen.pageId);
      Helpers.showSnackbar(title: 'Success', message: 'Contact saved');
    } catch (e) {
      printLog(e.toString());
      Helpers.showSnackbar(
          title: 'Error', message: e?.message ?? 'something went wrong');
    }
  }

  void updateContact({
    String id,
    String userId,
    String name,
    String email,
    String primaryPhone,
    String secondaryPhone,
    String photoUrl,
  }) async {
    try {
      Contacts _contact = Contacts(
        id: id,
        userId: _authController?.user?.uid,
        name: name,
        email: email,
        primaryPhone: primaryPhone,
        secondaryPhone: secondaryPhone,
        photoUrl: photoUrl,
      );

      await _contactService.updateContact(_contact);
      Get.offNamed(HomeScreen.pageId);
      Helpers.showSnackbar(title: 'Success', message: 'Contact updated');
    } catch (e) {
      printLog(e.toString());
      Helpers.showSnackbar(
          title: 'Error', message: e?.message ?? 'something went wrong');
    }
  }

  void deleteContact({Contacts contact}) async {
    try {
      await _contactService.deleteContact(contact);
      Get.back(); // dismiss loading indicator
      Helpers.showSnackbar(title: 'Success', message: 'Contact deleted');
    } catch (e) {
      printLog(e.toString());
      Helpers.showSnackbar(
          title: 'Error', message: e?.message ?? 'something went wrong');
    }
  }
}
