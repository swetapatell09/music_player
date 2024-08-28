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

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    controller.initMusic();
  }

  HomeController controller = Get.put(HomeController());
  Song s1 = Get.arguments;

  @override
  Widget build(BuildContext context) {
    s1 = ModalRoute
        .of(context)!
        .settings
        .arguments as Song;
    return Scaffold(
        backgroundColor: Colors.black,

        body: Stack(
          children: [
            Image.asset(
              "assets/image/music.png",
              height: MediaQuery
                  .sizeOf(context)
                  .height - 0.9,
              fit: BoxFit.fill,
              opacity: AnimationController(vsync: this, value: 0.3),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 40,
                          )),
                      const Text(
                        "Now Playing",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 350,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Obx(()=> Image.network(
                        (controller.l2[controller.index.value].data.image),
                        height: 120,
                        width: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(()=> Text(
                          controller.l2[controller.index.value].song,
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      IconButton.filledTonal(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
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
                              max: controller.totalDuration.inSeconds
                                  .toDouble(),
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
                            height: 30,
                          ),
                          Obx(
                                () =>
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Transform.rotate(
                                        angle: (pi * 2) / 2,
                                        child: IconButton(
                                          onPressed: () async {
                                            controller.assetsAudioPlayer
                                                .pause();
                                            controller.changeButton(false);
                                            await controller.assetsAudioPlayer
                                                .previous();
                                            controller.changeButton(true);
                                            controller.previousOrNext(
                                                controller.index.value - 1);
                                          },
                                          icon: const Icon(Icons.double_arrow),
                                          color: Colors.white,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          if (controller.isPlay.value == true) {
                                            controller.assetsAudioPlayer
                                                .pause();
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
                                        onPressed: () async {
                                          controller.assetsAudioPlayer.pause();
                                          controller.changeButton(false);
                                          await controller.assetsAudioPlayer
                                              .next();
                                          controller.changeButton(true);
                                          controller
                                              .previousOrNext(
                                              controller.index.value + 1);
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
          ],
        )
    );
  }
}

