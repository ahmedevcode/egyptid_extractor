import 'package:egyptid_extractor/EgyptianIDParser.dart';
import 'package:test/test.dart';

void main() {
  final parser = EgyptianIDParser('29801234567891');

  print('Valid: ${parser.isValid()}');
  print('Gender: ${parser.getGender()}');
  print('Date of Birth: ${parser.getDateOfBirth()}');
  print('Governorate: ${parser.getGovernorate()}');
  print('Age: ${parser.getAge()}');
  print('Validation: ${parser.validate()}');
  print('Masked ID: ${parser.maskID()}');

  // Analyze multiple IDs
  final comparison = EgyptianIDParser.compareIDs(
    '29801234567891',
    '19801234567892',
  );
  print('Analysis: $comparison');
}
