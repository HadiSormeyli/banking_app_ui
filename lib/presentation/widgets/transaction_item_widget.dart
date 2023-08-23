import 'package:banking_app_ui/config/config.dart';
import 'package:banking_app_ui/model/transaction.dart';
import 'package:flutter/material.dart';

class TransactionItemWidget extends StatelessWidget {
  final Transaction transaction;

  const TransactionItemWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: mediumDistance, bottom: mediumDistance),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(largeRadius),
            child: Container(
              alignment: Alignment.center,
              color: primaryColor,
              height: 48,
              width: 48,
              child: Icon(
                transaction.icon,
                color: darkBackgroundColor,
              ),
            ),
          ),
          const SizedBox(
            width: mediumDistance,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: smallDistance,
              ),
              Text(
                transaction.category,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Text(
            '${transaction.pln} PLN',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
