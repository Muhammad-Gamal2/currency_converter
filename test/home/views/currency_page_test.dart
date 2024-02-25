import 'package:bloc_test/bloc_test.dart';
import 'package:curreny_converter/home/home.dart';
import 'package:curreny_converter/shared/shared.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyCubit extends MockCubit<CurrencyState>
    implements CurrencyCubit {}

class MockDataRepository extends Mock implements DataRepository {}

void main() {
  group('CurrencyPage and CurrencyView Widget Test', () {
    late CurrencyCubit currencyCubit;
    late DataRepository dataRepository;

    setUp(() {
      currencyCubit = MockCurrencyCubit();
      dataRepository = MockDataRepository();
    });

    testWidgets('CurrencyPage Widget Test', (WidgetTester tester) async {
      when(() => currencyCubit.state).thenReturn(const CurrencyState());
      await tester.pumpWidget(
        RepositoryProvider(
          create: (context) => dataRepository,
          child: const MaterialApp(
            home: CurrencyPage(),
          ),
        ),
      );

      expect(find.byType(CurrencyPage), findsOneWidget);
    });

    testWidgets('CurrencyView Widget Test', (WidgetTester tester) async {
      when(() => currencyCubit.state).thenReturn(const CurrencyState());
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CurrencyCubit>.value(
            value: currencyCubit,
            child: const CurrencyView(),
          ),
        ),
      );

      expect(find.byType(CurrencyView), findsOneWidget);
    });

    testWidgets('shows CircularProgressIndicator when status is inProgress',
        (WidgetTester tester) async {
      when(() => currencyCubit.state)
          .thenReturn(const CurrencyState(status: RequestStatus.inProgress));
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CurrencyCubit>.value(
            value: currencyCubit,
            child: const CurrencyView(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows SnackBar when status is failure',
        (WidgetTester tester) async {
      when(() => currencyCubit.state).thenReturn(const CurrencyState());
      whenListen(
        currencyCubit,
        Stream<CurrencyState>.fromIterable([
          const CurrencyState(),
          const CurrencyState(
            status: RequestStatus.failure,
          ),
        ]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CurrencyCubit>.value(
            value: currencyCubit,
            child: const CurrencyView(),
          ),
        ),
      );

      await tester.pump(); // Pumping a frame to show the SnackBar
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets(
        'shows CurrencyCard when status is success and there are currencies',
        (WidgetTester tester) async {
      when(() => currencyCubit.state).thenReturn(
        const CurrencyState(
          status: RequestStatus.success,
          currencies: [
            Currency(base: 'EGP', currency: 'USD', rate: 15.5),
            Currency(base: 'EGP', currency: 'EUR', rate: 18.5)
          ],
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CurrencyCubit>.value(
            value: currencyCubit,
            child: const CurrencyView(),
          ),
        ),
      );

      expect(find.byType(CurrencyCard), findsNWidgets(2));
    });

    testWidgets(
        'shows "No currencies found" when status is success '
        'and there are no currencies', (WidgetTester tester) async {
      when(() => currencyCubit.state).thenReturn(
        const CurrencyState(status: RequestStatus.success, currencies: []),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CurrencyCubit>.value(
            value: currencyCubit,
            child: const CurrencyView(),
          ),
        ),
      );

      expect(find.text('No currencies found'), findsOneWidget);
    });
  });
}
