import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttergetxcontactapp/controllers/controllers.dart';
import 'package:fluttergetxcontactapp/mixins/mixins.dart';
import 'package:fluttergetxcontactapp/views/views.dart';
import 'package:fluttergetxcontactapp/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddContactScreen extends StatefulWidget with PrintLogMixin {
  static const pageId = 'add_contact_screen';

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final AuthController _authCtrl = Get.find();
  final ContactController _contactCtrl = Get.find();
  final UploadController _uploadCtrl = Get.find();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameInputCtrl = TextEditingController();

  final TextEditingController _emailInputCtrl = TextEditingController();

  final TextEditingController _primaryPhoneInputCtrl = TextEditingController();

  final TextEditingController _secondaryPhoneInputCtrl =
      TextEditingController();

  void handleFormSubmit(context) async {
    handleFocus(context);

    if (this._formKey.currentState.validate()) {
      LoadingIndicatorWidget.showLoadingIndicator();

      StorageTaskSnapshot taskSnap;
      dynamic downloadURL;
      StorageMetadata photoMetadata;

      if (_uploadCtrl.imageFile.value != null) {
        taskSnap = await _uploadCtrl.uploadFile(
          file: _uploadCtrl.imageFile.value,
          uid: _authCtrl.user.uid.trim(),
        );
        downloadURL = await taskSnap.ref.getDownloadURL();
        photoMetadata = await taskSnap.ref.getMetadata();
      }

      print(photoMetadata.customMetadata);

      _contactCtrl.saveContact(
        userId: _authCtrl.user.uid.trim(),
        name: _nameInputCtrl.text.trim(),
        email: _emailInputCtrl.text.trim(),
        primaryPhone: _primaryPhoneInputCtrl.text.trim(),
        secondaryPhone: _secondaryPhoneInputCtrl.text.trim(),
        photoId: photoMetadata?.customMetadata['photoId'] ?? '',
        photoUrl: downloadURL ?? '',
      );
    }
  }

  void handleFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blueAccent,
      extendBodyBehindAppBar: false,
      extendBody: false,
      body: GestureDetector(
        onTap: () {
          handleFocus(context);
        },
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 90, left: 30, right: 30, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.offNamed(HomeScreen.pageId);
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black54,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              AutoSizeTextWidget(
                                text: 'Add Contact',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Obx(
                                () => AutoSizeTextWidget(
                                  text:
                                      '${_contactCtrl?.contactListCount?.value ?? "0"} Contacts',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 6.0,
                      offset: Offset(0, -2),
                      spreadRadius: 0.5,
                    )
                  ],
                ),
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: buildFormInputDecoration(
                              hintText: 'Enter name', icon: Icons.account_box),
                          controller: _nameInputCtrl,
                          validator: (name) => (name.trim().isEmpty)
                              ? 'Please enter a valid name'
                              : null,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: buildFormInputDecoration(
                              hintText: 'Enter email', icon: Icons.email),
                          controller: _emailInputCtrl,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: buildFormInputDecoration(
                              hintText: 'Enter primary phone',
                              icon: Icons.phone),
                          controller: _primaryPhoneInputCtrl,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: buildFormInputDecoration(
                              hintText: 'Enter alt phone', icon: Icons.phone),
                          controller: _secondaryPhoneInputCtrl,
                        ),
                        Obx(() => (_uploadCtrl.imageFile.value != null)
                            ? _uploadCtrl.previewImage()
                            : SizedBox(
                                height: 10.0,
                              )),
                        FlatButton.icon(
                          onPressed: () {
                            _uploadCtrl.pickImage(source: ImageSource.gallery);
                          },
                          icon: const Icon(Icons.photo_library),
                          label: Text('Pick Image from gallery'),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FlatButton(
                          onPressed: () => handleFormSubmit(context),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.0),
                            padding: EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            decoration: buildFlatButtonConatinerDecoration(
                                color: Theme.of(context).primaryColor),
                            child: AutoSizeTextWidget(
                              text: 'Save',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration buildFlatButtonConatinerDecoration({Color color}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 3.0,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  InputDecoration buildFormInputDecoration({String hintText, IconData icon}) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
      fillColor: Colors.white70,
      filled: true,
      hintText: '$hintText',
      prefixIcon: Icon(icon),
    );
  }
}
