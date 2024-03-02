import 'package:cart_app/widgets/counter/counter_widget.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterWidget extends ConsumerStatefulWidget {
  final Function(int) onIncrement;
  final Function(int) onDecrement;
  final int productId;

  const CounterWidget({
    super.key,
    required this.productId,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends ConsumerState<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    final count = ref.watch(counterProvider(widget.productId));
    return Visibility(
      visible: count == 0,
      replacement: Container(
        height: 32,
        width: 83,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                ref
                    .read(counterProvider(widget.productId).notifier)
                    .decrement();
                widget.onDecrement(ref.read(counterProvider(widget.productId)));
              },
              child: const Icon(
                Icons.remove,
                size: 20,
              ),
            ),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w800,
                color: Colors.pink.shade300,
              ),
            ),
            GestureDetector(
              onTap: () {
                ref
                    .read(counterProvider(widget.productId).notifier)
                    .increment();
                widget.onIncrement(ref.read(counterProvider(widget.productId)));
              },
              child: const Icon(
                Icons.add,
                size: 20,
              ),
            ),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          ref.read(counterProvider(widget.productId).notifier).increment();
          widget.onIncrement(ref.read(counterProvider(widget.productId)));
        },
        child: Container(
          width: 83,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade100,
          ),
          child: Center(
            child: Text(
              'Add',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w800,
                color: Colors.pink.shade500,
              ),
            ),
          ),
        ),
      ),

      //resolved jumping issue while switching between btn and counter
      // ElevatedButton(
      //   onPressed: () {
      //     ref.read(counterProvider(widget.productId).notifier).increment();
      //   },
      //   style: ElevatedButton.styleFrom(
      //     minimumSize: const Size(83, 32),
      //     elevation: 0,
      //     backgroundColor: Colors.grey.shade200,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(8),
      //       side: BorderSide(
      //         color: Colors.grey.shade300,
      //       ),
      //     ),
      //   ),
      //   child: const Text(
      //     'Add',
      //     style: TextStyle(
      //       fontSize: 12,
      //       letterSpacing: 0.7,
      //       fontWeight: FontWeight.w500,
      //       // color: Colors.grey.shade500,
      //     ),
      //   ),
      // ),
    );
  }
}
