// v4

// З клавіатури вводиться вік дитини. Вивести на екран через скільки років вона
// буде відвідувати садочок, піде у школу, закінчить школу, вступить і закінчить

import 'dart:io';

void main() {
  stdout.write("Введіть вік дитини: ");
  int childAge = int.parse(stdin.readLineSync()!);
  int gardenAge = 1;
  int schoolStart = 6;
  int schoolEnd = 17;
  int uniStart = 18;
  int uniEnd = 22;
  if(childAge < 0){
    throw Exception("Invalid childAge value, childAge=$childAge");
  }
  else{
    gardenAge -= childAge;
    schoolStart -= childAge;
    schoolEnd -= childAge;
    uniStart -= childAge;
    uniEnd -= childAge;
    if(gardenAge > 0) print("Дитина піде в садочок через $gardenAge років");
    if(schoolStart > 0) print("Дитина піде в школу через $schoolStart років");
    if(schoolEnd > 0) print("Дитина закінчить школу через $schoolEnd років");
    if(uniStart > 0) print("Дитина піде в університет через $uniStart років");
    if(uniEnd > 0) print("Дитина закінчить університет через $uniEnd років");
  }
}
