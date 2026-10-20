import '../models/note_model.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoaded extends NoteState {
  final List<NoteModel> notes;

  NoteLoaded(this.notes);
}
