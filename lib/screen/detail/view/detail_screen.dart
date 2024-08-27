import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/screen/home/controller/home_controller.dart';
import 'package:music_player_app/screen/home/model/home_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    controller.initMusic();
  }

  HomeController controller = Get.put(HomeController());
  Song s1 = Get.arguments;

  @override
  Widget build(BuildContext context) {
    s1 = ModalRoute.of(context)!.settings.arguments as Song;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Obx(()=> Text(controller.l2[controller.index.value].song)),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  height: 300,
                  width: 300,
                  child: Obx(()=>
                    Image.network(
                      (controller.l2[controller.index.value].data.image),
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  )),
            ),
            PlayerBuilder.currentPosition(
              player: controller.assetsAudioPlayer,
              builder: (context, position) {
                return Column(
                  children: [
                    Theme(
                      data: ThemeData(useMaterial3: false),
                      child: Slider(
                        value: position.inSeconds.toDouble(),
                        onChanged: (value) {
                          controller.assetsAudioPlayer
                              .seek(Duration(seconds: value.toInt()));
                        },
                        max: controller.totalDuration.inSeconds.toDouble(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("$position",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18)),
                          Text("${controller.totalDuration}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(
                              angle: (pi * 2) / 2,
                              child: IconButton(
                                onPressed: () {
                                  controller.assetsAudioPlayer.pause();
                                  controller.changeButton(false);
                                  controller.assetsAudioPlayer.previous();
                                  controller.changeButton(true);
                                   controller.previousOrNext(
                                       controller.index.value - 1);

                                },
                                icon: const Icon(Icons.double_arrow),
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                if (controller.isPlay.value==true) {
                                  controller.assetsAudioPlayer.pause();
                                  controller.changeButton(false);
                                } else {
                                  controller.assetsAudioPlayer.play();
                                  controller.changeButton(true);
                                }
                              },
                              icon: Icon(controller.isPlay.value
                                  ? Icons.pause
                                  : Icons.play_arrow),
                              color: Colors.white),
                          IconButton(
                              onPressed: () {
                                controller.assetsAudioPlayer.pause();
                                controller.changeButton(false);
                                controller.assetsAudioPlayer.next();
                                controller.changeButton(true);
                                controller
                                    .previousOrNext(controller.index.value + 1);

                              },
                              icon: const Icon(Icons.double_arrow),
                              color: Colors.white),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
