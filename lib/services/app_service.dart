import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grocery_management/entity/product.dart';
import 'package:image_picker/image_picker.dart';

class AppService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection("products");
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  // Get product stream
  Stream<List<Product>> getProductStream({String searchQuery = ""}) {
    return _firestore
        .where('userId', isEqualTo: _auth.currentUser?.uid)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs
            .map(
              (doc) {
                final productData = doc.data() as Map<String, dynamic>;
                return Product(
                  id: doc.id,
                  name: productData['name'],
                  category: productData['category'],
                  price: productData['price'],
                  imageUrl: productData['imageUrl'],
                  userId: _auth.currentUser!.uid,
                );
              },
            )
            .where((product) =>
                searchQuery.isEmpty ||
                product.name.toLowerCase().contains(
                      searchQuery.toLowerCase(),
                    ))
            .toList();
      },
    );
  }

  // Upload Image
  Future<String?> uploadImage(File image) async {
    try {
      String userId = _auth.currentUser!.uid;
      String filePath =
          "products/$userId/${DateTime.now().millisecondsSinceEpoch}.png";
      // tham chieu duong dan file toi producs
      Reference reference = _storage.ref().child(filePath);
      // upload image
      UploadTask uploadTask = reference.putFile(image);
      await uploadTask.whenComplete(() => null);
      String imageUrl = await reference.getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  // Delete Image
  Future<void> deleteImage(String imageUrl) async {
    try {
      Reference reference = _storage.refFromURL(imageUrl);
      await reference.delete();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  // Add product
  Future<void> addProduct(
      String name, String category, String price, File? image) async {
    String? imageUrl;

    if (image != null) {
      imageUrl = await uploadImage(image);
    }

    await _firestore.add({
      'name': name,
      'category': category,
      'price': price,
      'userId': _auth.currentUser?.uid.toString(),
      'imageUrl': imageUrl ?? "",
    });
  }

// Update product
  Future<void> updateProduct(String id, String name, String category,
      String price, String imageUrl, File? image) async {
    String? newImageUrl;

    if (image != null) {
      await deleteImage(imageUrl);
      newImageUrl = await uploadImage(image);
    } else {
      newImageUrl = imageUrl;
    }
    await _firestore.doc(id).update(
      {
        'name': name,
        'category': category,
        'price': price,
        'imageUrl': newImageUrl,
      },
    );
  }

  //Delete product
  Future<void> deleteProduct(String id, String imageUrl) async {
    await deleteImage(imageUrl);
    await _firestore.doc(id).delete();
  }

  // Get image gallery
  Future<File?> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
