class Endpoint {
  static const String baseUrlApi = "http://127.0.0.1:8000/api/user/";



  static const String register = "${baseUrlApi}register";
  static const String login = "${baseUrlApi}login";
  static const String book = "${baseUrlApi}book";
  static const String user = "${baseUrlApi}id";
  static const String request = "${baseUrlApi}rent/request";
  static const String rentId = "${baseUrlApi}rent/id";
  static const String rentUser = "${baseUrlApi}rent/user";
  static const String rentCurrent = "${baseUrlApi}rent/current";
  static const String bookmark = "${baseUrlApi}bookmark/user";
  static const String removeBookmark = "${baseUrlApi}bookmark/remove";
  static const String addBookmark = "${baseUrlApi}bookmark/add";
  static const String checkBookmark = "${baseUrlApi}bookmark/check";

  /*
  static const String book = "${baseUrlApi}book";
  static const String koleksi = "${baseUrlApi}koleksi";
  static const String pinjam = "${baseUrlApi}pinjam";
  */
}
