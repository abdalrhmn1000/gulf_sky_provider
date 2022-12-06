enum Gender {
  male,
  female,
}

extension ParseToString on Gender {
  String toShortString() {
    return toString().split('.').last;
  }
}

String fromGenderTypeToString(Gender type) {
  switch (type) {
    case Gender.male:
      return 'male';
    case Gender.female:
    default:
      return 'female';
  }
}

extension GetGenderFromString on Gender {
  Gender fromStringToGenderType(String prefix) {
    switch (prefix.toLowerCase()) {
      case 'male':
        return Gender.male;
      case 'female':
      default:
        return Gender.female;
    }
  }
}
