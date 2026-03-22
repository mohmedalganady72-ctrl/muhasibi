import 'package:ccount/features/debt/presentation/controllers/client_controller.dart';
import 'package:ccount/core/constant/app_color.dart';
import 'package:ccount/core/shared/text_form_filed.dart';
import 'package:ccount/core/theme/theme_mode/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoadContactScreen extends StatelessWidget {
  const LoadContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ClientController clientContollere = Get.find<ClientController>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Iconsax.arrow_left_2))
        ],
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Text("60".tr),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                // TextField(
                //   onChanged: clientContollere.filterContacts,
                //   decoration: InputDecoration(
                //     filled: true,
                //     fillColor: AppColor.filleTextFiled,
                //     hintText: "ابحث بالاسم...",
                //     hintStyle: TextStyleTheme.hintFiled,
                //     prefixIcon: const Icon(
                //       Icons.search,
                //       color: AppColor.IconButton,
                //     ),

                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(width: 0.5, color: Colors.white),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                //   ),
                // ),
                Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormFieldWidget(
                onChanged: clientContollere.filterContacts,

                // suffixIcon: _controller.searchController.text.isNotEmpty
                //     ? IconButton(
                //         onPressed: () {
                //           _controller.searchController.clear(); // يمسح النص
                //           _controller.filter("");
                //         },
                //         icon: Icon(
                //           Icons.close,
                //           size: 23.sp,
                //           color: AppColor.IconButton,
                //         ))
                //     : null,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColor.maybe,
                ),
                hintText: "22".tr,
                keyboardType: TextInputType.text,
                // controller: _controller.searchController,
                validator: (value) => null,
              ),
            ),
          ),
        ),
      ),
      body: GetBuilder<ClientController>(
        builder: (_controller) => _controller.contacts.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _controller.filteredContacts.length,
                itemBuilder: (context, index) {
                  final contact = _controller.filteredContacts[index];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(contact.displayName),
                    subtitle: contact.phones.isNotEmpty
                        ? Text(contact.phones.first.number)
                        : Text("61".tr),
                    onTap: () async {
                      clientContollere.loadFromContact(contact);
                    },
                  );
                },
              ),
      ),
    );
  }
}

