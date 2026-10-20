import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/note_model.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final Box<NoteModel> _noteBox = Hive.box<NoteModel>('notes_box');

  NoteBloc() : super(NoteInitial()) {
    on<LoadNotesEvent>(_onLoadNotes);
    on<AddNoteEvent>(_onAddNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteNoteEvent>(_onDeleteNote);
  }

  void _onLoadNotes(LoadNotesEvent event, Emitter<NoteState> emit) {
    final notes = _noteBox.values.toList().reversed.toList();
    emit(NoteLoaded(notes));
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<NoteState> emit) async {
    final newNote = NoteModel(
      title: event.title,
      content: event.content,
      createdAt: DateTime.now(),
    );
    await _noteBox.add(newNote);
    final notes = _noteBox.values.toList().reversed.toList();
    emit(NoteLoaded(notes));
  }

  Future<void> _onUpdateNote(
      UpdateNoteEvent event, Emitter<NoteState> emit) async {
    event.note.title = event.newTitle;
    event.note.content = event.newContent;
    await event.note.save();
    final notes = _noteBox.values.toList().reversed.toList();
    emit(NoteLoaded(notes));
  }

  Future<void> _onDeleteNote(
      DeleteNoteEvent event, Emitter<NoteState> emit) async {
    await event.note.delete();
    final notes = _noteBox.values.toList().reversed.toList();
    emit(NoteLoaded(notes));
  }
}
