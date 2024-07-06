class HouseholdAssistant {
  final int id;
  final String name;
  final String speciality;
  // Add other fields as necessary

  HouseholdAssistant(
      {required this.id,
      required this.name,
      required this.speciality,
      required order,
      required email,
      required biography});

  factory HouseholdAssistant.fromJson(Map<String, dynamic> json) {
    return HouseholdAssistant(
        id: json['id'],
        name: json['name'],
        speciality: json['speciality'],
        order: json['order'],
        email: json['email'],
        biography: json['biography']);
  }

  get order => null;

  get email => null;

  get biography => null;
}
