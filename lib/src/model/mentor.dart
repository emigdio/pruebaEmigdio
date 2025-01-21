class Mentor {
  final String key;
  final String name;
  final String email;
  final String avatar;
  final String role;
  final int numberOfMentoring;
  final String biografy;


  Mentor({
    required this.key,
    required this.name,
    required this.email,
    required this.avatar,
    required this.role,
    required this.numberOfMentoring,
    required this.biografy,
  });

  factory Mentor.fromJson(Map<String, dynamic> json) {
    return Mentor(
      key: json['key'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      role: json['role'],
      numberOfMentoring: json['numberOfMentoring'],
      biografy: json['biography'],
    );
  }
}