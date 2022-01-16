import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportUtil {
  static pw.TextStyle styleTitle = pw.TextStyle(fontSize: 9);
  static pw.TextStyle styleText =
      pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold);
  static Map<int, String> months = {
    1: "Janeiro",
    2: "Fevereiro",
    3: "Março",
    4: "Abril",
    5: "Maio",
    6: "Junho",
    7: "Julho",
    8: "Agosto",
    9: "Setembro",
    10: "Outubro",
    11: "Novembro",
    12: "Dezembro"
  };

  static pw.Container pdfCardReport(
      {required String title,
      required String text,
      List<pw.TextSpan> infos = const []}) {
    List<pw.TextSpan> content = [
      pw.TextSpan(text: "$title\n", style: styleTitle),
      pw.TextSpan(text: "R\$ $text", style: styleText),
    ];

    content.addAll(infos);

    return pw.Container(
      padding: pw.EdgeInsets.all(8),
      decoration:
          pw.BoxDecoration(border: pw.Border.all(color: PdfColor.fromInt(0))),
      child: pw.RichText(
        text: pw.TextSpan(
          children: content,
        ),
      ),
    );
  }
}
