import 'package:freezed_annotation/freezed_annotation.dart';

//Name der subject Datei
part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({required String email, required String username}) =
      _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
