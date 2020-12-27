import 'package:flutter/material.dart';
import 'package:fluttergetxcontactapp/controllers/controllers.dart';
import 'package:fluttergetxcontactapp/mixins/mixins.dart';
import 'package:fluttergetxcontactapp/views/views.dart';
import 'package:fluttergetxcontactapp/widgets/widgets.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget with PrintLogMixin {
  static const pageId = 'login_screen';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailInputCtrl = TextEditingController();
  final TextEditingController _passwordInputCtrl = TextEditingController();

  final AuthController _authCtrl = Get.find();

  handleFormSubmit() async {
    if (this._formKey.currentState.validate()) {
      printLog(this._formKey.currentState);
      await _authCtrl.login(_emailInputCtrl.text, _passwordInputCtrl.text);
    }
  }

  handleFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handleFocus(context);
      },
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        extendBody: false,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TypewriterWidget(
                        textList: ['Flutter Contacts'.tr],
                        textStyle:
                            TextStyle(fontSize: 30.0, color: Colors.black54),
                        onTap: () {
                          handleFocus(context);
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: buildFormInputDecoration(
                            hintText: 'Enter email'.tr, icon: Icons.email),
                        controller: _emailInputCtrl,
                        validator: (email) => (!email.trim().contains('@'))
                            ? 'Please enter a valid email address'
                            : null,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: buildFormInputDecoration(
                            hintText: 'Enter password'.tr, icon: Icons.lock),
                        controller: _passwordInputCtrl,
                        validator: (password) => (password.trim().length < 6)
                            ? 'Password must be at least 6 characters long'
                            : null,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      FlatButton(
                        onPressed: handleFormSubmit,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          decoration: buildFlatButtonConatinerDecoration(
                              color: Theme.of(context).primaryColor),
                          child: AutoSizeTextWidget(
                            text: 'Sign in'.tr,
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
                      FlatButton(
                        onPressed: () {
                          _authCtrl.signInWithGoogle();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          decoration: buildFlatButtonConatinerDecoration(
                              color: Colors.red[700]),
                          child: AutoSizeTextWidget(
                            text: 'Signin with Google'.tr,
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
                      Divider(
                        thickness: 1,
                      ),
                      FlatButton(
                        onPressed: () => Get.toNamed(RegisterScreen.pageId),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: AutoSizeTextWidget(
                            text: "Don't have an account? Click here.".tr,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
