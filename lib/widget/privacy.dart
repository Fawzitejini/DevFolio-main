import 'dart:io';
import 'dart:html' as html;
import 'package:folio/menu/constants/own_colors.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PdfLoader extends StatefulWidget {
  const PdfLoader({Key key}) : super(key: key);

  @override
  _PdfLoaderState createState() => _PdfLoaderState();
}

class _PdfLoaderState extends State<PdfLoader> {
  @override
  Widget build(BuildContext context) {
    final PdfViewerController _pdfViewerController = PdfViewerController();
    return Scaffold(
      appBar: AppBar(title: Text("Privacy & policy"), backgroundColor:BrandColors.darkgray),
      body: SfPdfViewer.asset('assets/privacy.pdf',
          controller: _pdfViewerController,
          canShowScrollStatus: true,
          canShowScrollHead: true),
      floatingActionButton: IconButton(
        onPressed: () async {
          String path = '/assets/privacy.pdf';
      
          html.AnchorElement anchorElement = new html.AnchorElement(href: path);

          anchorElement.download = path;

          anchorElement.click();
          html.window.open(path, "privacy.pdf");

          //  file.writeAsBytesSync(await pdf.save());
        },
        icon: Icon(Icons.download,size:35),
      ),
    );
  }
  Directory findRoot(FileSystemEntity entity) {
    final Directory parent = entity.parent;
    if (parent.path == entity.path) return parent;
    return findRoot(parent);
}
}
