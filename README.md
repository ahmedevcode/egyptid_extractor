EgyptID Extractor
A Dart package for parsing and extracting information from Egyptian National IDs. This package allows you to validate ID numbers, extract personal details like date of birth, age, gender, and governorate of issuance, and provides utilities for privacy masking.

Features
Validation: Checks if the ID is correctly formatted and logically valid.
Date of Birth Extraction: Parses the ID to extract the individual's date of birth.
Gender Determination: Identifies gender based on the ID.
Governorate Identification: Maps governorate codes to their respective names.
Age Calculation: Computes age from the date of birth.
ID Masking: Masks the ID for privacy while keeping the last 4 digits visible.
Detailed Validation Messages: Returns specific error messages for invalid IDs.
Getting Started
Prerequisites
Ensure you have the following installed:

Dart SDK version >=2.12.0 (for null safety support).
Add this package to your pubspec.yaml file:

yaml
Copy code
dependencies:
  egyptid_extractor: ^1.0.0
Then, run:

bash
Copy code
flutter pub get
Usage
Here’s how you can use the package:

dart
Copy code
import 'package:egyptid_extractor/egyptid_extractor.dart';

void main() {
  final parser = EgyptianIDParser('29809230201234');

  // Validate ID
  print(parser.isValid()); // true

  // Extract Date of Birth
  print(parser.getDateOfBirth()); // 1998-09-23 00:00:00.000

  // Get Gender
  print(parser.getGender()); // Male

  // Get Governorate
  print(parser.getGovernorate()); // Gharbia

  // Calculate Age
  print(parser.getAge()); // Based on the current date

  // Mask ID
  print(parser.maskID()); // **********1234

  // Detailed Validation
  print(parser.validate()); // Valid
}
Additional Information
Where to Find More Information
For detailed documentation and usage examples, please refer to the /example folder in this repository.

Contributing
Contributions are welcome! If you'd like to enhance this package, feel free to submit a pull request or file an issue on the GitHub repository.

Reporting Issues
If you encounter any bugs or have feature requests, please open an issue on the GitHub repository. The maintainers will respond promptly.
