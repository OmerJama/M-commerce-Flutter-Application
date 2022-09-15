

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;


class PaymentHandler {
  final String? payIntentId;
  final bool isError;
  final String message;

  PaymentHandler({
    this.payIntentId,
    required this.isError,
    required this.message,
  });
}

class PaymentService {
  PaymentService();

  Future<PaymentHandler> initPaymentSheet(String? displayName, String? email, double totalAmount, String address) async {
    try {
      // 1. create payment intent on the server
      final response = await http.post(
          Uri.parse(
              'https://us-central1-omers-mobileapp-msc.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'name' : displayName,
            'email': email,
            'amount': (totalAmount * 100).toString(),
            'address' : address
          });

      final jsonResponse = jsonDecode(response.body);

      //2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          merchantDisplayName: 'OMSHOP',
          customerId: jsonResponse['customer'],
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
          style: ThemeMode.light,
          testEnv: true,
          merchantCountryCode: 'US',
          billingDetails: BillingDetails(
            address: Address(city: address, country: address, line1: address, line2: address, postalCode: address, state: address)
          )
          
          
          
        ),
      );
      // 3. Present to the user and await the result
      await Stripe.instance.presentPaymentSheet();
      return PaymentHandler(
          isError: false,
          message: "Success",
          payIntentId: jsonResponse['paymentIntent']);

    } catch (e) {
      if (e is StripeException) {
        return PaymentHandler(
            isError: true,
            message: 'Error from Stripe: ${e.error.localizedMessage}');
      } else {
        return PaymentHandler(isError: true, message: 'Error: $e');
      }
    }
  }
}
