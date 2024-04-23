import 'package:atv/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

enum UserInfoEditType {
  avatar('avatar'),
  lastName('lastName'),
  firstName('firstName'),
  address('address'),
  mobilePhone('mobilePhone'),
  unknown('');

  const UserInfoEditType(this.typeName);

  final String typeName;

  String get displayName {
    switch (this) {
      case UserInfoEditType.avatar:
        return LocaleKeys.edit_avatar.tr();
      case UserInfoEditType.lastName:
        return LocaleKeys.edit_last_name.tr();
      case UserInfoEditType.firstName:
        return LocaleKeys.edit_first_name.tr();
      case UserInfoEditType.address:
        return LocaleKeys.edit_address.tr();
      case UserInfoEditType.mobilePhone:
        return LocaleKeys.edit_mobilephone.tr();
      case UserInfoEditType.unknown:
        return '';
    }
  }

  static UserInfoEditType getTypeByName(String name) =>
      UserInfoEditType.values.firstWhere(
        (value) => value.typeName == name,
        orElse: () => UserInfoEditType.unknown,
      );
}

// enum ActivityType {
//   running(1, 'Running'),

//   climbing(2, 'Climbing'),

//   hiking(5, 'Hiking'),

//   cycling(7, 'Cycling'),

//   ski(10, 'Skiing');

//   const ActivityType(this.number, this.value);

//   final int number;

//   final String value;
  // static ActivityType getTypeByTitle(String title) =>
  //     ActivityType.values.firstWhere((activity) => activity.name == title);
  // static ActivityType getType(int number) =>
  //     ActivityType.values.firstWhere((activity) => activity.number == number);

//   static String getValue(int number) => ActivityType.values
//       .firstWhere((activity) => activity.number == number)
//       .value;
// }
