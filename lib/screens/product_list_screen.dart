import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest_api_crud_1/screens/add_new_product_screen.dart';
import 'package:rest_api_crud_1/widget/product_item.dart';

import '../widget/model/product.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key, this.product});

  final Product? product;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> productList = [];
  bool _inProgress = false;

  @override
  void initState() {
    getRequest();
    super.initState();
  }

  Future<void> getRequest() async {
    productList.clear();
    _inProgress = true;
    setState(() {});
    Response response =
        await get(Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct'));
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      final Map<String, dynamic> ResponseData = jsonDecode(response.body);
      if (ResponseData['status'] == 'success') {
        for (Map<String, dynamic> jsonResponse in ResponseData['data']) {
          productList.add(Product.fromJson(jsonResponse));
        }
      }
    }
    _inProgress = false;
    setState(() {});
  }
  Future<void> getDeletRequest(String id) async {
    Response response = await get(
        Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/$id'));
    if (response.statusCode == 200) {
      getRequest();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Successfully Deleted this product")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Successfully Deleted this product")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        actions: [
          IconButton(
              onPressed: () {
                getRequest();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
         return getRequest();
        },
        child: _inProgress
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    product: productList[index],
                    GetRequest: getDeletRequest,
                  );
                },
                separatorBuilder: (_, __) => const Divider(
                  height: 2,
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewProductScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
