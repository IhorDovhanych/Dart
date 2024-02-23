// v4

// Написати програму для виведення на екран в два стовпчики всіх а)
// парних; б) непарних чисел та їх квадратів (кубів) із проміжку від m до n.

import 'dart:io';

void main(List<String> args) {
  stdout.write("n: ");
  int n = int.parse(stdin.readLineSync()!);
  stdout.write("m: ");
  int m = int.parse(stdin.readLineSync()!);
  List<int> odd = [];
  List<int> even = [];
  for(int i = n; i <= m; i++){
    if(i%2 == 0){
      even.add(i);
    }
    else{
      odd.add(i);
    }
  }
  print("Парні $even");
  print("Непарні $odd");
}