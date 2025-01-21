import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:prueba_emigdio/src/model/course.dart';
import 'package:prueba_emigdio/src/model/mentoring.dart';
import 'package:prueba_emigdio/src/remote/api/api_services.dart';
import 'package:prueba_emigdio/src/resources/colors.dart';
import 'package:prueba_emigdio/src/ui/feature/home/widgets/course_card.dart';

class MentoringDetailScreen extends StatelessWidget {
  
  final Mentoring mentoring;

  const MentoringDetailScreen({super.key, required this.mentoring});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: color1,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mentoring.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color2
                    ),),
              Image.network(ApiService().getPathImage(mentoring.image), height: 200, width: double.infinity),
              Html(data: mentoring.detail),
              const Text('Cursos disponibles',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color2
                    ),),
              const SizedBox(height: 10,),
              FutureBuilder<List<Course>>(
                future: ApiService().getCourses(), // Usar el método getMentorings
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No mentorships available'));
                  } else {
                    return SizedBox(
                      height: 300, // Altura fija para las tarjetas
                      child: ListView.builder(
                      scrollDirection: Axis.horizontal, // Dirección horizontal
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return CourseCard(item: item);
                    },));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
