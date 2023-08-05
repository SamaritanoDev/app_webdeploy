import 'package:app_webdeploy/config/data/list_constancia_tasa.dart';
import 'package:app_webdeploy/models/constancia_tasa.dart';
import 'package:app_webdeploy/presentation/widgets/voucher_custom.dart';
import 'package:flutter/material.dart';

class DropdownTribute extends StatefulWidget {
  final VoucherCustom voucherData;
  // final Function(String) onChanged;
  const DropdownTribute({
    Key? key,
    required this.voucherData,
    // required this.onChanged,
  }) : super(key: key);

  @override
  State<DropdownTribute> createState() => _DropdownTributeState();
}

class _DropdownTributeState extends State<DropdownTribute> {
  final TextEditingController _conceptController = TextEditingController();
  final TextEditingController _constounitarioController = TextEditingController();
  final TextEditingController _entidadController = TextEditingController();

  List<String> _tributeOptions = [];
  late List<TableItem> uniqueTableData;

  @override
  void initState() {
    super.initState();
    _tributeOptions = tableData.map<String>((data) => data['Tasa']).toList();
    uniqueTableData = tableData
        .map((data) => TableItem(
              id: data['Id'],
              cod: data['Cod'],
              entidad: data['Entidad'],
              tasa: data['Tasa'],
              concepto: data['Concepto'],
              costoUnitario: data['Costo unitario'],
              documento: data['Documento'],
            ))
        .toList();
  }

  List<TableItem> listItems() {
    return uniqueTableData.map<TableItem>(
      (TableItem item) {
        return item;
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<TableItem>(
          value: null,
          decoration: const InputDecoration(
            labelText: 'Tasa/Tributo',
            border: OutlineInputBorder(),
          ),
          items: listItems().map<DropdownMenuItem<TableItem>>(
            (TableItem item) {
              return DropdownMenuItem<TableItem>(
                value: item,
                child: Text(item.tasa),
              );
            },
          ).toList(),
          onChanged: (TableItem? newValue) {
            if (newValue != null) {
              updateFields(newValue);
              // Aquí también actualizamos el campo de texto del Concepto
              _conceptController.text = newValue.concepto;
              _entidadController.text = newValue.entidad;
              _constounitarioController.text = newValue.costoUnitario.toString();
            }
          },
          validator: (value) {
            if (value == null) {
              return 'Por favor, selecciona un tributo';
            }
            return null;
          },
          onSaved: (value) {
            if (value != null) {
              widget.voucherData.tribute = value.tasa;
              _conceptController.text = value.concepto;
              widget.voucherData.entity = value.entidad;
              widget.voucherData.amount = value.costoUnitario;
              widget.voucherData.typeDocument = value.documento;
            }
          },
        ),
        TextFormField(
          controller: _conceptController,
          decoration: const InputDecoration(
            labelText: 'Concepto',
          ),
          onChanged: (newValue) {
            try {
              // Actualizar el controlador y el valor del concepto
              _conceptController.text = newValue;
              widget.voucherData.concept = newValue;
            } catch (e) {}
          },
        ),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: TextFormField(
                controller: _entidadController,
                decoration: const InputDecoration(
                  labelText: 'Entidad',
                ),
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              flex: 2,
              child: TextFormField(
                controller: _constounitarioController,
                decoration: const InputDecoration(
                  labelText: 'Costo unitario',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void updateFields(TableItem item) {
    setState(() {
      widget.voucherData.tribute = item.tasa;
      widget.voucherData.concept = item.concepto;
      _conceptController.text = item.concepto;
      widget.voucherData.entity = item.entidad;
      widget.voucherData.amount = item.costoUnitario;
    });
  }
}
