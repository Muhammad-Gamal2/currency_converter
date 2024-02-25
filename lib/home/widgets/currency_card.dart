import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({required this.currency, super.key});

  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/${currency.currency}.png'),
                ),
                const SizedBox(height: 50),
                Text.rich( // New
                  TextSpan(
                    text: currency.rate.toStringAsFixed(2),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text('1 ${currency.currency}'),
          ],
        ),
      ),
    );
  }
}
