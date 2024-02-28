import 'package:bloc_test/bloc_test.dart';
import 'package:curreny_converter/home/home.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTabBarCubit extends MockCubit<int> implements TabBarCubit {}

class MockDataRepository extends Mock implements DataRepository {}

void main() {
  group('TabBarPage Widget Test', () {
    late TabBarCubit tabBarCubit;
    late DataRepository dataRepository;

    setUp(() {
      tabBarCubit = MockTabBarCubit();
      dataRepository = MockDataRepository();
    });

    testWidgets('TabBarPage Widget Test', (WidgetTester tester) async {
      when(() => tabBarCubit.state).thenReturn(0);
      await tester.pumpWidget(
        RepositoryProvider(
          create: (context) => dataRepository,
          child: MaterialApp(
            home: BlocProvider<TabBarCubit>.value(
              value: tabBarCubit,
              child: const TabBarPage(),
            ),
          ),
        ),
      );

      expect(find.byType(TabBarPage), findsOneWidget);
    });

    testWidgets('BottomNavigationBar changes index when tapped',
        (WidgetTester tester) async {
      when(() => tabBarCubit.state).thenReturn(0);

      await tester.pumpWidget(
        RepositoryProvider(
          create: (context) => dataRepository,
          child: MaterialApp(
            home: BlocProvider<TabBarCubit>.value(
              value: tabBarCubit,
              child: const TabBarPage(),
            ),
          ),
        ),
      );

      // Change the index to 1 (Gold)
      when(() => tabBarCubit.state).thenReturn(1);

      // Tap on the second BottomNavigationBarItem
      await tester.tap(find.textContaining('Gold'));
      await tester.pumpAndSettle();

      // Now, the GoldPage should be displayed
      expect(find.byType(GoldPage), findsOneWidget);
    });

    testWidgets('third page is displayed when index is changed to 2',
            (WidgetTester tester) async {
          when(() => tabBarCubit.state).thenReturn(0);

          await tester.pumpWidget(
            RepositoryProvider(
              create: (context) => dataRepository,
              child: MaterialApp(
                home: BlocProvider<TabBarCubit>.value(
                  value: tabBarCubit,
                  child: const TabBarPage(),
                ),
              ),
            ),
          );

          // Change the index to 1 (Converter)
          when(() => tabBarCubit.state).thenReturn(2);

          // Tap on the second BottomNavigationBarItem
          await tester.tap(find.textContaining('Converter'));
          await tester.pumpAndSettle();

          // Now, the GoldPage should be displayed
          expect(find.byType(ConverterPage), findsOneWidget);
        });
  });
}
