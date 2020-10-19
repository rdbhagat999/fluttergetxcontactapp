import 'package:get/get.dart';

class DialogController extends GetxController {
  final List<String> _countries = [
    'United Kingdom',
    'USA',
    'France',
    'Australia',
    'New Zealand',
    'Germany',
    'Vietnam',
    'India',
  ].obs;
  List<String> get itemList => _countries;
  String _selectedItem = 'Germany';
  String get selectedItem => _selectedItem;
  void setSelectedItem(String v) => _selectedItem = v;

  List<String> _selectedItemList = [];
  List<String> get selectedItemList => _selectedItemList;
  void _addSelectedItem(String v) => _selectedItemList.add(v);
  void _removeSelectedItem(String v) => _selectedItemList.remove(v);

  void updateCheckList(String v) {
    if (v.isNotEmpty) {
      _selectedItemList.contains(v)
          ? _removeSelectedItem(v)
          : _addSelectedItem(v);
    }
  }
}
