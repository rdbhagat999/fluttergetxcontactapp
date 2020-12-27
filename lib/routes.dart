import 'package:fluttergetxcontactapp/bindings/home_screen_bindings.dart';
import 'package:fluttergetxcontactapp/views/views.dart';
import 'package:get/get.dart';

import 'bindings/bindings.dart';

final List<GetPage> appPages = [
  GetPage(
    name: RootScreen.pageId,
    page: () => RootScreen(),
    binding: RootScreenBindings(),
  ),
  GetPage(
    name: LoginScreen.pageId,
    page: () => LoginScreen(),
  ),
  GetPage(
    name: RegisterScreen.pageId,
    page: () => RegisterScreen(),
  ),
  GetPage(
    name: HomeScreen.pageId,
    page: () => HomeScreen(),
    binding: HomeScreenBindings(),
  ),
  GetPage(
    name: AddContactScreen.pageId,
    page: () => AddContactScreen(),
    binding: AddContactScreenBindings(),
  ),
  GetPage(
    name: EditContactScreen.pageId,
    page: () => EditContactScreen(),
  ),
  GetPage(
    name: TestScreen.pageId,
    page: () => TestScreen(),
  ),
];
