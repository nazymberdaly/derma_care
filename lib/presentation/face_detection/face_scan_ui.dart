import 'package:camera/camera.dart';
import 'package:derma_care/presentation/chat/chat_page.dart';
import 'package:derma_care/presentation/widgets/detector_view.dart';
import 'package:derma_care/presentation/widgets/face_detector_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceScanPage extends StatefulWidget {
  const FaceScanPage({required this.skinConcern, required this.skinType, super.key});

  final String skinConcern;
  final String skinType;

  @override
  State<FaceScanPage> createState() => _FaceScanPageState();
}

class _FaceScanPageState extends State<FaceScanPage> {
  int currentStep = 1;
  bool _canProcess = true;
  bool _isBusy = false;
  bool _imageCaptured = false;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    ),
  );

  final List<String> steps = [
    "Align your face straight ahead within the frame. Hold still for a few seconds while we scan.",
    "Turn your face slightly to the right. Keep it aligned within the frame.",
    "Turn your face slightly to the left. Keep it aligned within the frame.",
  ];
  var _cameraLensDirection = CameraLensDirection.front;

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess || _isBusy || _imageCaptured) return;
    _isBusy = true;

    final faces = await _faceDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Faces found: ${faces.length}\n\n';
      for (final face in faces) {
        text += 'face: ${face.boundingBox}\n\n';
      }
      //_text = text;
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  CustomPaint? _customPaint;

  void nextStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });
    } else {
      // Handle final step
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatPage(
            skinType: '',
            skinConcern: '',
          ),
        ),
      );
      print("Face scan completed");
      //const ChatPage(
      //   skinType: '',
      //   skinConcern: '',
      // ),
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            // Title
            Text(
              "Scan Your Face - ${currentStep == 1 ? "Front View" : currentStep == 2 ? "Left View" : "Right View"}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Instructions
            Text(
              steps[currentStep - 1],
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),

            Expanded(
              child: DetectorView(
                title: 'Face Detector',
                customPaint: _customPaint,
                text: steps[currentStep - 1],
                onImage: _processImage,
                initialCameraLensDirection: _cameraLensDirection,
                onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
              ),
            ),

            // Circular face scan indicator
            // Expanded(
            //   child: Center(
            //     child: ClipOval(
            //       // ClipOval ensures the DetectorView is rounded
            //       child: Container(
            //         width: double.infinity, // Make it take the full width
            //         height: double.infinity, // Make it take the full height
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle, // Ensure the container is circular
            //           border: Border.all(color: Colors.blue, width: 2),
            //         ),
            //         child: DetectorView(
            //           title: 'Face Detector',
            //           customPaint: _customPaint,
            //           text: steps[currentStep - 1],
            //           onImage: _processImage,
            //           initialCameraLensDirection: _cameraLensDirection,
            //           onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      height: 8,
                      decoration: BoxDecoration(
                        color: index < currentStep ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),

            // Next Button
            ElevatedButton(
              onPressed: nextStep,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.blue,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Next",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
