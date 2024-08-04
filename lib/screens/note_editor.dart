import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloco_de_notas/styles/app_style.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key, this.document});
  final QueryDocumentSnapshot? document;

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late int cor_id;
  late String date;
  late TextEditingController _titleController;
  late TextEditingController _mainController;

  @override
  void initState() {
    super.initState();
    if (widget.document != null) {
      cor_id = widget.document!['cor_id'];
      Timestamp timestamp = widget.document!["data_creat"];
      date = DateFormat('dd/MM/yyyy').format(timestamp.toDate());
      _titleController =
          TextEditingController(text: widget.document!["notas_titulo"]);
      _mainController =
          TextEditingController(text: widget.document!["comentario"]);
    } else {
      cor_id = Random().nextInt(AppStyle.cardsColor.length);
      date = DateFormat('dd/MM/yyyy').format(DateTime.now());
      _titleController = TextEditingController();
      _mainController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[cor_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[cor_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(widget.document == null ? "Adicionar Nota" : "Editar Nota",
            style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Título',
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 8.0),
            Text(date, style: AppStyle.dateTitle),
            SizedBox(height: 28),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Comentário',
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          if (widget.document != null) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Nota atualizada com sucesso!')));
            await FirebaseFirestore.instance
                .collection("Notas")
                .doc(widget.document!.id)
                .update({
              "comentario": _mainController.text,
              "cor_id": cor_id,
              "data_creat":
                  Timestamp.fromDate(DateFormat('dd/MM/yyyy').parse(date)),
              "notas_titulo": _titleController.text,
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Nota adicionada com sucesso!')));
            await FirebaseFirestore.instance.collection("Notas").add({
              "comentario": _mainController.text,
              "cor_id": cor_id,
              "data_creat": Timestamp.fromDate(DateTime.now()),
              "notas_titulo": _titleController.text,
            });
          }
          Navigator.pop(context);
        },
        child: Icon(Icons.save, color: Colors.white),
      ),
      bottomSheet: Container(
        height: 50,
        color: Colors.blue,
      ),
    );
  }
}
