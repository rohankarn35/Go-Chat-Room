import 'dart:math';

class Randomid {
  randomId() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    Random random = Random();
    int randomSuffix = random.nextInt(999999);
    int combined = timestamp + randomSuffix;

    String combinedStr = combined.toString();
    String randomNumber = combinedStr.substring(combinedStr.length - 8);

    return randomNumber;
  }
}
