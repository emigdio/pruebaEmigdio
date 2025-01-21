class Course {
  final String key;
  final String name;
  final String description;
  final String image;


  Course({
    required this.key,
    required this.name,
    required this.description,
    required this.image,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      key: json['key'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }


}