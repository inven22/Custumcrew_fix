class HouseholdAssistant {
  final int id;
  final String name;
  final String speciality;
  // Add other fields as necessary

  HouseholdAssistant(
      {required this.id, required this.name, required this.speciality});

  factory HouseholdAssistant.fromJson(Map<String, dynamic> json) {
    return HouseholdAssistant(
      id: json['id'],
      name: json['name'],
      speciality: json['speciality'],
      // Initialize other fields
    );
  }
}
