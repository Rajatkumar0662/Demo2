import 'dart:math';

import 'package:hive/hive.dart';

class CounterRepository {
  final Random random = Random();
  late final hiveBox = Hive.box('Counter');

  getRandomNumber() {
    int randomNumber = random.nextInt(59);
    return randomNumber;
  }

  getCounter() async {
    final value = await hiveBox.get('success');
    return value;
  }

  setCounter() async {
    dynamic value = await hiveBox.get('success');
    await hiveBox.put('success', ((value ?? 0) + 1));
    return (value ?? 0) + 1;
  }

  resetCounter() async {
    await hiveBox.put('success', 0);
    return 0;
  }
}
