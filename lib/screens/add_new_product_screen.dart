import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../widget/model/product.dart';

class AddNewProductScreen extends StatefulWidget {

  AddNewProductScreen({super.key,this.product});
  Product?product;
  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}
class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _inProgress = false;

  Future<void> postRequest() async {
    _inProgress = true;
    setState(() {});
    Product product=Product(
      "",
      _titleTEController.text.trim(),
      _productCodeTEController.text.trim(),
      _imageTEController.text.trim(),
      _priceTEController.text.trim(),
      _quantityTEController.text.trim(),
      _totalPriceTEController.text.trim()
    );
    final Response response = await post(
        Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct'),
        body: jsonEncode(product.toJson()),
        headers: {'Content-Type': 'application/json'});
    print(response.statusCode);

    print(response.body);
    if (response.statusCode == 200) {
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(
       'The product is successfully added'
     ),));
     _titleTEController.clear();
     _totalPriceTEController.clear();
     _quantityTEController.clear();
     _priceTEController.clear();
     _productCodeTEController.clear();
     _imageTEController.clear();
    }
    _inProgress = false;
    setState(() {});
  }

  Future<void>updatePostRequest()async{
    _inProgress = true;
    setState(() {});
    Map<String, String> inputBody = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _productCodeTEController.text.trim(),
      "ProductName": _titleTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalPriceTEController.text.trim(),
      "UnitPrice": _priceTEController.text.trim(),
    };
    final Response response = await post(
        Uri.parse('https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product!.id}'),
        body: jsonEncode(inputBody),
        headers: {'Content-Type': 'application/json'});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(
          'The product is successfully added'
      ),));
      _titleTEController.clear();
      _totalPriceTEController.clear();
      _quantityTEController.clear();
      _priceTEController.clear();
      _productCodeTEController.clear();
      _imageTEController.clear();
    }
    _inProgress = false;
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
  if(widget.product!=null){
    _titleTEController.text=widget.product!.ProductName;
    _productCodeTEController.text=widget.product!.ProductCode;
    _totalPriceTEController.text=widget.product!.TotalPrice;
    _priceTEController.text=widget.product!.UnitPrice;
    _quantityTEController.text=widget.product!.Quantity;
    _imageTEController.text=widget.product!.Image;
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleTEController,
                  decoration: const InputDecoration(
                    hintText: "Tittle",
                  ),
                  validator: isValidate,
                ),
                TextFormField(
                  controller: _productCodeTEController,
                  decoration: const InputDecoration(
                    hintText: "Product code",
                  ),
                  validator: isValidate,
                ),
                TextFormField(
                  controller: _imageTEController,
                  decoration: const InputDecoration(
                    hintText: "Enter the image",
                  ),
                  validator: isValidate,
                ),
                TextFormField(
                  controller: _quantityTEController,
                  decoration: const InputDecoration(
                    hintText: "Quantity",
                  ),
                  validator: isValidate,
                ),
                TextFormField(
                  controller: _priceTEController,
                  decoration: const InputDecoration(
                    hintText: "Price",
                  ),
                  validator: isValidate,
                ),
                TextFormField(
                  controller: _totalPriceTEController,
                  decoration: const InputDecoration(
                    hintText: "Total Price",
                  ),
                  validator: isValidate,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: _inProgress
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if(widget.product==null){
                                  postRequest();
                                }
                                else {
                                  updatePostRequest();
                                }
                              }
                            },
                            child: widget.product==null? const Text("Add Product"):const Text("Update Product"),),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? isValidate(value) {
    {
      if (value!.isEmpty) {
        return "Enter a valid value";
      } else {
        return null;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleTEController.clear();
    _totalPriceTEController.clear();
    _quantityTEController.clear();
    _priceTEController.clear();
    _productCodeTEController.clear();
    _imageTEController.clear();
  }
}
