import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  String title, imgPath, description;
  CardWidget(
      {required this.title,
      required this.imgPath,
      required this.description,
      super.key}) ;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black45,
        margin: const EdgeInsets.only(left: 30, right: 30, top: 100),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flex(
              //* Title
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 35),
                )
              ],
            ),
            Flex(
              //* Image
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Image.asset(
                  widget.imgPath,
                  fit: BoxFit.contain,
                ))
              ],
            ),
            Flex(
              //* Description
              direction: Axis.horizontal,
              children: [Text(widget.description)],
            ),
          ],
        ));
  }
}
