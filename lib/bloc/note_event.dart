import '../models/note_model.dart';

abstract class NoteEvent {}

class LoadNotesEvent extends NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final String title;
  final String content;

  AddNoteEvent({
    required this.title,
    required this.content,
  });
}

class UpdateNoteEvent extends NoteEvent {
  final NoteModel note;
  final String newTitle;
  final String newContent;

  UpdateNoteEvent({
    required this.note,
    required this.newTitle,
    required this.newContent,
  });
}

class DeleteNoteEvent extends NoteEvent {
  final NoteModel note;

  DeleteNoteEvent({required this.note});
}
