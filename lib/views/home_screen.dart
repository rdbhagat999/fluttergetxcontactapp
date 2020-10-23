import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttergetxcontactapp/controllers/controllers.dart';
import 'package:fluttergetxcontactapp/mixins/mixins.dart';
import 'package:fluttergetxcontactapp/models/models.dart';
import 'package:fluttergetxcontactapp/views/views.dart';
import 'package:fluttergetxcontactapp/widgets/widgets.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget with PrintLogMixin {
  static const pageId = 'home_screen';

  final AuthController _authCtrl = Get.find();
  final ContactController _contactCtrl = Get.find();
  final UploadController _uploadCtrl = Get.find();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blueAccent,
      extendBodyBehindAppBar: false,
      extendBody: false,
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.orange,
        tooltip: 'Add New',
        onPressed: () {
          Get.toNamed(AddContactScreen.pageId);
        },
        child: Icon(Icons.person_add),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Obx(
                () => AutoSizeTextWidget(
                  text: "${_authCtrl?.user?.displayName ?? 'Guest'}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: AutoSizeTextWidget(text: 'Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: AutoSizeTextWidget(text: 'Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: AutoSizeTextWidget(text: 'Settings'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: AutoSizeTextWidget(text: 'Logout'),
              onTap: () {
                _authCtrl.signOutUser();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 90, left: 30, right: 30, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.menu,
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
                              text: 'Contacts',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Obx(
                              () => ContactsCountWidget(
                                contactsCount:
                                    _contactCtrl?.contactListCount?.value,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.dangerous),
                        iconSize: 30,
                        onPressed: () {
                          Get.toNamed(TestScreen.pageId);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              // padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
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
              child: Obx(
                () => StreamBuilder<QuerySnapshot>(
                  stream: _contactCtrl.fetchContacts(),
                  builder: (context, stream) {
                    if (stream.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (stream.hasError) {
                      return Center(child: Text(stream.error.toString()));
                    }

                    QuerySnapshot querySnapshot = stream.data;

                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Container(
                        child: ListView.separated(
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          physics: BouncingScrollPhysics(),
                          itemCount: querySnapshot.size,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            final item = querySnapshot.docs[index];
                            // print(item.id);
                            final Contacts contactItem =
                                Contacts.fromQueryDocumentSnapshot(
                                    queryDocSnapshot: item);

                            return SlidableWidget(
                              uniqueId: '${contactItem.name ?? ''}',
                              child: buildListTile(contactItem),
                              onDismissed: (action) {
                                dismissSlidableItem(
                                    context, contactItem, action);
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void dismissSlidableItem(
      BuildContext context, Contacts item, SlidableAction action) async {
    printLog('dismissSlidableItem ${item.name}');

    switch (action) {
      case SlidableAction.archive:
        printLog('Contact has been archived');
        break;
      case SlidableAction.share:
        printLog('Contact has been shared');
        break;
      case SlidableAction.more:
        printLog('Selected more');
        break;
      case SlidableAction.edit:
        printLog('Contact has been updated');
        Get.toNamed(EditContactScreen.pageId, arguments: item);
        break;
      case SlidableAction.delete:
        printLog('Contact has been deleted');
        LoadingIndicatorWidget.showLoadingIndicator();
        if (item.photoId.isNotEmpty) {
          await _uploadCtrl.deleteFile(
              uid: this._authCtrl.user.uid, photoId: item.photoId);
        }
        _contactCtrl.deleteContact(contact: item);
        break;
    }
  }

  Widget buildListTile(Contacts item) => ListTile(
        // tileColor: Colors.black12,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 28,
          backgroundImage: NetworkImage(item?.photoUrl),
          onBackgroundImageError: (dynamic e, StackTrace trace) {
            return Image(
              image: AssetImage('assets/images/user.png'),
            );
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(
              text: item.name.capitalize,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            AutoSizeTextWidget(text: item.primaryPhone)
          ],
        ),
      );
}
