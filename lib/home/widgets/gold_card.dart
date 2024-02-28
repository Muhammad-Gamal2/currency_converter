import 'package:flutter/material.dart';

class GoldCard extends StatelessWidget {
  const GoldCard({required this.type, required this.price, super.key});

  final String type;
  final num price;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/gold-ingots.png',
                  width: 50,
                  height: 50,
                ),
                Text(type.toUpperCase()),
              ],
            ),
            const Spacer(),
            Text.rich(
              // New
              TextSpan(
                text: price.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '\nEgyptian Pound',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
