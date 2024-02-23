// v4

// 4. Створити функцію, яка для 3 заданих чисел знаходить одночасно декілька результатів: кількість
// парних, кількість додатних, кількість більших за 100.

void main(List<String> args) {
  print(foo([1,2,3]));
}

Map<String, int> foo(List<int> args){
  // if(args.length != 3){
  //   throw Exception("Значень має бути 3");
  // }
  int evenCount = 0;
  int positiveNumberciunt = 0;
  int higherThan100Count = 0;
  for(int numb in args){
    if(numb%2 == 0) evenCount++;
    if(numb > 0) positiveNumberciunt++;
    if(numb > 100) higherThan100Count++;
  }

  return {
    "even": evenCount,
    "positive": positiveNumberciunt,
    "higher100": higherThan100Count,
  };
}