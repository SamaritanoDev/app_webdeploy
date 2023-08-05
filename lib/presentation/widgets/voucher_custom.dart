import 'package:app_webdeploy/config/constans/constans.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/services.dart' show rootBundle; // Importar el paquete flutter/services.dart

class VoucherCustom {
  //datos a completar automatico
  String id;
  String entity;
  double amount;
  int ticket;
  String tribute;
  String concept;
//datos a ingresar
  String name;
  String typeDocument;
  DateTime createdDate;
  int quantity;
  String paymentSequence;
  String trx;
  String atmCode;
  String officeCode;
  String operationNumber;
  int numberDocument;
  DateTime hourOperation;

  VoucherCustom({
    //datos a completar automatico
    required this.id,
    required this.entity,
    required this.amount,
    required this.ticket,
    required this.tribute,
    required this.concept,
//datos a ingresar
    required this.name,
    required this.typeDocument,
    required this.createdDate,
    required this.quantity,
    required this.paymentSequence,
    required this.trx,
    required this.atmCode,
    required this.officeCode,
    required this.operationNumber,
    required this.numberDocument,
    required this.hourOperation,
  });

  // Definir estilos de texto personalizados
  final pw.TextStyle titleStyle = pw.TextStyle(
    fontSize: 18,
    fontWeight: pw.FontWeight.bold,
    color: PdfColors.black,
    decoration: pw.TextDecoration.underline,
  );

  final pw.TextStyle headingStyle = pw.TextStyle(
    fontSize: 10,
    fontWeight: pw.FontWeight.bold,
    color: PdfColors.black,
  );

  final pw.TextStyle bodyStyle = const pw.TextStyle(
    fontSize: 10,
    color: PdfColors.black,
  );

  final pw.TextStyle headingUnderline = pw.TextStyle(
    fontSize: 12,
    fontWeight: pw.FontWeight.bold,
    decoration: pw.TextDecoration.underline,
  );

  final pw.TextStyle subtitleStyle = pw.TextStyle(
    fontSize: 11,
    fontWeight: pw.FontWeight.bold,
  );

  final pw.TextStyle headingRed = pw.TextStyle(
    fontSize: 7,
    fontWeight: pw.FontWeight.bold,
    color: PdfColors.red,
  );

  Future<void> generateAndSavePDF() async {
    final pdf = pw.Document();

    //calculate importe total
    final importeTotal = quantity * amount;

    //parseo a string
    final formattedQuantity = quantity.toString().padLeft(5, '0');
    final formattedAmount = amount.toString();
    final formattedimporteTotal = importeTotal.toString();
    final formattedTicket = ticket.toString().padLeft(12, '0');
    final formattedNumberDOcument = numberDocument.toString();

    // Cargar la imagen desde los activos
    final ByteData logoDatabn = await rootBundle.load(pathlogobn);
    final ByteData logoDatapagalo = await rootBundle.load(pathlogopagalo);
    final ByteData logoDataStore = await rootBundle.load(storesPath);

    final Uint8List logobn = logoDatabn.buffer.asUint8List();
    final Uint8List logopagalo = logoDatapagalo.buffer.asUint8List();
    final Uint8List imageStores = logoDataStore.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Padding(
            padding: const pw.EdgeInsets.all(20.0),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(
                      width: 100,
                      height: 50,
                      fit: pw.BoxFit.contain,
                      pw.MemoryImage(logobn),
                    ),
                    pw.Image(
                      width: 80,
                      height: 50,
                      fit: pw.BoxFit.contain,
                      pw.MemoryImage(logopagalo),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      rucbn,
                      style: pw.TextStyle(
                        color: PdfColors.grey,
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      urlpagalo,
                      style: pw.TextStyle(
                        color: PdfColors.red,
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ), // Agregar la imagen al PDF
                pw.SizedBox(height: 20),
                pw.Text(
                  title,
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        'NRO. TICKET:',
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 50),
                    pw.Text(formattedTicket)
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        'Datos de la operación :',
                        style: headingUnderline,
                      ),
                    ),
                    pw.Row(
                      children: [
                        pw.Text('FECHA DE OPERACIÓN: ', style: headingStyle),
                        pw.Text(
                          DateFormat('dd/MM/yyyy').format(createdDate),
                          style: bodyStyle,
                        ),
                      ],
                    )
                  ],
                ),
                pw.SizedBox(height: 5),
                //datos de caja de operacion
                pw.Container(
                  padding: const pw.EdgeInsets.fromLTRB(5, 5, 5, 5),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColors.black,
                      width: 1.0,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Row(
                        children: [
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('ENTIDAD:', style: subtitleStyle),
                              pw.Text('TASA/TRIBUTO:', style: subtitleStyle),
                              pw.SizedBox(height: 50),
                              pw.Text('CONCEPTO: ', style: subtitleStyle),
                            ],
                          ),
                          pw.SizedBox(width: 80),
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(entity, style: bodyStyle),
                              pw.Text(tribute, style: bodyStyle),
                              pw.SizedBox(height: 50),
                              pw.Text(concept, style: bodyStyle),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    'Datos del contribuyente:',
                    style: headingUnderline,
                  ),
                ),
                pw.SizedBox(height: 5),
                //caja de contribuyente
                pw.Container(
                  padding: const pw.EdgeInsets.fromLTRB(5, 5, 5, 5),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColors.black,
                      width: 1.0,
                    ),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('TIPO DE DOCUMENTO: ', style: subtitleStyle),
                          pw.Text('TASA/NRO. DE DOCUMENTO: ', style: subtitleStyle),
                        ],
                      ),
                      pw.SizedBox(width: 20),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(typeDocument, style: bodyStyle),
                          pw.Text(formattedNumberDOcument, style: bodyStyle),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text('Otros datos :', style: headingUnderline),
                ),
                pw.SizedBox(height: 5),
                pw.Column(
                  children: [
                    //caja de otros datos
                    pw.Container(
                      padding: const pw.EdgeInsets.fromLTRB(5, 5, 5, 5),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1.0,
                        ),
                      ),
                      child: pw.Column(
                        children: [
                          pw.Row(
                            children: [
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('CANTIDAD: ', style: subtitleStyle),
                                  pw.Text('COSTO UNITARIO: ', style: subtitleStyle),
                                ],
                              ),
                              pw.SizedBox(width: 80),
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(formattedQuantity, style: bodyStyle),
                                  pw.Text('S/**********$formattedAmount.00', style: bodyStyle),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //caja de importe total
                    pw.Align(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Container(
                        width: 300,
                        padding: const pw.EdgeInsets.fromLTRB(5, 5, 5, 5),
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                            width: 1.0,
                          ),
                        ),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'IMPORTE TOTAL:',
                              style: headingStyle,
                            ),
                            pw.Text(
                              'S/**********$formattedimporteTotal.00',
                              style: bodyStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                //caja de secuencia de pago
                pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Column(
                        children: [
                          pw.Text('Secuencia\n de pago', style: headingRed),
                          pw.SizedBox(height: 5),
                          pw.Text(paymentSequence, style: bodyStyle),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Text('Fecha de\n operación', style: headingRed),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            DateFormat('dd/MM/yyyy').format(createdDate),
                            style: bodyStyle,
                          ),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text('Trx\n   ',
                              style: const pw.TextStyle(
                                fontSize: 8,
                                color: PdfColors.red,
                              )),
                          pw.SizedBox(height: 8),
                          pw.Text(trx, style: bodyStyle),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Text('Cód.\n cajero', style: headingRed),
                          pw.SizedBox(height: 5),
                          pw.Text(atmCode, style: bodyStyle),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Text('Cód.\n oficina', style: headingRed),
                          pw.SizedBox(height: 5),
                          pw.Text(officeCode, style: bodyStyle),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Text('Hora de\n operación', style: headingRed),
                          pw.SizedBox(height: 5),
                          pw.Text(DateFormat('hh:mm:mm a').format(hourOperation), style: bodyStyle),
                        ],
                      ),
                      pw.SizedBox(width: 200),
                    ],
                  ),
                ]),

                //Termina caja de secuencia de pagos
                pw.SizedBox(height: 70),
                //inicia footer
                pw.Column(
                  children: [
                    pw.Row(
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Container(
                          width: 280,
                          child: pw.Text(
                            textFooter,
                            style: pw.TextStyle(
                              fontSize: 11,
                              color: PdfColors.grey,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        pw.SizedBox(width: 5),
                        pw.Expanded(
                          child: pw.Image(
                            height: 300,
                            fit: pw.BoxFit.contain,
                            pw.MemoryImage(imageStores),
                          ),
                        )
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    pw.Divider(),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        textAviso,
                        style: const pw.TextStyle(
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ],
                ),
                //termina footer
              ],
            ),
          ),
        ),
      ),
    );

    // Convert the PDF to a byte array
    final pdfBytes = await pdf.save(); // Esperar a que se resuelva el Future

    // Create a Blob from the PDF bytes
    final blob = html.Blob([Uint8List.fromList(pdfBytes)], 'application/pdf');

    // Create an object URL from the Blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create an anchor element
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', '${numberDocument}_constancia.pdf')
      ..text = 'Descargar PDF'; // Texto que se mostrará en el enlace de descarga

    // Append the anchor to the body and trigger the download
    html.document.body?.append(anchor);
    anchor.click();

    // Release the URL resource and remove the anchor from the body
    html.Url.revokeObjectUrl(url);
    anchor.remove();
  }
}
