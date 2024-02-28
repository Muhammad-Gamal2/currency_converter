import 'package:curreny_converter/home/home.dart';
import 'package:curreny_converter/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConverterPage extends StatelessWidget {
  const ConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConvertCurrencyCubit(),
      child: const ConverterView(),
    );
  }
}

class ConverterView extends StatelessWidget {
  const ConverterView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ConvertCurrencyCubit>().state;
    return BlocListener<CurrencyCubit, CurrencyState>(
      listener: (context, state) {
        if (state.status == RequestStatus.success) {
          final rate = state.currencies
              ?.firstWhere(
                (element) => element.currency == 'USD',
              )
              .rate;
          context.read<ConvertCurrencyCubit>().setRate(
                rate: 1 / (rate ?? 1),
              );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ConverterWidget(state: state),
                const SizedBox(height: 20),
                const Text('Indicative Exchange Rate'),
                Text('1 ${state.fromCurrency} = '
                    '${state.rate.toStringAsFixed(5)} ${state.toCurrency}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
