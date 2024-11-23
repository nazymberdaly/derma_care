part of 'face_detection_bloc.dart';

@freezed
class FaceDetectionEvent with _$FaceDetectionEvent {
  const factory FaceDetectionEvent.loadImage(File imageFile) = _LoadImage;
}
