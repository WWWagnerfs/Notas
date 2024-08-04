import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloco_de_notas/styles/app_style.dart';
import 'package:intl/intl.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot document) {
  Timestamp timestamp = document["data_creat"];

  String formattedDate = DateFormat('dd/MM/yyyy').format(timestamp.toDate());

  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[document["cor_id"]],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.0,),
          Text(
            document["notas_titulo"],
            style: AppStyle.mainTitle,
          ),
          SizedBox(height: 8.0,),
          Text(
            formattedDate,
            style: AppStyle.dateTitle,
          ),
          Text(
            document["comentario"],
            style: AppStyle.mainContent,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    ),
  );
}
