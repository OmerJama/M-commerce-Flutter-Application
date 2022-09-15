import 'package:flutter/material.dart';

class AdminGuide extends StatefulWidget {
  const AdminGuide({Key? key}) : super(key: key);

  @override
  State<AdminGuide> createState() => _AdminGuideState();
}

class _AdminGuideState extends State<AdminGuide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guide"),
        centerTitle: true,
      ),
      body: SafeArea(child: 
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("How to manage your store", style: TextStyle(fontFamily: 'Mula', fontSize: 20),),
              SizedBox(height: 40,),
              Text("Adding products to your store", style: TextStyle(fontFamily: 'Mula'),),
              Divider(),
              Text("To add a product to your store, you must first add a category. To do this, you go to manage store and tap the add category option, here you will be able to add a category name as well as an image for that said category. It is strongly recommended that you have at least 3 categories to make your home screen look better. \n\nOnce you have added your categories you can proceed to adding the items in your store by clicking the add a product in the manage store section. Here you will be asked to add a product name, description, a price, the sizes available and the stock for each size as well as the image that will appear to your customers (it is highly recommended you keep the same background image for each product as this will be more aesthetically pleasing to your customers)", textAlign: TextAlign.left, style: TextStyle(fontFamily: 'Grotesk'),),
              SizedBox(height: 40,),
              Text("Editing your products", style: TextStyle(fontFamily: 'Mula'),),
              Divider(),
              Text("When your customers make purchases, the stock level that you provided when you first added the product will update depending on how many orders have been made. If you wish to update this stock or any other element of the item you can edit the product in the management section, here you will be able to edit the name, description, sizes available and stock levels and the image that your customers will see. \n\nYou also have a low stock section which will show you which items are low in stock (ones that have less than 20 items in stock). It is strongly recommended you keep your stock levels above 10 per size available because once the item is out of stock, it will be removed from your store until you restock.",  textAlign: TextAlign.left, style: TextStyle(fontFamily: 'Grotesk'),),
              SizedBox(height: 40,),
              Text("Dealing with your orders", style: TextStyle(fontFamily: 'Mula'),),
              Divider(),
              Text("Your dashboard has some vital information. At the top, you will see your revenue, this is based on all orders that have not been cancelled. Underneath you will find information about how many orders you have had and orders that are awaiting shipment. To view your orders, you can access it through your dashboard or through the manage store section.\n\nIn the orders section, you will be able to see all your orders that are either awaiting shipment, shipped, delivered or cancelled. When you tap on each order, you will be given information about the delivery address as well as the opportunity to change the status of every order - these status changes will be reflected to your customers.",  textAlign: TextAlign.left, style: TextStyle(fontFamily: 'Grotesk'),),
            ],
          ),
        ),
      )),
    );
  }
}