//i want to validate the user input with pattern name, location and phone with regex

String? validateName(String? name) {
  // String pattern = r'^[a-zA-Z\s]+$';
  // RegExp regex = RegExp(pattern);
  if (name == null || name.isEmpty) {
    return 'Name is required';
    // } else if (!regex.hasMatch(name)) {
    //   return 'Invalid name format';
  }
  return null;
}

String? validateLocation(String? location) {
  // String pattern = r'^[a-zA-Z\s]+$';
  // RegExp regex = RegExp(pattern);
  if (location == null || location.isEmpty) {
    return 'Location is required';
    // } else if (!regex.hasMatch(location)) {
    //   return 'Invalid location format';
  }

  return null;
}

String? validatePhone(String? phone) {
  // String pattern = r'^\d{10}$';
  // RegExp regex = RegExp(pattern);
  if (phone == null || phone.isEmpty) {
    return 'Phone number is required';
    // } else if (!regex.hasMatch(phone)) {
    //   return 'Invalid phone number format';
  }
  return null;
}
