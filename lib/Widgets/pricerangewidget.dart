import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceapp/service/apiservide.dart';
import 'package:ecommerceapp/modal/CardModal.dart';

class SortPriceWidget extends StatefulWidget {
  const SortPriceWidget({super.key});

  @override
  State<SortPriceWidget> createState() => _SortPriceWidgetState();
}

class _SortPriceWidgetState extends State<SortPriceWidget> {
  String _sortOrder = 'Ascending'; // Default sort order

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context);

    // Sorting function
    void _sortProducts(List<CardItem> products, String order) {
      if (order == 'Ascending') {
        products.sort((a, b) => a.price.compareTo(b.price));
      } else {
        products.sort((a, b) => b.price.compareTo(a.price));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sort Products'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sorting Dropdown
            DropdownButton<String>(
              value: _sortOrder,
              items: <String>['Ascending', 'Descending'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _sortOrder = newValue!;
                  _sortProducts(api.datauser, _sortOrder);
                });
              },
            ),
            const SizedBox(height: 16.0),
            // Display sorted products
            Expanded(
              child: ListView.builder(
                itemCount: api.datauser.length,
                itemBuilder: (context, index) {
                  var productdata = api.datauser[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(productdata.image.toString()),
                        radius: 30,
                      ),
                      title: Text("ID: ${productdata.id.toString()}"),
                      subtitle: Text('Title: ${productdata.title.toString()}'),
                      trailing:
                          Text("Price: \$${productdata.price.toString()}"),
                      contentPadding: const EdgeInsets.all(8.0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
