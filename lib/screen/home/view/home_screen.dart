import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/main.dart'; // Ensure this import contains your controller
import 'package:overlapped_carousel/overlapped_carousel.dart';
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
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/image/user.png"),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Evening,",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "Benji.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 78,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const TabBar(tabs: [
                Tab(
                  text: "Music Room",
                ),
                Tab(
                  text: "Favourite Artist",
                ),
                Tab(
                  text: "Podcast and",
                ),
              ]),
              const SizedBox(
                height: 20,
              ),
              CarouselSlider(
                items: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/image/weather1.png",
                        height: 400,
                        width: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset("assets/image/weather2.png",
                          height: 400, width: 400, fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset("assets/image/weather3.png",
                          height: 400, width: 400, fit: BoxFit.cover),
                    ),
                  )
                ],
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  initialPage: 0,
                  viewportFraction: 0.8,
                ),
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: controller.l2.length,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Get.toNamed('detail',
                                arguments: controller.l2[index]);
                            controller.changeIndex(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                                width: 200,
                                height: 200,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                        controller.l2[index].data.image))),
                          ),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
