import 'package:cleaning_app/app/utils/app_export.dart';

class FavouritesScreenController extends GetxController {
  final List<Map<String, dynamic>> generalCleaning = [
    {'name': 'Home Cleaning', 'image': "lib/assets/images/home_cleaning.jpg"},
    {'name': 'Furniture Cleaning', 'image': "lib/assets/images/furniture_cleaning.png"},
    {'name': 'Home Deep Cleaning', 'image': "lib/assets/images/home_deep_cleaning.webp"},
    {'name': 'Kitchen & Bathroom Deep Cleaning', 'image': "lib/assets/images/kitchen_bathroom_cleaning.webp"},
    {'name': 'Laundry & Deep Cleaning', 'image': "lib/assets/images/laundry_drycleaning.png"},
    {'name': 'AC Cleaning', 'image': "lib/assets/images/ac_cleaning.webp"},
    {'name': 'Car Wash', 'image': "lib/assets/images/car_wash.webp"},
  ];
}