import 'dart:io';

import 'package:amazone_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/common/widgets/custom_textfield.dart';
import 'package:amazone_clone/common/widgets/signup_button.dart';
import 'package:amazone_clone/features/admin/widgets/file_picker.dart';
import 'package:amazone_clone/providers/admin_provider.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _addProductFormKey = GlobalKey<FormState>();
  final _productNameCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _quantityCtrl = TextEditingController();
  List<File> _images = [];

  var _loading = false;

  String _selectedCategory = 'Mobiles';
  final List<String> _productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void _getImages(List<File> images) {
    _images = images;
  }

  Future<void> _setProduct() async {
    if (!_addProductFormKey.currentState!.validate() || _images.isEmpty) return;
    setState(() {
      _loading = true;
    });

    try {
      await Provider.of<AdminProvider>(context, listen: false).createProduct(
        name: _productNameCtrl.text,
        description: _descriptionCtrl.text,
        price: double.parse(_priceCtrl.text),
        quantity: double.parse(_quantityCtrl.text),
        category: _selectedCategory,
        images: _images,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      showSnackBar(context, 'Something went wrong');
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _productNameCtrl.dispose();
    _descriptionCtrl.dispose();
    _priceCtrl.dispose();
    _quantityCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add product',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: _addProductFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                SelectFiles(getImages: _getImages),
                const SizedBox(height: 30),
                CustomTextField(
                  textController: _productNameCtrl,
                  hintText: 'Product Name',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  textController: _descriptionCtrl,
                  hintText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  textController: _priceCtrl,
                  hintText: 'Price',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  textController: _quantityCtrl,
                  hintText: 'Quantity',
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    underline: const SizedBox.shrink(),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    value: _selectedCategory,
                    items: _productCategories
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ),
                        )
                        .toList(),
                    onChanged: (String? value) {
                      if (value == null || value.isEmpty) return;
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                ),
                _loading
                    ? Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      )
                    : CustomButton(btnText: 'Sell', onTap: _setProduct),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
