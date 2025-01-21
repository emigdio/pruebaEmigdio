import 'package:flutter/material.dart';
import 'package:prueba_emigdio/src/model/course.dart';
import 'package:prueba_emigdio/src/remote/api/api_services.dart';
import 'package:prueba_emigdio/src/resources/colors.dart';
import 'package:prueba_emigdio/src/tools/responsive.dart';
import 'package:prueba_emigdio/src/ui/feature/courses/course_detail_screen.dart';

class CourseCard extends StatelessWidget {
  final Course item;

  const CourseCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {

    final responsive = Responsive(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: responsive.width/2, // Ancho de cada tarjeta
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  ApiService().getPathImage(item.image),
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(fontSize: 16, 
                    fontWeight: FontWeight.bold,
                    color: color2),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '\$${item.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color5,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailScreen( course: item,),
                      ),
                    );
                    },
                    child: const Text('Ver más',
                    style: TextStyle(
                      color: color3,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}