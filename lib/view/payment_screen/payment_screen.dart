import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/models/subscription_model/subscription_model.dart';
import 'package:netflix_clone/services/user_service.dart';
import 'package:netflix_clone/view/profile_selection/profile_selection.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.subscription});

  final SubscriptionModel subscription;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  UserService userService = UserService();

  String? _selectedMethod;

  final List<String> _paymentMethods = [
    'Credit/Debit Card',
    'UPI',
    'Net Banking',
    'Wallet',
  ];

  void subscription() {
    if (_selectedMethod != null) {
      userService.savesubscription();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Payment successful via $_selectedMethod!",
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ProfileSelectionPage()),
          (route) => false,
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a payment method"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    // Simulate payment success and navigate
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text(
          'Payment',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),

      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plan Summary
            Text(
              "Subscription Summary",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.subscription.title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "₹${widget.subscription.price.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 251, 54, 54),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Text(
              "Select Payment Method",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // Payment Options
            ..._paymentMethods.map((method) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: RadioListTile<String>(
                  value: method,
                  groupValue: _selectedMethod,
                  activeColor: const Color.fromARGB(255, 255, 21, 21),
                  onChanged: (value) {
                    setState(() {
                      _selectedMethod = value;
                    });
                  },
                  title: Text(
                    method,
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  tileColor: Colors.grey[850],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }),

            const Spacer(),

            // Pay Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 248, 45, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  subscription();
                },
                child: Text(
                  "Pay Now ₹${widget.subscription.price.toStringAsFixed(2)}",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
