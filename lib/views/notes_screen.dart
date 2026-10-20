import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_state.dart';
import 'widgets/note_dialog.dart';
import 'widgets/note_item.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  void _showAddNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<NoteBloc>(),
        child: const NoteDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App (Hive & BLoC)'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoaded) {
            if (state.notes.isEmpty) {
              return const Center(
                child: Text(
                  'No notes yet. Tap + to create one!',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                return NoteItem(note: state.notes[index]);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
