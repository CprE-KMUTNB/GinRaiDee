import 'package:ginraid/Screens/Cooking/EditFoodScreen.dart';

class Food {
  final String name;
  final String imagePath;
  final String cookMethod;
  final String Ingred;
  final String privacy;

  const Food({
    required this.name,
    required this.imagePath,
    required this.cookMethod,
    required this.Ingred,
    required this.privacy,
  });
}

class FoodEdit {
  static const myFood = Food(
    name: 'Sarah Abs',
    //ใช้เป็นลิ้งเว็บไซต์ได้
    imagePath:
        'https://i.postimg.cc/wBhpfPLz/krapow.png',
    cookMethod: 'sarah.abs@gmail.com',
    Ingred: '1.ผัด 2.ทอด',
    privacy: 'ส่วนตัว',
  );
}
