// v4

// 4. Дано послідовність вимірів температур протягом року (згенерувати випадковим чином). Необхідно
// визначити максимальну температуру (середню температуру, мінімальну температуру) кожного
// тижня, кожного місяця.

import 'dart:math';

void main(List<String> args) {
  final tempratures = List<int>.generate(365, (int index) => Random().nextInt(30) + 10);
  final map = Map<String, int>.fromIterable(tempratures,
    key: (item) => tempratures.indexOf(item).toString(),
    value: (item) => item);
  print(map);
}