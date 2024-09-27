import 'package:flutter/material.dart';
import 'package:ecommerceapp/modal/CardModal.dart';

class DetailPage extends StatelessWidget {
  final CardItem productdata;
  final int heroTag;

  const DetailPage({
    super.key,
    required this.productdata,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productdata.title.toString()),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: heroTag,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(productdata.image.toString()),
                      radius: 100, // Adjust size as needed
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title: ${productdata.title}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Price: \$${productdata.price}',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.green),
                      ),
                      // Add more details here as needed
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
