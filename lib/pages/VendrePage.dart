import 'package:flutter/material.dart';

import '../widgets/Appbar.dart';

class VendrePage extends StatefulWidget {
  const VendrePage({Key? key}) : super(key: key);

  @override
  State<VendrePage> createState() => _VendrePageState();
}

class _VendrePageState extends State<VendrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      appBar: appBar('Vendre'),
    );
  }

  Widget _body(){
    return Stack( children: [
      SingleChildScrollView(child: Column(children: [],))
    ],);
  }
}



