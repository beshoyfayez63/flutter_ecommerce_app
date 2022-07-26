import 'package:amazone_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pay/pay.dart';

import 'package:amazone_clone/providers/user.dart';
import 'package:amazone_clone/common/widgets/custom_textfield.dart';
import 'package:amazone_clone/constants/global_variables.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = '/address';
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();
  final _flatCtrl = TextEditingController();
  final _areaCtrl = TextEditingController();
  final _pinCodeCtrl = TextEditingController();
  final _townCityCtrl = TextEditingController();

  String addressToBeUsed = '';
  String totalAmount = '';
  final List<PaymentItem> _paymentItems = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    totalAmount = ModalRoute.of(context)?.settings.arguments as String;
    _paymentItems.add(
      PaymentItem(
        amount: totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
        type: PaymentItemType.total,
      ),
    );
  }

  Future<void> _onGPayResults(
    Map<String, dynamic> gResults,
    String userAddress,
  ) async {
    try {
      if (userAddress.isEmpty) {
        await Provider.of<UserProvider>(context, listen: false)
            .saveUserAddress(addressToBeUsed);
      }
      if (!mounted) return;
      await Provider.of<UserProvider>(context, listen: false).createOrder(
        double.parse(totalAmount),
      );
    } catch (e) {
      print(e);
    }
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = '';

    bool isForm = _flatCtrl.text.isNotEmpty ||
        _areaCtrl.text.isNotEmpty ||
        _townCityCtrl.text.isNotEmpty ||
        _pinCodeCtrl.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${_flatCtrl.text}, ${_areaCtrl.text}, ${_townCityCtrl.text}, ${_pinCodeCtrl.text}';
      } else {
        // showSnackBar(context, 'ERROR, Please provide fill all fields');
        throw Exception('Please Enter all fields');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR, Please provide an address');
      throw Exception('Please Enter an address');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAddress = Provider.of<UserProvider>(context).userAddress;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: const Text(
          'Address',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              if (userAddress.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                      ),
                      child: Text(
                        userAddress,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'OR',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              if (userAddress.isEmpty) Container(),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      textController: _flatCtrl,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      textController: _areaCtrl,
                      hintText: 'Area Street',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      textController: _pinCodeCtrl,
                      hintText: 'Pin Code',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      textController: _townCityCtrl,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 20),
                    GooglePayButton(
                      width: double.infinity,
                      height: 50,
                      style: GooglePayButtonStyle.white,
                      type: GooglePayButtonType.buy,
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      onPressed: () => payPressed(userAddress),
                      paymentConfigurationAsset: 'gpay.json',
                      onPaymentResult: (res) =>
                          _onGPayResults(res, userAddress),
                      paymentItems: _paymentItems,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _flatCtrl.dispose();
    _areaCtrl.dispose();
    _pinCodeCtrl.dispose();
    _townCityCtrl.dispose();
  }
}
