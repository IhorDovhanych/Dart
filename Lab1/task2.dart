// v4

// З клавіатури вводиться вік людини. Вивести на екран ким він є
// (дитиною у садочку, школярем, студентом, працівником, пенсіонером).

import 'dart:io';

void main(List<String> args) {
  stdout.write("Введіть вік користувача: ");
  int userAge = int.parse(stdin.readLineSync()!);
  if(userAge < 0) throw Exception("Самий розумний чи шо, вік не може бути < 0");
  else if(userAge < 7) print("Дитина в садочку");
  else if(userAge < 17) print("Школяр");
  else if(userAge < 22) print("Студент");
  else if(userAge < 55) print("Працівник (раб суспільства)");
  else if(userAge < 100) print("Пенсіонер");
  else print("Чіназес");
}