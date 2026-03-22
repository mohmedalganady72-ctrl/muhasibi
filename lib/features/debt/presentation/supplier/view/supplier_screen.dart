import 'package:ccount/features/debt/presentation/controllers/client_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupplierScreen extends StatelessWidget {
  const SupplierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ClientController co = Get.put(ClientController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Supplier Screen'),
      ),
      body:
          // GetBuilder<ClientController>(
          // builder: (controller) =>
          // InkWell(
          // onTap: () => controller.buildPage(context),
          // child:
          const Center(
        child: Text('Supplier Screen Content'),
      ),
    );
    // ));
  }
}

