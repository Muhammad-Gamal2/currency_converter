// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'gold.freezed.dart';
part 'gold.g.dart';

@freezed
class Gold with _$Gold {
  const factory Gold({
    @JsonKey(name: 'price_gram_24k') num? goldPrice24k,
    @JsonKey(name: 'price_gram_22k') num? goldPrice22k,
    @JsonKey(name: 'price_gram_21k') num? goldPrice21k,
    @JsonKey(name: 'price_gram_18k') num? goldPrice18k,
    @JsonKey(name: 'price_gram_14k') num? goldPrice14k,
    @JsonKey(name: 'price_gram_10k') num? goldPrice10k,
  }) = _Gold;

  factory Gold.fromJson(Map<String, dynamic> json) =>
      _$GoldFromJson(json);
}
