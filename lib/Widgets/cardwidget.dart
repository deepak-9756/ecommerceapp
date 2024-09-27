import 'package:ecommerceapp/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceapp/service/apiservide.dart';

class CardWidget extends StatefulWidget {
  final int index;
  const CardWidget({super.key, required this.index});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context, listen: true);
    var productdata = api.datauser[widget.index];

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 5,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                productdata: productdata,
                heroTag: productdata.id,
              ),
            ),
          );
        },
        leading: Hero(
          tag: productdata.id,
          child: CircleAvatar(
            backgroundImage: NetworkImage(productdata.image.toString()),
            radius: 30,
          ),
        ),
        title: Text(
          "ID: ${productdata.id.toString()}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          'Title: ${productdata.title.toString()}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        trailing: Text(
          "Price: \$${productdata.price.toString()}",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        contentPadding: const EdgeInsets.all(8.0),
      ),
    );
  }
}
