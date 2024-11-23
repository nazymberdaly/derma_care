part of 'face_detection_bloc.dart';

@freezed
class FaceDetectionState with _$FaceDetectionState {
  const factory FaceDetectionState.initial() = _Initial;
  const factory FaceDetectionState.loading() = _Loading;
  const factory FaceDetectionState.success(List<Face> faces) = _Success;
  const factory FaceDetectionState.failure(String message) = _Failure;
}
