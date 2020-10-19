import 'package:flutter/material.dart';
import 'package:fluttergetxcontactapp/controllers/controllers.dart';
import 'package:fluttergetxcontactapp/mixins/mixins.dart';
import 'package:fluttergetxcontactapp/views/views.dart';
import 'package:fluttergetxcontactapp/widgets/widgets.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget with PrintLogMixin {
  static const pageId = 'register_screen';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailInputCtrl = TextEditingController();
  final TextEditingController _passwordInputCtrl = TextEditingController();

  final AuthController _authCtrl = Get.find();

  handleFormSubmit() async {
    if (this._formKey.currentState.validate()) {
      printLog(this._formKey.currentState);
      await _authCtrl.register(_emailInputCtrl.text, _passwordInputCtrl.text);
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
                        onTap: () {
                          handleFocus(context);
                        },
                        textList: ['Flutter Contacts'],
                        textStyle:
                            TextStyle(fontSize: 30.0, color: Colors.black54),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: buildFormInputDecoration(
                            hintText: 'Enter email', icon: Icons.email),
                        controller: _emailInputCtrl,
                        validator: (email) => (!email.trim().contains('@'))
                            ? 'Please enter a valid email address'
                            : null,
                      ),
                      TextFormField(
                        decoration: buildFormInputDecoration(
                            hintText: 'Enter password', icon: Icons.lock),
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
                            text: 'Sign up',
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
                        onPressed: () => Get.offAllNamed(LoginScreen.pageId),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: AutoSizeTextWidget(
                            text: 'Already have an account? Click here.',
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
