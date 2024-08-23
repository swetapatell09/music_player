import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/main.dart'; // Ensure this import contains your controller
import 'package:vertical_card_pager/vertical_card_pager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    controller.getMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Obx(
        () {
          final musicItems = controller.l2;
          if (musicItems.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          final titles = musicItems.map((item) => item.song).toList();
          final images =
              musicItems.map((item) => Image.network(item.data.image)).toList();

          return VerticalCardPager(
            titles: titles,
            images: images,
            onSelectedItem: (index) {
              Get.toNamed('detail',arguments: musicItems[index]);
              controller.changeIndex(index);
            },
            initialPage: 0,
            textStyle: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
            // optional
            align: ALIGN.CENTER,
            // optional
            physics: const ClampingScrollPhysics(),
          );
        },
      ),
    );
  }
}
