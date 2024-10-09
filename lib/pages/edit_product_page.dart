import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grocery_management/entity/product.dart';
import 'package:grocery_management/services/app_service.dart';
import 'package:grocery_management/services/auth_service.dart';

import 'components/app_button.dart';
import 'components/app_image_picker.dart';
import 'components/app_text_field.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final authService = AuthService();
  final appService = AppService();

  late TextEditingController _productName;
  late TextEditingController _productCategory;
  late TextEditingController _productPrice;

  @override
  void initState() {
    super.initState();
    _productName = TextEditingController(text: widget.product.name);
    _productCategory = TextEditingController(text: widget.product.category);
    _productPrice = TextEditingController(text: widget.product.price);
  }

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

  void updateProduct() {
    appService.updateProduct(
      widget.product.id,
      _productName.text,
      _productCategory.text,
      _productPrice.text,
      widget.product.imageUrl,
      _image,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppImagePicker(
                onTap: getImageGallery,
                imageUrl: widget.product.imageUrl,
                image: _image,
              ),
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
                text: "Edit Product",
                onTap: () {
                  updateProduct();
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
