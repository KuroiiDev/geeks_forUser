class Endpoint {

  static const String ipPort = "192.168.1.18:8000";

  static const String baseUrlApi = "http://$ipPort/api/user/";



  static const String register = "${baseUrlApi}register";
  static const String login = "${baseUrlApi}login";
  static const String edit = "${baseUrlApi}edit";
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
  static const String genreList = "${baseUrlApi}genre";
  static const String genreBook = "${baseUrlApi}genre/book";
  static const String genreGenre = "${baseUrlApi}genre/genre";
  static const String rating = "${baseUrlApi}rating";
}
