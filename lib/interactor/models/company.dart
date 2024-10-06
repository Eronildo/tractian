class Company {
  final String id;
  final String name;

  Company({required this.id, required this.name});

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
