import 'package:flutter/material.dart';
import 'package:music_player_app/screen/detail/view/detail_screen.dart';
import 'package:music_player_app/screen/home/view/home_screen.dart';

Map<String, WidgetBuilder> app_route = {
  "/": (context) => const HomeScreen(),
  "detail":(context) => const DetailScreen(),
};
