import 'dart:io';

void main(List<String> args) {
  stdout.write('Введіть перше число: ');
  int? n1 = int.tryParse(stdin.readLineSync()!);
  
  stdout.write('Введіть друге число: ');
  int? n2 = int.tryParse(stdin.readLineSync()!);

  
  stdout.write('Введіть трете число: ');
  int? n3 = int.tryParse(stdin.readLineSync()!);
  print(n1!+n2!+n3!);

  List<int> l1 = [1,2,3];
  for( int i = 0; i < l1.length; i++){
    print(l1[i]);
  }
}