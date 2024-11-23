import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetailsPage extends StatelessWidget {
  final List<Face> faces;

  const FaceDetailsPage({super.key, required this.faces});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Face Detection Details")),
      body: ListView.builder(
        itemCount: faces.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Step ${index + 1} - Face Detected"),
            subtitle: Text("Bounding Box: ${faces[index].boundingBox}"),
          );
        },
      ),
    );
  }
}
