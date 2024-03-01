import 'package:curreny_converter/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConverterWidget extends StatelessWidget {
  const ConverterWidget({
    required this.state,
    super.key,
  });

  final ConvertCurrencyState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          ItemWidget(
            currency: state.fromCurrency,
            isFromCurrency: true,
          ),
          IconButton(
            onPressed: () {
              context.read<ConvertCurrencyCubit>().replaceCurrencies(
                    rate: 1 / state.rate,
                  );
            },
            color: Theme.of(context).colorScheme.tertiary,
            iconSize: 40,
            icon: const Icon(Icons.swap_vert_circle_outlined),
          ),
          const SizedBox(height: 16),
          ItemWidget(
            currency: state.toCurrency,
            isFromCurrency: false,
            convertedAmount: state.convertedAmount,
          ),
        ],
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    required this.currency,
    required this.isFromCurrency,
    this.convertedAmount = 0,
    super.key,
  });

  final String currency;
  final bool isFromCurrency;
  final num convertedAmount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/$currency.png'),
        ),
        const SizedBox(width: 16),
        Text(currency),
        const SizedBox(width: 16),
        Flexible(
          child: TextField(
            key: isFromCurrency
                ? const Key('from_currency_text_field')
                : const Key('to_currency_text_field'),
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              enabled: isFromCurrency,
              labelText: isFromCurrency ? 'Enter amount' : 'Conversion',
              labelStyle: !isFromCurrency
                  ? const TextStyle(
                      color: Colors.black,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              context.read<ConvertCurrencyCubit>().convertCurrency(
                    double.tryParse(value) ?? 0,
                  );
            },
            controller: !isFromCurrency
                ? TextEditingController(
                    text: convertedAmount.toStringAsFixed(2),
                  )
                : null,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d+\.?\d{0,2}'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
