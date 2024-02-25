import 'package:bloc_test/bloc_test.dart';
import 'package:curreny_converter/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TabBarCubit tabBarCubit;

  setUp(() {
    tabBarCubit = TabBarCubit();
  });

  tearDown(() {
    tabBarCubit.close();
  });

  group('TabBarCubit', () {
    test('initial state is 0', () {
      expect(tabBarCubit.state, 0);
    });

    blocTest<TabBarCubit, int>(
      'emits [1] when changeIndex is called with 1',
      build: () => tabBarCubit,
      act: (cubit) => cubit.changeIndex(1),
      expect: () => [1],
    );
  });
}
