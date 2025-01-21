import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_emigdio/src/model/course.dart';
import 'package:prueba_emigdio/src/model/mentoring.dart';

class ApiService {
  final String baseUrl = 'https://load-qv4lgu7kga-uc.a.run.app';
  final String baseImageUrl = 'https://load-qv4lgu7kga-uc.a.run.app/images/';

  Future<List<Mentoring>> getMentorings() async {
    final response = await http.get(Uri.parse('$baseUrl/mentorings/all'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return (jsonData['data']['mentorings'] as List<dynamic>)
          .map((e) => Mentoring.fromJson(e))
          .toList(); 
    } else {
      throw Exception('Error al cargar mentorías');
    }
  }

  Future<List<Course>> getCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/Courses/all'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return (jsonData['data']['items'] as List<dynamic>)
          .map((e) => Course.fromJson(e))
          .toList(); 
    } else {
      throw Exception('Error al cargar cursos');
    }
  }

  getPathImage(String imageName) {
    return '$baseImageUrl$imageName';
  }
}

