part of 'subjects_bloc.dart';

@immutable
sealed class SubjectsEvent {}

class GetAllSubjectsEvent extends SubjectsEvent {
  final Map<String, dynamic> params;

  GetAllSubjectsEvent({required this.params});
}
