import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateNotifierProvider.family<Counter, int, int>(
  (ref, id) => Counter(),
);

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
  void decrement() {
    if (state > 0) state--;
  }

  void reset() => state = 0;
}
