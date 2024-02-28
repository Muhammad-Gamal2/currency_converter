import 'package:curreny_converter/home/home.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrencyCubit(
            dataRepository: RepositoryProvider.of<DataRepository>(context),
          )..getCurrencies(),
        ),
        BlocProvider(
          create: (context) => TabBarCubit(),
        ),
      ],
      child: const TabBarView(),
    );
  }
}

class TabBarView extends StatelessWidget {
  const TabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TabBarCubit>().state;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          context.read<TabBarCubit>().changeIndex(index);
        },
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        currentIndex: state,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/dollar-symbol.svg',
              width: 24,
              height: 24,
              colorFilter: state == 0
                  ? ColorFilter.mode(
                      Theme.of(context).primaryColor,
                      BlendMode.srcIn,
                    )
                  : null,
            ),
            label: 'Currencies',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/gold.svg',
              width: 24,
              height: 24,
              colorFilter: state == 1
                  ? ColorFilter.mode(
                      Theme.of(context).primaryColor,
                      BlendMode.srcIn,
                    )
                  : null,
            ),
            label: 'Gold',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/exchange.svg',
              width: 24,
              height: 24,
              colorFilter: state == 2
                  ? ColorFilter.mode(
                      Theme.of(context).primaryColor,
                      BlendMode.srcIn,
                    )
                  : null,
            ),
            label: 'Converter',
          ),
        ],
      ),
      body: IndexedStack(
        index: state,
        children: const <Widget>[
          CurrencyPage(),
          GoldPage(),
          ConverterPage(),
        ],
      ),
    );
  }
}
