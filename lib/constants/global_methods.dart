class GlobalMethods{
static const String fontNameInter = "Work Sans";






}

class AppImageNames {
  static const String dummyImage = "";
      // "assets/images/abc.png";
}


class printValue{
 static void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
}