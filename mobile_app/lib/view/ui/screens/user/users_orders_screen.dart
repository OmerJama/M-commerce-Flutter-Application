

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/view/ui/screens/user/users_orders_body.dart';

class UserOrders extends ConsumerStatefulWidget {
  const UserOrders({Key? key}) : super(key: key);

  @override
  ConsumerState<UserOrders> createState() => _UserOrdersState();
}
String dropdownValue = "All orders";

class _UserOrdersState extends ConsumerState<UserOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders', style: TextStyle(fontFamily: 'Grotesk', color: Colors.black, fontWeight: FontWeight.bold),),
        iconTheme: const IconThemeData(color: Colors.black),
        shadowColor: Colors.black,
        bottomOpacity: 0.1,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                          
                          style: const TextStyle(
                              fontFamily: 'Grotesk',
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          value: dropdownValue,
                          items: <String>[
                            'All orders',
                            'Shipped orders',
                            'Delivered orders',
                            'Cancelled orders',
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
              UserOrderBody(dropdownValue: dropdownValue,),
          ],
        ),
      ),
    );
  }
}
