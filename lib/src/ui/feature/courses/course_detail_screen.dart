import 'package:flutter/material.dart';
import 'package:prueba_emigdio/src/model/course.dart';
import 'package:prueba_emigdio/src/model/mentoring.dart';
import 'package:prueba_emigdio/src/remote/api/api_services.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(ApiService().getPathImage(course.image), height: 200, width: double.infinity),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(course.description),
            ),
            FutureBuilder<List<Mentoring>>(
              future: ApiService().getMentorings(), 
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
                      final mentoring = snapshot.data![index];
                      return ListTile(
                        title: Text(mentoring.name),
                        subtitle: Text(mentoring.description),
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
