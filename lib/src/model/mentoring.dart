class Mentoring {

  final String description;
  final String image;
  final String name;
  final String detail;

  Mentoring({
 
    required this.name,
    required this.description,
    required this.image,
    required this.detail,

  });

  factory Mentoring.fromJson(Map<String, dynamic> json) {
    return Mentoring(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      detail: json['detail'],
    );
  }
}