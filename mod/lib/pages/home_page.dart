import 'package:flutter/material.dart';
import 'package:mod/models/card_model.dart';
import 'package:mod/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<CardModel> petList;
  int i = 0;
  @override
  void initState() {
    super.initState();
    CardModel pet1 = CardModel(
        title: "Dog",
        imgPath: "assets/img/test.png",
        description: 'Some description');
    CardModel pet2 = CardModel(
        title: "Cat",
        imgPath: "assets/img/cat.png",
        description: 'Some description');
    CardModel pet3 = CardModel(
        title: "Mouse",
        imgPath: "assets/img/mouse.png",
        description: 'Some description');
    CardModel pet4 = CardModel(
        title: "Parrot",
        imgPath: "assets/img/parrots.png",
        description: 'Some description');
    petList = [pet1, pet2, pet3, pet4];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Flex(
      direction: Axis.vertical,
      children: [
        CardWidget(
            title: petList[i].title,
            imgPath: petList[i].imgPath,
            description: petList[i].description),
        Container(
          margin: const EdgeInsets.only(left: 30, right: 30, top: 40),
          child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (i == 0) {
                    i = petList.length - 1;
                  } else {
                    i--;
                  }
                });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black54)),
              child: const Text(
                "Попередня",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Text('${i+1}'),
            TextButton(
              onPressed: () {
                setState(() {
                  if (i + 1 == petList.length) {
                    i = 0;
                  } else {
                    i++;
                  }
                });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black54)),
              child: const Text(
                "Наступна",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ))
      ],
    ));
  }
}
