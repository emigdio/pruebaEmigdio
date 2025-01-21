class Characteristic {
  final String name;
  final String icon;
  final String description;
  final bool isActive;

  Characteristic({
    required this.name,
    required this.icon,
    required this.description,
    required this.isActive,
  });

  factory Characteristic.fromJson(Map<String, dynamic> json) {
    return Characteristic(
      name: json['nanme'],
      icon: json['icon'],
      description: json['description'],
      isActive: json['isActive'],
    );
  }
}