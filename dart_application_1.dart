import 'dart:io';
import 'dart:math';

import 'package:dart_application_1/dart_application_1.dart'
    as dart_application_1;
import 'package:test/expect.dart';

class DelimetersCalculator {
  final int a;
  final int b;
  DelimetersCalculator(this.a, this.b);

  int greatestCommonDivisor(int a, int b) {
    if (a % b == 0) {
      return b;
    }
    if (b % a == 0) {
      return a;
    }
    if (a > b) {
      return greatestCommonDivisor(a % b, b);
    }
    return greatestCommonDivisor(a, b % a);
  }

  int leastCommonMultiple(int a, int b) {
    return a ~/ greatestCommonDivisor(a, b) * b;
  }
}

class BinaryOperations {
  final int bin;
  BinaryOperations.zero() : bin = 0;

  int decToBinary(int number) {
    int i = 1, bin = 0;
    while (number > 0) {
      bin = bin + (number % 2) * i;
      number ~/= 2;
      i *= 10;
    }
    return bin;
  }

  int binaryToInt(int bin) {
    int tail = 0, i = 1, dec = 0;
    while (bin != 0) {
      tail = bin % 10;
      dec = dec + tail * i;
      i *= 2;
      bin ~/= 10;
    }
    return dec;
  }
}

class FindCollectionInString {
  String str = '';
  FindCollectionInString.zero() : str = '';

  bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  List<String> findCollectionNum(String str) {
    List<String> list = [];
    for (var i = 0; i < str.length; i++) {
      if (isNumeric(str[i])) {
        list.add(str[i]);
      }
    }
    return list;
  }
}

class ConvertToMap {
  List<String> list = [];
  ConvertToMap.zero() : list = [];

  Map returnMapFromList(List<String> str) {
    var map = Map();

    for (var keyWords in str) {
      if (map.containsKey(keyWords)) {
        map[keyWords]++;
      } else {
        map[keyWords] = 1;
      }
    }
    return map;
  }
}

class ConvertListOfWordsToListOfNumbers {
  List<String> list = [];
  ConvertListOfWordsToListOfNumbers.zero() : list = [];

  List<int> convertWordsToNumbers(List<String> str, var map) {
    List<int> intCollection = [];
    for (var item in str) {
      if (map.containsKey(item)) {
        intCollection.add(int.parse(map[item].toString()));
      }
    }
    return intCollection;
  }
}

class Point {
  final int x;
  final int y;
  final int z;
  Point(this.x, this.y, this.z);

  factory Point.zero() {
    return Point(0, 0, 0);
  }

  factory Point.unit() {
    return Point(1, 1, 1);
  }

  double distanceTo(Point another) {
    var disX = x - another.x;
    var disY = y - another.y;
    var disZ = z - another.z;
    return sqrt(pow(disX, 2) + pow(disY, 2) + pow(disZ, 2));
  }

  double triangleArea(Point secondPoint, Point thirdPoint) {
    var AB = sqrt(pow((x - secondPoint.x), 2) +
        pow((y - secondPoint.y), 2) +
        pow((z - secondPoint.z), 2));
    var BC = sqrt(pow((secondPoint.x - thirdPoint.x), 2) +
        pow((secondPoint.y - thirdPoint.y), 2) +
        pow((secondPoint.z - thirdPoint.z), 2));
    var AC = sqrt(pow((x - thirdPoint.x), 2) +
        pow((y - thirdPoint.y), 2) +
        pow((z - thirdPoint.z), 2));
    var halfPerimeter = (AB + BC + AC) / 2;

    return sqrt(halfPerimeter *
        (halfPerimeter - AB) *
        (halfPerimeter - AC) *
        (halfPerimeter - BC));
  }
}

extension on num {
  double numberInDegree(double value, int power) {
    double answer = value / power;
    double res = value;
    if (power < 0) {
      throw ArgumentError();
    }
    while (module(res - answer) >= 0.001) {
      res = value;
      for (var i = 1; i < power; i++) {
        res = res / answer;
      }
      answer = 0.5 * (res + answer);
    }
    return answer;
  }

  double module(var expression) {
    return (expression > 0) ? expression : -expression;
  }
}

class User {
  String name;
  String email;
  User(this.name, this.email);
  User.zero()
      : name = '',
        email = '';
}

class AdminUser extends User with getMailSystem {
  AdminUser(String name, String email) : super(name, email);
  AdminUser.zero() : super.zero();
}

class GeneralUser extends User {
  GeneralUser(String name, String email) : super(name, email);
  GeneralUser.zero() : super.zero();
}

mixin getMailSystem on User {
  String returnNameOfSites() {
    return email.substring(email.indexOf('@') + 1, email.length);
  }
}

class UserManager<T extends User> {
  final List<T> users = [];

  void addUser(T value) => users.add(value);

  void printUsers() => users.forEach((element) {
        print([element.name, element.email]);
      });
  void removeUser(T value) => users.remove(value);

  List<String> showEmails() {
    List<String> listOfEmails = [];
    users.forEach((element) {
      if (element.email.contains('admin')) {
        listOfEmails.add(element.email
            .substring(element.email.indexOf('@') + 1, element.email.length));

        /// Вопрос, как в этом месте запустить миксин от Юзера getMailSystem
      } else {
        listOfEmails.add(element.email);
      }
    });

    return listOfEmails;
  }
}

void main(List<String> arguments) {
  ////////////////////
  // tests for #1 task
  ////////////////////
  final test1 = DelimetersCalculator(1, 2);
  print(test1.greatestCommonDivisor(12, 30));
  print(test1.leastCommonMultiple(12, 30));

  ////////////////////
  // tests for #2 task
  ////////////////////
  final test2 = BinaryOperations.zero();
  print(test2.decToBinary(11)); //1011
  print(test2.binaryToInt(11110011)); //243

  ////////////////////
  // test for #3 task
  ////////////////////
  final test3 = FindCollectionInString.zero();
  String str = 'Hello5 my 4 name3 is 2Andrei1';
  print(test3.findCollectionNum(str));

  ////////////////////
  // test for #4 task
  ////////////////////
  List<String> listOfWords = [
    'one',
    'two',
    'two',
    'three',
    'three',
    'three',
    'one'
  ];
  final test4 = ConvertToMap.zero();
  print(test4.returnMapFromList(listOfWords));

  ////////////////////
  // test for #5 task
  ////////////////////
  List<String> stringCollection = [
    'one',
    'two',
    'three',
    'cat',
    'dog',
    'four',
    'five',
    'three',
    'zero',
    'monkey'
  ];

  final mapForTest = {
    'zero': 0,
    'one': 1,
    'two': 2,
    'three': 3,
    'four': 4,
    'five': 5,
    'six': 6,
    'seven': 7,
    'eight': 8,
    'nine': 9
  };

  final test5 = ConvertListOfWordsToListOfNumbers.zero();
  print(test5.convertWordsToNumbers(stringCollection, mapForTest));

  ////////////////////
  // test for #6 task
  ////////////////////
  final test6 = Point(1, 2, 3);
  final test7 = Point.zero();
  print(test6.distanceTo(test7));

  ////////////////////
  // test for #7 task
  ////////////////////
  try {
    print(1.numberInDegree(5, -2));
  } catch (e) {
    print(e);
  }

  ////////////////////
  // test for #8 task
  ////////////////////
  final admin = AdminUser('Andrei', 'andreiadmin@gmail.com');
  print(admin.returnNameOfSites());

  AdminUser adminUs = AdminUser('Andrei', 'admin@gmail.com');
  GeneralUser generalUs1 = GeneralUser('Oxana', 'general1@gmail.com');
  GeneralUser generalUs2 = GeneralUser('Anton', 'general2@gmail.com');
  GeneralUser generalUs3 = GeneralUser('Roman', 'general3@gmail.com');
  GeneralUser generalUs4 = GeneralUser('Anatoliy', 'general4@gmail.com');

  var listOfUsers = UserManager<User>();
  listOfUsers.addUser(adminUs);
  listOfUsers.addUser(generalUs1);
  listOfUsers.addUser(generalUs2);
  listOfUsers.addUser(generalUs3);
  listOfUsers.addUser(generalUs4);
  listOfUsers.printUsers();
  listOfUsers.removeUser(generalUs1);
  listOfUsers.printUsers();

  print(listOfUsers.showEmails());
}
