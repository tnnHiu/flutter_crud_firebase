import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grocery_management/services/app_service.dart';

class AppImagePicker extends StatefulWidget {
  const AppImagePicker({
    super.key,
    required this.onTap,
    this.image,
    this.imageUrl,
  });

  final void Function()? onTap;
  final File? image;
  final String? imageUrl;

  @override
  State<AppImagePicker> createState() => _AppImagePickerState();
}

class _AppImagePickerState extends State<AppImagePicker> {
  final appService = AppService();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        // child: widget.image != null
        //     ? Image.file(
        //         widget.image!.absolute,
        //         fit: BoxFit.cover,
        //       )
        //     : const Center(
        //         child: Icon(
        //           Icons.add_photo_alternate_outlined,
        //         ),
        //       ),
        child: widget.image != null
            ? Image.file(
                widget.image!.absolute,
                fit: BoxFit.cover,
              )
            : widget.imageUrl != null
                ? Image.network(
                    widget.imageUrl!,
                    fit: BoxFit.cover,
                  )
                : const Center(
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                    ),
                  ),
      ),
    );
  }
}
