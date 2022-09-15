import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        bottomOpacity: 0.1,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 8, right: 8, bottom: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "About OMSHOP",
                    style: TextStyle(
                        fontFamily: 'Grotesk',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Everything you wanted to know about us",
                style: TextStyle(
                    fontFamily: 'Grotesk', color: Colors.grey.shade600),
              ),
              const SizedBox(
                height: 30,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://firebasestorage.googleapis.com/v0/b/omers-mobileapp-msc.appspot.com/o/omshop.png?alt=media&token=87315e95-ec41-4548-92f2-bae3f28f59f0",
                  height: 250,
                  width: 250,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  "Who we are",
                  style: TextStyle(
                      fontFamily: 'Grotesk',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                children: [
                  Text(
                      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
                ],
              ),
              const SizedBox(height: 20),
              const ExpansionTile(
                title: Text(
                  "What we do",
                  style: TextStyle(
                      fontFamily: 'Grotesk',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                children: [
                  Text(
                      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
                ],
              ),
              const SizedBox(height: 20),
              const ExpansionTile(
                title: Text(
                  "Our core values",
                  style: TextStyle(
                      fontFamily: 'Grotesk',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                children: [
                  Text(
                      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
                ],
              ),
              const SizedBox(height: 20),
              const ExpansionTile(
                title: Text(
                  "Where to contact us",
                  style: TextStyle(
                      fontFamily: 'Grotesk',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                children: [
                  Text(
                      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
