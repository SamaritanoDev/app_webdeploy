import 'package:app_webdeploy/models/constancia_tasa.dart';
import 'package:app_webdeploy/presentation/widgets/created_date.dart';
import 'package:app_webdeploy/presentation/widgets/dropdown_tribute.dart';
import 'package:app_webdeploy/presentation/widgets/hour_created.dart';
import 'package:app_webdeploy/presentation/widgets/voucher_custom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TextEditingController dniController = TextEditingController();
  TextEditingController ticketController = TextEditingController();

  late List<TableItem> uniqueTableData;

  final VoucherCustom _voucherData = VoucherCustom(
    id: '',
    entity: '',
    amount: 0.00,
    ticket: 000000000001,
    tribute: '',
    concept: '',
    name: '',
    typeDocument: '',
    createdDate: DateTime.now(),
    quantity: 1,
    paymentSequence: '',
    trx: '',
    atmCode: '',
    officeCode: '',
    operationNumber: '',
    numberDocument: 0,
    hourOperation: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textstyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              } catch (e) {
                print('Error al cerrar sesión: $e');
              }
            },
          ),
        ],
        leadingWidth: 100.0,
        title: Text(
          'Generar Constancia',
          style: textstyle.titleMedium?.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 100, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ingresa el DNI (nombre que saldrá en el archivo):',
                        style: textstyle.titleMedium?.copyWith(color: Colors.amber[900]),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: dniController,
                        maxLength: 8,
                        decoration: InputDecoration(
                          labelText: 'Número de DNI/e',
                          counterText: '${dniController.text.length}/8',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el DNI/e';
                          }
                          if (value.length != 8) {
                            return 'El número de DNI/e debe tener exactamente 8 dígitos y deben ser números';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          final intValue = int.tryParse(value ?? '0') ?? 0;
                          _voucherData.numberDocument = intValue;
                        },
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Ingresa los datos que se completarán en la constancia:',
                        style: textstyle.titleLarge?.copyWith(color: Colors.amber[900]),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        maxLength: 12,
                        initialValue: '000000000001',
                        decoration: InputDecoration(
                          labelText: 'Num de ticket',
                          counterText: '${ticketController.text.length}/12',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese el num de ticket';
                          }
                          if (value.length != 12) {
                            return 'El número de ticket debe tener exactamente 12 dígitos y deben ser números';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          final intValue = int.tryParse(value ?? '0') ?? 0;
                          _voucherData.ticket = intValue;
                        },
                      ),
                      CreatedDate(voucherData: _voucherData),
                      const SizedBox(height: 30),
                      Text(
                        'DATOS DE OPERACION:',
                        style: textstyle.titleMedium?.copyWith(color: Colors.amber[900]),
                      ),
                      const SizedBox(height: 5),
                      DropdownTribute(voucherData: _voucherData),
                      const SizedBox(height: 30),
                      Text(
                        'Ingresa otros datos:',
                        style: textstyle.titleMedium?.copyWith(color: colors.primary),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        initialValue: '1',
                        maxLength: 5,
                        decoration: const InputDecoration(
                          labelText: 'Cantidad',
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa la cantidad';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          final intValue = int.tryParse(value ?? '0') ?? 0;
                          _voucherData.quantity = intValue;
                        },
                      ),
                      TextFormField(
                        maxLength: 8,
                        initialValue: '000000-0',
                        decoration: const InputDecoration(labelText: 'Num de Secuencia de pago'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el Num de Secuencia de pago';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _voucherData.paymentSequence = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: '0000',
                        maxLength: 4,
                        decoration: const InputDecoration(labelText: 'Num Trx'),
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el num Trx';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _voucherData.trx = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: '0000',
                        maxLength: 4,
                        decoration: const InputDecoration(labelText: 'Cód de cajero'),
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el num de Cód de cajero';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _voucherData.atmCode = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: '0000',
                        maxLength: 4,
                        decoration: const InputDecoration(labelText: 'Cód de oficina'),
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el num Cód de oficina';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _voucherData.officeCode = value!;
                        },
                      ),
                      HourDate(voucherData: _voucherData),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.centerRight,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              _generateAndSavePDF();
            }
          },
          child: const Icon(Icons.download),
        ),
      ),
    );
  }

  Future<void> _generateAndSavePDF() async {
    final voucher = VoucherCustom(
      id: _voucherData.id,
      entity: _voucherData.entity,
      amount: _voucherData.amount,
      ticket: _voucherData.ticket,
      tribute: _voucherData.tribute,
      concept: _voucherData.concept,
      name: _voucherData.name,
      typeDocument: _voucherData.typeDocument,
      createdDate: _voucherData.createdDate,
      quantity: _voucherData.quantity,
      paymentSequence: _voucherData.paymentSequence,
      trx: _voucherData.trx,
      atmCode: _voucherData.atmCode,
      officeCode: _voucherData.officeCode,
      operationNumber: _voucherData.operationNumber,
      numberDocument: _voucherData.numberDocument,
      hourOperation: _voucherData.hourOperation,
    );
    await voucher.generateAndSavePDF();

    dniController.clear();
  }
}
