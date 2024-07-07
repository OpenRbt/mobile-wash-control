import 'package:easy_localization/easy_localization.dart';

String? textValidator(val) {
  if ((val ?? "").trim().isEmpty) {
    return 'field_must_not_be_empty'.tr();
  }
  return null;
}

String? percentageValidator(val) {
  if ((val ?? "").trim().isEmpty || int.parse(val ?? "0") > 100 || int.parse(val ?? "0") < 0) {
    return "${'field_must_not_be_empty'.tr()}, ${'negative'.tr()} ${'or'.tr()} ${'greater_than'.tr()} 100%";
  }
  return null;
}

String? emptyPercentageValidator(String? val) {
  var checkedValue = (val ?? '').isEmpty ? null: val;
  if((checkedValue ?? '').isEmpty || (int.parse(checkedValue ?? '0') <= 100 && int.parse(checkedValue ?? '0') >= 0) ) {
    return null;
  }
  return "${'field_must_not_be'.tr()} ${'negative'.tr()} ${'or'.tr()} ${'greater_than'.tr()} 100%";
}

String? positiveNumberValidator(val) {
  if ((val ?? "").trim().isEmpty || int.parse(val ?? "0") < 0) {
    return "${'field_must_not_be_empty'.tr()} ${'or'.tr()} ${'less_than_zero'.tr()}";
  }
  return null;
}

String? emptyPositiveNumberValidator(val) {
  print("emptyPositiveNumberValidator");
  if (int.parse(val ?? "0") < 0) {
    return "${'field_must_not_be'.tr()} ${'less_than_zero'.tr()}";
  }
  return null;
}