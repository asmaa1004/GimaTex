import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generateAndSavePDF(List<String> arabicTableKeys, List<dynamic> tableData, String reportName,List<String>pdfTableKeys) async {
  DateTime now = DateTime.now();
  String formattedDate = '${now.year}-${now.month}-${now.day}';

  final image = await imageFromAssetBundle('assets/images/GimaTexLogo.png');

  // List<String> tableKeys = tableData[0].keys.toList();
  var myFont = pw.Font.ttf(await rootBundle.load("assets/fonts/NotoNaskhArabic-Regular.ttf"));
  final doc = pw.Document();

  int itemsPerPage = 20;
  // Calculate the number of pages required
  int totalPages = (tableData.length / itemsPerPage).ceil();

  for (int currentPage = 0; currentPage < totalPages; currentPage++) {
    int startIndex = currentPage * itemsPerPage;
    int endIndex = (currentPage + 1) * itemsPerPage;

    // Adjust endIndex if it exceeds the total length
    if (endIndex > tableData.length) {
      endIndex = tableData.length;
    }

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            //table header logo, name and date
            pw.Align(
              alignment: pw.Alignment.topLeft,
              child: pw.Image(image, width: 50, height: 50),
            ),
            pw.SizedBox(height: 10.00),
            pw.Align(
              alignment: pw.Alignment.topLeft,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'نوع التقرير : $reportName',
                    style: pw.TextStyle(font: myFont, fontSize: 15),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.Text(
                    'تاريخ التقرير : ${formattedDate}',
                    style: pw.TextStyle(font: myFont, fontSize: 15),
                    textDirection: pw.TextDirection.rtl,
                  ),
                ],
              ),
            ),
            pw.Divider(),
            pw.SizedBox(height: 15.00),
            _buildTablePage(
              context,
              arabicTableKeys,
              pdfTableKeys,
              tableData.sublist(startIndex, endIndex),
              myFont,
            )
          ]);
        },
      ),
    );
  }

  ///this code snippet if you want to share the pdf file directly not to save it in your phone
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save()).then((value) async {
    final pdf = await doc.save();
    // await Printing.sharePdf(bytes: pdf, filename: '$reportName.pdf');
    if (pdf != null) {
      await Printing.sharePdf(bytes: pdf, filename: '$reportName.pdf');
    }
  });
}

pw.Widget _buildTablePage(
    pw.Context context, List<String> arabicTableKeys, List<String> tableKeys, List<dynamic> tableData, pw.Font myFont) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(6.00),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Add a table header with column names
        pw.Table.fromTextArray(
          headerStyle: pw.TextStyle(font: myFont, fontSize: 10),
          // headers: arabicTableKeys,
          headers: arabicTableKeys
              .map((header) {
           return pw.Container(
              alignment: pw.Alignment.centerRight, // Align text to the right for RTL
              color: PdfColors.grey300,
              child: pw.Text(
                header,
                style: pw.TextStyle(font: myFont, fontSize: 10),
                textDirection: pw.TextDirection.rtl, // Set text direction to RTL
              ),
            );
          })
              .toList()
              .reversed
              .toList(),
          cellStyle: pw.TextStyle(font: myFont, fontSize: 10),
          data: tableData
              .map((rowData) => tableKeys
                  .map((key) {
                    return pw.Container(
                      alignment: pw.Alignment.centerRight, // Align text to the right for RTL
                      child: pw.Text(
                          (rowData[key]?.toString()==null||rowData[key]?.toString()=="")?"---"
                          :rowData[key]!.toString().length<15?rowData[key]!.toString():rowData[key]!.toString().substring(0, 15),
                          // rowData[key]?.toString()??"---",
                        style: pw.TextStyle(font: myFont, fontSize: 10),
                        textDirection: pw.TextDirection.rtl,
                        softWrap: false,
                      ),
                    );
                  })
                  .toList()
                  .reversed
                  .toList())
              .toList(),
        ),
      ],
    ),
  );
}
