// v4

// 4. Реалізувати клас, що представляє трикутник (трикутник задається довжинами сторін) і
// містить опис індексатора для доступу до сторін трикутника( – перша сторона, – друга сторона, –
// третя сторна). Передбачаити методи введення/виведення, знаходження периметру та площі.

import 'dart:math';

void main(List<String> args) {
  Triangle t1 = Triangle(3, 4, 5);
  print("Периметер ${t1.calcPerimeter()}");
  print("Площа ${t1.calcArea()}");
}
class Triangle{
  double? firstSide, secondSide, thirdSide;

  Triangle(double firstSide, double secondSide, double thirdSide){
    if(firstSide <= 0 || secondSide <= 0 || thirdSide <= 0){
      throw Exception("Invalid values, them couldn't be < 0");
    }
    else{
      this.firstSide = firstSide;
      this.secondSide = secondSide;
      this.thirdSide = thirdSide;
    }
  }

  double calcPerimeter(){
    return this.firstSide! + this.secondSide! + this.thirdSide!;
  }

  double calcArea(){
    double semiPerimeter = calcPerimeter()/2; 
    return sqrt(semiPerimeter*(semiPerimeter-this.firstSide!)*(semiPerimeter-this.secondSide!)*(semiPerimeter-this.thirdSide!));
  }
}