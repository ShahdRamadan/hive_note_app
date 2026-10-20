import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/note_bloc.dart';
import '../../bloc/note_event.dart';
import '../../models/note_model.dart';
import 'note_dialog.dart';

class NoteItem extends StatelessWidget {
  final NoteModel note;

  const NoteItem({
    super.key,
    required this.note,
  });

  void _showEditNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<NoteBloc>(),
        child: NoteDialog(note: note),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: ListTile(
        onTap: () => _showEditNoteDialog(context),
        title: Text(
          note.title.isEmpty ? 'Untitled' : note.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.content.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                note.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 6),
            Text(
              _formatDate(note.createdAt),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () {
            context.read<NoteBloc>().add(DeleteNoteEvent(note: note));
          },
        ),
      ),
    );
  }
}
