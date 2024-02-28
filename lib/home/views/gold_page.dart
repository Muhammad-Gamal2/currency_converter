import 'package:curreny_converter/home/home.dart';
import 'package:curreny_converter/shared/shared.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoldPage extends StatelessWidget {
  const GoldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GoldCubit>(
      create: (context) => GoldCubit(
        dataRepository: RepositoryProvider.of<DataRepository>(context),
      )..getGoldPrices(),
      child: const GoldView(),
    );
  }
}

class GoldView extends StatelessWidget {
  const GoldView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<GoldCubit>().getGoldPrices();
        },
        child: SafeArea(
          child: BlocConsumer<GoldCubit, GoldState>(
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
              final goldData = state.goldPrices ?? const Gold();
              if (state.status == RequestStatus.inProgress) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: goldData.goldPrices.length,
                itemBuilder: (context, index) {
                  final type = goldData.goldPrices[index].keys.first;
                  final price = goldData.goldPrices[index][type] ?? 0;
                  return GoldCard(type: type, price: price);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
