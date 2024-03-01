import 'package:bloc_test/bloc_test.dart';
import 'package:curreny_converter/home/home.dart';
import 'package:curreny_converter/shared/shared.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGoldCubit extends MockCubit<GoldState> implements GoldCubit {}

class MockDataRepository extends Mock implements DataRepository {}

void main() {
  late MockGoldCubit mockCubit;
  late DataRepository dataRepository;

  setUp(() {
    mockCubit = MockGoldCubit();
    dataRepository = MockDataRepository();
  });

  testWidgets('GoldPage Widget Test', (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(
      const GoldState(
        status: RequestStatus.success,
        goldPrices: Gold(
          goldPrice22k: 100,
          goldPrice24k: 200,
        ),
      ),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: RepositoryProvider(
          create: (context) => dataRepository,
          child: const GoldPage(),
        ),
      ),
    );

    // Verify that the GoldPage is displayed.
    expect(find.byType(GoldPage), findsOneWidget);
  });

  testWidgets('shows SnackBar when status is failure',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(const GoldState());
    whenListen(
      mockCubit,
      Stream<GoldState>.fromIterable([
        const GoldState(),
        const GoldState(
          status: RequestStatus.failure,
        ),
      ]),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<GoldCubit>.value(
          value: mockCubit,
          child: const GoldView(),
        ),
      ),
    );

    await tester.pump(); // Pumping a frame to show the SnackBar
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('onRefresh', (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(const GoldState());
    when(() => mockCubit.getGoldPrices()).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<GoldCubit>.value(
          value: mockCubit,
          child: const GoldView(),
        ),
      ),
    );

    await tester.drag(find.byType(RefreshIndicator), const Offset(0, 300));
    await tester.pumpAndSettle();

    verify(() => mockCubit.getGoldPrices()).called(1);
  });
}
