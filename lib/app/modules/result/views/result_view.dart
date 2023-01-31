import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/result_controller.dart';


class ResultView extends GetView<ResultController> {
  const ResultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text("${controller.homeController.data?.name}"),
                Text("${controller.homeController.data?.main?.temp}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
