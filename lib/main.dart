import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/screen/home/controller/home_controller.dart';
import 'package:music_player_app/utils/app_routes.dart';

HomeController controller = Get.put(HomeController());
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  controller.getMusic();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    routes: app_route,
  ));
}
