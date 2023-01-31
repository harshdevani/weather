import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              controller: controller.city,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search City",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  controller.getWeatherDataByLatLong();
                },
                child: const Text("Search"))
          ]),
        ),
      ),
    );
  }
}
