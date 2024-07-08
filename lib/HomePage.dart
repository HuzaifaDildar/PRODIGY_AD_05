import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Center(child: Text("QR CODE SCANNER")),
        ),
        body: Column(
          children: [
            Expanded(
            flex: 5,
            child:QRView(
              key: qrKey,
              onQRViewCreated: _onQrViewCreated)
              ),
              Expanded(
                flex: 1,
                child:Center(
                  child: (result!=null)?
                  Text("Barcoded Data: ${result!.code}"):
                  const Text("Scan a Code"),
                )
                )
          ],
        ),
    );
  }
  void _onQrViewCreated(QRViewController controller){
    this.controller=controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result=scanData;
        _launchInBrowser(result!.code.toString());
      });
     }
     );
  }

  void _launchInBrowser(String string) async {
    await launchUrl(Uri.parse(string));
  }
}