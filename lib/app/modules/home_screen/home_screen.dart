import 'package:cleaning_app/app/modules/home_screen/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Cleaning Service")),
      body: Center(
        child: Obx(() => Text(
          'Welcome, ${controller.username.value}',
          style: const TextStyle(fontSize: 18),
        )),
      ),
    );
  }
}
