import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grocery_management/pages/components/app_button.dart';
import 'package:grocery_management/pages/components/app_image_picker.dart';
import 'package:grocery_management/pages/components/app_text_field.dart';
import 'package:grocery_management/services/app_service.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productCategory = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();

  File? _image;

  Future<void> getImageGallery() async {
    final selectedImage = await appService.pickImageFromGallery();
    setState(() {
      if (selectedImage != null) {
        _image = selectedImage;
      } else {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("No Image Picked!"),
          ),
        );
      }
    });
  }

  final appService = AppService();

  void addProduct() {
    appService.addProduct(
      _productName.text,
      _productCategory.text,
      _productPrice.text,
      _image,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // _buildImagePicker(),
              AppImagePicker(onTap: getImageGallery, image: _image),
              const SizedBox(height: 25),
              AppTextField(
                hintText: "Product Name",
                obscureText: false,
                typeText: true,
                controller: _productName,
              ),
              const SizedBox(height: 25),
              AppTextField(
                hintText: "Product Price",
                obscureText: false,
                typeText: false,
                controller: _productPrice,
              ),
              const SizedBox(height: 25),
              AppTextField(
                hintText: "Product Category",
                obscureText: false,
                typeText: true,
                controller: _productCategory,
              ),
              const SizedBox(height: 25),
              AppButton(
                text: "Add Product",
                onTap: () {
                  addProduct();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
