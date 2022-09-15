import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/adminwidgets/admin_orders_body.dart';

class AdminDisplayOrders extends StatefulWidget {
  const AdminDisplayOrders({Key? key}) : super(key: key);

  @override
  State<AdminDisplayOrders> createState() => _AdminDisplayOrdersState();
}
  String dropdownValue = 'All orders';

class _AdminDisplayOrdersState extends State<AdminDisplayOrders> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(child: Column(children: [
          Container(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.grey.shade100),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: const Text("Select size", style: TextStyle(color: Colors.black),),
                          style: const TextStyle(
                              fontFamily: 'Grotesk',
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          value: dropdownValue,
                          items: <String>[
                            'All orders',
                            'Shipped orders',
                            'Delivered orders',
                            'Cancelled orders'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dropdownValue = value!;
                              // ignore: avoid_print
                              print(dropdownValue);
                            });
                          },
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
              AdminOrderDisplayBody(dropdownValue: dropdownValue),
        ],)),
      ),
    );
  }
}