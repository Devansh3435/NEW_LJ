import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_lj/Screens/pdf_screen.dart';

class AuthenticatedScreen extends StatelessWidget {

  const AuthenticatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authenticated Screen'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('subjects').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          var subjects = snapshot.data!.docs;

          return ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              var subject = subjects[index];
              var subjectName = subject['name'];

              return ListTile(
                title: Text(subjectName),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubjectPDFListScreen(subjectName),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class SubjectPDFListScreen extends StatelessWidget {
  final String subjectName;

  const SubjectPDFListScreen(this.subjectName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subjectName),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('subjects')
            .doc(subjectName)
            .collection('pdfs')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          var pdfs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: pdfs.length,
            itemBuilder: (context, index) {
              var pdf = pdfs[index];
              var pdfTitle = pdf['title'];
              var pdfUrl = pdf['pdfUrl'];

              return ListTile(
                title: Text(pdfTitle),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFScreen(pdfUrl: pdfUrl),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
