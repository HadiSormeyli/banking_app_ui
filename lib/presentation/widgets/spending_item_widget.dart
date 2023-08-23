import 'dart:ffi';

import 'package:banking_app_ui/model/spending.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../config/config.dart';

class SpendingItemWidget extends StatefulWidget {
  final Spending spending;

  const SpendingItemWidget({super.key, required this.spending});

  @override
  State<SpendingItemWidget> createState() => _SpendingItemWidgetState();
}

class _SpendingItemWidgetState extends State<SpendingItemWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        upperBound: widget.spending.progress);

    super.initState();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: mediumDistance, bottom: mediumDistance),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.spending.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${widget.spending.amount} PLN",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget? child) {
                return CircularPercentIndicator(
                  radius: 32.0,
                  lineWidth: 3.0,
                  percent: _animationController.value,
                  center: Text("${double.tryParse(_animationController.value.toStringAsFixed(2))! * 100}%"),
                  progressColor: widget.spending.color,
                );
              }),
          const SizedBox(
            width: smallDistance,
          ),
          const Icon(Icons.navigate_next),
        ]));
  }
}
