import 'package:freezed_annotation/freezed_annotation.dart';

//Name der subject Datei
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class AppUser with _$User {
  const factory AppUser({
    required String email,
    required String username,
  }) = _User;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}
