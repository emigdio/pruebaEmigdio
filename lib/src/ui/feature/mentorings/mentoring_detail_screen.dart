import 'package:flutter/material.dart';
import 'package:prueba_emigdio/src/model/course.dart';
import 'package:prueba_emigdio/src/model/mentoring.dart';
import 'package:prueba_emigdio/src/remote/api/api_services.dart';

class MentoringDetailScreen extends StatelessWidget {
  
  final Mentoring mentoring;

  const MentoringDetailScreen({super.key, required this.mentoring});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(mentoring.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(ApiService().getPathImage(mentoring.image), height: 200, width: double.infinity),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(mentoring.description),
            ),
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
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final course = snapshot.data![index];
                      return ListTile(
                        title: Text(course.name),
                        subtitle: Text(course.description),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
