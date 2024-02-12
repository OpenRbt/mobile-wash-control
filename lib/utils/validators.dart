String? textValidator(val) {
  if ((val ?? "").trim().isEmpty) {
    return "Поле не может быть пустым";
  }
  return null;
}

String? percentageValidator(val) {
  if ((val ?? "").trim().isEmpty || int.parse(val ?? "0") > 100 || int.parse(val ?? "0") < 0) {
    return "Поле не может быть пустым, отрицательным или превышать 100%";
  }
  return null;
}

String? emptyPercentageValidator(String? val) {
  var checkedValue = (val ?? '').isEmpty ? null: val;
  if((checkedValue ?? '').isEmpty || (int.parse(checkedValue ?? '0') <= 100 && int.parse(checkedValue ?? '0') >= 0) ) {
    return null;
  }
  return "Поле не может быть отрицательным или превышать 100%";
}

String? positiveNumberValidator(val) {
  if ((val ?? "").trim().isEmpty || int.parse(val ?? "0") < 0) {
    return "Поле не может быть пустым или меньше нуля";
  }
  return null;
}

String? emptyPositiveNumberValidator(val) {
  print("emptyPositiveNumberValidator");
  if (int.parse(val ?? "0") < 0) {
    return "Поле не может быть меньше нуля";
  }
  return null;
}