import 'package:curreny_converter/home/home.dart';
import 'package:curreny_converter/shared/shared.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyPage extends StatelessWidget {
  const CurrencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrencyCubit>(
      create: (context) => CurrencyCubit(
        dataRepository: RepositoryProvider.of<DataRepository>(context),
      )..getCurrencies(),
      child: const CurrencyView(),
    );
  }
}

class CurrencyView extends StatelessWidget {
  const CurrencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<CurrencyCubit, CurrencyState>(
          listener: (context, state) {
            if (state.status == RequestStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.exception?.message ?? 'Error'),
                  ),
                );
            }
          },
          builder: (context, state) {
            final currencies = state.currencies ?? [];
            if (state.status == RequestStatus.inProgress) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state.status == RequestStatus.success && currencies.isEmpty) {
              return const Center(
                child: Text('No currencies found'),
              );
            }
            return ListView.separated(
              itemCount: currencies.length,
              padding: const EdgeInsets.all(24),
              itemBuilder: (context, index) {
                return CurrencyCard(currency: currencies[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 24);
              },
            );
          },
        ),
      ),
    );
  }
}
