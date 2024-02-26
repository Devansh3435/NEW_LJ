import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';

class PDFScreen extends StatefulWidget {
  final String pdfTitle;
  final String pdfUrl;

  PDFScreen({required this.pdfTitle, required this.pdfUrl});

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  late PDFDocument pdfDocument;

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  Future<void> loadPDF() async {
    pdfDocument = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pdfTitle),
      ),
      body: pdfDocument == null
          ? Center(child: CircularProgressIndicator())
          : PDFViewer(
              document: pdfDocument,
              showNavigation: true,
            ),
    );
  }
}
