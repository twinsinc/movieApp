import 'package:flutter/cupertino.dart';

const titleStyle = TextStyle(fontSize: 20, color: CupertinoColors.systemIndigo);
const descriptionStyle = TextStyle(fontSize: 15, color: CupertinoColors.systemIndigo);

const ratingStyle = TextStyle(
  color: CupertinoColors.white,
  fontSize: 40,
  fontWeight: FontWeight.w900,
);

const ratingGradient = LinearGradient(
    colors: [CupertinoColors.destructiveRed, CupertinoColors.systemYellow],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter);
