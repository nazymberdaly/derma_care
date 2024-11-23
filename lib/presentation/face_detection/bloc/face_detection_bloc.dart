import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

part 'face_detection_bloc.freezed.dart';
part 'face_detection_event.dart';
part 'face_detection_state.dart';

class FaceDetectionBloc extends Bloc<FaceDetectionEvent, FaceDetectionState> {
  final FaceDetector faceDetector;

  FaceDetectionBloc(this.faceDetector) : super(const FaceDetectionState.initial()) {
    on<_LoadImage>(_onLoadImage);
  }

  Future<void> _onLoadImage(
    _LoadImage event,
    Emitter<FaceDetectionState> emit,
  ) async {
    emit(const FaceDetectionState.loading());

    try {
      final inputImage = InputImage.fromFile(event.imageFile);
      final List<Face> faces = await faceDetector.processImage(inputImage);

      emit(FaceDetectionState.success(faces));
    } catch (e) {
      emit(FaceDetectionState.failure('Failed to detect faces: $e'));
    }
  }

  @override
  Future<void> close() {
    faceDetector.close();
    return super.close();
  }
}
