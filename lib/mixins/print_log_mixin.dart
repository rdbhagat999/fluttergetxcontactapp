mixin PrintLogMixin {
  void printLog(dynamic data) {
    print('********** LOG START *********');
    if (data != null) {
      print('');
      print(data.toString());
      print('');
    } else {
      print('nothing to print');
    }
    print('********** LOG END *********');
  }
}
