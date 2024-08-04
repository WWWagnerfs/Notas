import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloco_de_notas/styles/app_style.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloco_de_notas/screens/note_editor.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.document, {super.key});
  final QueryDocumentSnapshot document;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    Timestamp timestamp = widget.document["data_creat"];
    formattedDate = DateFormat('dd/MM/yyyy').format(timestamp.toDate());
  }

  Future<void> _deleteNote() async {
    try {
      await FirebaseFirestore.instance
          .collection('Notas')
          .doc(widget.document.id)
          .delete();
      Navigator.pop(context);
    } catch (e) {
      print("Erro ao excluir nota: $e");
    }
  }

  void _editNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(
            document: widget.document),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int cor_id = widget.document['cor_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[cor_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[cor_id],
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: _editNote,
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Excluir Nota"),
                    content:
                        Text("Você tem certeza que deseja excluir esta nota?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Cancelamento bem sucedido!')));
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Nota excluída com sucesso!')));
                          _deleteNote();
                          Navigator.of(context).pop();
                        },
                        child: Text("Excluir"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.0),
            Text(
              widget.document["notas_titulo"],
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 28.0),
            Text(
              formattedDate,
              style: AppStyle.dateTitle,
            ),
            SizedBox(height: 28.0),
            Text(
              widget.document["comentario"],
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
