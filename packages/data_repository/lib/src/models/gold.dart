// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'gold.freezed.dart';

@freezed
class Gold with _$Gold {
  const factory Gold({
    num? goldPrice24k,
    num? goldPrice22k,
    num? goldPrice21k,
    num? goldPrice18k,
    num? goldPrice14k,
    num? goldPrice10k,
  }) = _Gold;

  const Gold._();

  List<Map<String, num?>> get goldPrices => [
        {'24k': goldPrice24k},
        {'22k': goldPrice22k},
        {'21k': goldPrice21k},
        {'18k': goldPrice18k},
        {'14k': goldPrice14k},
        {'10k': goldPrice10k},
      ];
}
