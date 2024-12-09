library egyptid_extractor;

/// EgyptianIDParser allows extracting information from an Egyptian National ID.
class EgyptianIDParser {
  /// The Egyptian ID number to parse.
  final String id;

  /// A map of governorate codes to names.
  static const Map<String, String> _governorates = {
    '01': 'Cairo',
    '02': 'Alexandria',
    '03': 'Port Said',
    '04': 'Suez',
    '05': 'Dakahlia',
    '06': 'Sharqia',
    '07': 'Kafr El Sheikh',
    '08': 'Gharbia',
    '09': 'Menoufia',
    '10': 'Beni Suef',
    '11': 'Fayoum',
    '12': 'Minya',
    '13': 'Assiut',
    '14': 'Sohag',
    '15': 'Qena',
    '16': 'Luxor',
    '17': 'Aswan',
    '18': 'Red Sea',
    '19': 'Matrouh',
    '20': 'North Sinai',
    '21': 'South Sinai',
    '22': 'New Valley',
    '23': 'Port Said',
    '24': 'Damietta',
    '25': 'Ismailia',
    '26': 'Giza',
    '27': '6th of October City',
    '28': 'Cairo 3rd District',
    '29': 'Outside Egypt',
    '88': 'Outside Egypt',
  };

  EgyptianIDParser(this.id);

  /// Validates if the ID is properly formatted and logical.
  bool isValid() {
    if (id.length != 14 || !RegExp(r'^\d+$').hasMatch(id)) return false;
    try {
      final dob = getDateOfBirth();
      return dob != null;
    } catch (_) {
      return false;
    }
  }

  /// Extracts the date of birth from the ID.
  /// Returns null if the ID is invalid or the date is not parsable.
  DateTime? getDateOfBirth() {
    if (!isValid()) return null;

    final year = int.parse(id.substring(1, 3));
    final month = int.parse(id.substring(3, 5));
    final day = int.parse(id.substring(5, 7));
    final century = int.parse(id[0]) + 18;

    try {
      return DateTime(century * 100 + year, month, day);
    } catch (_) {
      return null;
    }
  }

  /// Determines the gender based on the ID.
  /// Returns 'Male' for odd numbers and 'Female' for even numbers.
  String? getGender() {
    if (!isValid()) return null;
    return int.parse(id[12]) % 2 == 0 ? 'Female' : 'Male';
  }

  /// Extracts the governorate based on the ID.
  /// Returns 'Unknown' if the governorate code is invalid.
  String? getGovernorate() {
    if (!isValid()) return null;
    final code = id.substring(7, 9);
    return _governorates[code] ?? 'Unknown';
  }

  /// Calculates the age based on the date of birth.
  /// Returns null if the ID is invalid or the date of birth is not parsable.
  int? getAge() {
    final dob = getDateOfBirth();
    if (dob == null) return null;

    final today = DateTime.now();
    int age = today.year - dob.year;

    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  /// Validates the ID and returns detailed error messages.
  /// Returns 'Valid' if the ID is correct.
  String validate() {
    if (id.length != 14) return 'ID must be 14 digits long';
    if (!RegExp(r'^\d+$').hasMatch(id)) return 'ID must contain only digits';
    if (getDateOfBirth() == null) return 'Invalid date of birth in ID';
    if (getGovernorate() == 'Unknown') return 'Invalid governorate code';
    return 'Valid';
  }

  /// Masks the ID for privacy, showing only the last 4 digits.
  /// Example: ************7891
  String maskID({String maskChar = '*'}) {
    if (!isValid()) return 'Invalid ID';
    return '${maskChar * 10}${id.substring(10)}';
  }

  /// Extracts all available details from the ID in a structured format.
  /// Returns null if the ID is invalid.
  Map<String, dynamic>? getDetails() {
    if (!isValid()) return null;
    return {
      'id': id,
      'dateOfBirth': getDateOfBirth(),
      'age': getAge(),
      'gender': getGender(),
      'governorate': getGovernorate(),
    };
  }

  /// Compares two IDs and highlights differences in their details.
  static Map<String, dynamic> compareIDs(String id1, String id2) {
    final parser1 = EgyptianIDParser(id1);
    final parser2 = EgyptianIDParser(id2);

    return {
      'id1': parser1.getDetails(),
      'id2': parser2.getDetails(),
      'differences': {
        'gender': parser1.getGender() != parser2.getGender(),
        'age': parser1.getAge() != parser2.getAge(),
        'governorate': parser1.getGovernorate() != parser2.getGovernorate(),
      },
    };
  }
}
