import 'package:amazone_clone/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amazone_clone/common/widgets/signup_button.dart';
import 'package:amazone_clone/models/order.dart';
import 'package:amazone_clone/providers/user.dart';

class TrackOrder extends StatefulWidget {
  final Order order;

  const TrackOrder({required this.order, Key? key}) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  int _currentStep = 0;

  Future<void> _adminChangeOrderStatus(int status) async {
    try {
      await Provider.of<AdminProvider>(context, listen: false)
          .changeOrderStatus(status + 1, widget.order);
      setState(() {
        _currentStep += 1;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    _currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = Provider.of<UserProvider>(context, listen: false).isAdmin;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
      ),
      child: Stepper(
        physics: const ScrollPhysics(),
        controlsBuilder: (ctx, details) {
          if (isAdmin && _currentStep < 4) {
            return Column(
              children: [
                const SizedBox(height: 10),
                CustomButton(
                  btnText: 'Done',
                  onTap: () => _adminChangeOrderStatus(details.currentStep),
                )
              ],
            );
          }
          return const SizedBox();
        },
        currentStep: _currentStep < 3 ? _currentStep : 3,
        steps: [
          Step(
            title: const Text('Pending'),
            content: const Text('Your order is yet to be delivered'),
            isActive: _currentStep > 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Completed'),
            content: const Text(
              'Your order has been delivered, you are yet to sign.',
            ),
            isActive: _currentStep > 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Recieved'),
            content:
                const Text('Your order has been delivered and signed by you.'),
            isActive: _currentStep > 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Delivered'),
            content: const Text('Your order is yet to be delivered'),
            isActive: _currentStep > 3,
            state: _currentStep > 3 ? StepState.complete : StepState.indexed,
          ),
        ],
      ),
    );
  }
}
