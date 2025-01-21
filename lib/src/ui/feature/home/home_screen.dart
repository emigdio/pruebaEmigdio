import 'package:flutter/material.dart';
import 'package:prueba_emigdio/src/model/course.dart';
import 'package:prueba_emigdio/src/model/mentoring.dart';
import 'package:prueba_emigdio/src/remote/api/api_services.dart';
import 'package:prueba_emigdio/src/resources/colors.dart';
import 'package:prueba_emigdio/src/tools/responsive.dart';
import 'package:prueba_emigdio/src/ui/feature/home/widgets/course_card.dart';
import 'package:prueba_emigdio/src/ui/feature/home/widgets/mentoring_card.dart';
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
      appBar: AppBar(title: const Text('Test Emigdio',
      style: TextStyle(
        color: color1,
        fontSize: 30,
        fontWeight: FontWeight.bold,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(2.0, 2.0),
            blurRadius: 3.0,
            color: color3,
          ),
        ],
      ),),
      backgroundColor: color2,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SectionMentorings (
              title: 'Mentorías',
              futureData: mentorings,
              itemBuilder: (context, mentoring) => MentoringDetailScreen(mentoring: mentoring),
            ),
            SectionCourses(
              title: 'Cursos',
              futureData: courses,
              itemBuilder: (context, course) => CourseDetailScreen(course: course),
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
            Container(
              color: color1,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 24, 
                  fontWeight: FontWeight.bold,
                  color: color2),
                ),
              ),
            ),
             Container(
                padding: const EdgeInsets.all(8.0),
                height: 300, // Altura fija para las tarjetas
                child: ListView.builder(
                scrollDirection: Axis.horizontal, // Dirección horizontal
                itemCount: items.length,
                itemBuilder: (context, index) {
                final item = items[index];
                return MentoringCard(item: item);
             },
          ),
        )
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              color: color1,
              width: double.infinity,
              child: Text(
                title,
                style: const TextStyle(fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: color2),
              ),
            ),
            SizedBox(
                height: 300, // Altura fija para las tarjetas
                child: ListView.builder(
                scrollDirection: Axis.horizontal, // Dirección horizontal
                itemCount: items.length,
                itemBuilder: (context, index) {
                final item = items[index];
                return CourseCard(item: item);
             },))
          ],
        );
      },
    );
  }
}
