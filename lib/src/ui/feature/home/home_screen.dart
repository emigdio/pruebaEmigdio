import 'package:flutter/material.dart';
import 'package:prueba_emigdio/src/model/course.dart';
import 'package:prueba_emigdio/src/model/mentoring.dart';
import 'package:prueba_emigdio/src/remote/api/api_services.dart';
import '../courses/course_detail_screen.dart';
import '../mentorings/mentoring_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<List<Mentoring>> mentorings;
  late Future<List<Course>> courses;

  @override
  void initState() {
    super.initState();
    mentorings = ApiService().getMentorings();
    courses = ApiService().getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SectionMentorings (
              title: 'Mentorías',
              futureData: mentorings,
              itemBuilder: (context, mentoring) => Card(
                child: ListTile(
                  leading: Image.network(ApiService().getPathImage(mentoring.image), width: 50, height: 50),
                  title: Text(mentoring.name),
                  subtitle: Text(mentoring.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MentoringDetailScreen(mentoring: mentoring),
                      ),
                    );
                  },
                ),
              ),
            ),
            SectionCourses(
              title: 'Cursos',
              futureData: courses,
              itemBuilder: (context, course) => Card(
                child: ListTile(
                  leading: Image.network(ApiService().getPathImage(course.image), width: 50, height: 50),
                  title: Text(course.name),
                  subtitle: Text(course.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailScreen(course: course),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionMentorings extends StatelessWidget {
  final String title;
  final Future<List<Mentoring>> futureData;
  final Widget Function(BuildContext, Mentoring) itemBuilder;

  const SectionMentorings({super.key, 
    required this.title,
    required this.futureData,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Mentoring>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final items = snapshot.data ?? [];

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ...items.map((item) => itemBuilder(context, item)),
          ],
        );
      },
    );
  }
}

class SectionCourses extends StatelessWidget {
  final String title;
  final Future<List<Course>> futureData;
  final Widget Function(BuildContext, Course) itemBuilder;

  const SectionCourses({super.key, 
    required this.title,
    required this.futureData,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final items = snapshot.data ?? [];

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ...items.map((item) => itemBuilder(context, item)),
          ],
        );
      },
    );
  }
}
