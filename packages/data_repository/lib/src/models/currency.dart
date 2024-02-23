// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency.freezed.dart';

@freezed
class Currency with _$Currency {
  const factory Currency({
    required String base,
    required String currency,
    required num rate,
  }) = _Currency;
}
