import 'package:flutter/material.dart';
import 'package:grocery_management/entity/product.dart';
import 'package:grocery_management/pages/add_product_page.dart';
import 'package:grocery_management/services/app_service.dart';
import 'package:grocery_management/services/auth_service.dart';

import 'components/app_product_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AppService _appService = AppService();
  final AuthService _authService = AuthService();

  void logout() {
    _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery Management"),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: _buildProductList(),
        // child: Text("Hello"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddProductPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildProductList() {
    return StreamBuilder<List<Product>>(
      stream: _appService.getProductStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        List<Product> products = snapshot.data!;
        return ListView(
          children: products
              .map((product) => _buildProductListItem(product))
              .toList(),
        );
      },
    );
  }

  Widget _buildProductListItem(Product product) {
    if (product.userId == _authService.getCurrentUser()?.uid) {
      return AppProductTile(product: product);
    } else {
      return Container();
    }
  }
}
