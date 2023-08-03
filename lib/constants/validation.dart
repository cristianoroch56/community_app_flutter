String? textvalidator(String? value) {
  if (value == null || value.isEmpty) {
    return "This field can't be empty";
  }

  RegExp regex = RegExp(r"^[A-Za-z\s]+$");
  if (!regex.hasMatch(value)) {
    return "Invalid format";
  }
  return null;
}

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "First name is required";
  }

  if (value.length > 50) {
    return "First name should be less then 50 characters";
  }

  RegExp regex = RegExp(r"^[A-Za-z\s]+$");
  if (!regex.hasMatch(value)) {
    return "Invalid format";
  }

  return null;
}

String? passwordValidator(String? value) {
  final RegExp passwordRegex = RegExp(
      r"^[a-zA-z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-z0-9]+\.[a-zA-Z0-9]+");

  if (value == null || value.isEmpty) {
    return "Password is required.";
  }
  if (value.length < 8 || value.length > 15) {
    return "Password length must be between 8 and 15 characters.";
  }
  if (!passwordRegex.hasMatch(value)) {}
  return null;
}

String? isValidDateOfBirth(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please select your birthdate';
  }

  DateTime selectedDate;
  try {
    selectedDate = DateTime.parse(value);
  } catch (error) {
    return 'Invalid date format';
  }

  DateTime currentDate = DateTime.now();
  if (selectedDate.isAfter(currentDate)) {
    return 'Invalid date';
  }
  return null;
}

String? educationvalidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your education';
  }

  return null;
}

String? relationvalidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your relationship';
  }
  return null;
}

String? locationvalidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a location';
  }

  int minLength = 3;

  if (value.length < minLength) {
    return 'Location must have at least $minLength characters';
  }

  return null;
}
