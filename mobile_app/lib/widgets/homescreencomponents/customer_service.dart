import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/homescreencomponents/customer_live_chat.dart';
import 'package:mobile_app/widgets/homescreencomponents/user_faq.dart';

class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({Key? key}) : super(key: key);

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        bottomOpacity: 0.1,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Text(
                  "Tell us how we can help ",
                  style: TextStyle(fontFamily: 'Mula', fontSize: 25),
                ),
                Icon(Icons.waving_hand, color: Colors.blue.shade700,)
              ],
            ),
            Text(
              "We are on standby for service and support",
              softWrap: true,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0),
              child: CachedNetworkImage(imageUrl: "https://firebasestorage.googleapis.com/v0/b/omers-mobileapp-msc.appspot.com/o/wehearyou.jpg?alt=media&token=90a2bb0f-98ed-4c96-9fc8-da0de1565622",)
            ),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerLiveChat(),)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                  ),
                  width: MediaQuery.of(context).size.width/1.1,
                  height: 100,
                  child: Row(
                    children:  [
                      Image.asset("assets/img/chatpic.jpg", height: 150, width: 100,),
                      const SizedBox(width: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          const SizedBox(height: 15,),
                          const Text("Live chat", style: TextStyle(fontFamily: 'Grotesk', fontSize: 30, fontWeight: FontWeight.bold),),
                          Text("Start a conversation!", style: TextStyle(color: Colors.grey.shade600),)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FaqScreen(),)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                  ),
                  width: MediaQuery.of(context).size.width/1.1,
                  height: 100,
                  child: Row(
                    children:  [
                      Image.asset("assets/img/faqpic.png", height: 150, width: 100,),
                      const SizedBox(width: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          const SizedBox(height: 15,),
                          const Text("FAQs", style: TextStyle(fontFamily: 'Grotesk', fontSize: 30, fontWeight: FontWeight.bold),),
                          Text("Find answers!", style: TextStyle(color: Colors.grey.shade600),)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
