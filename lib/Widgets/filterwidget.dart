import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceapp/service/apiservide.dart';
import 'package:ecommerceapp/modal/CardModal.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String _sortOrder = 'Ascending'; // Default sort order
  double? _minPrice;
  double? _maxPrice;
  String? _selectedCategory;
  String _categorySearch = '';

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context);

    // Fetch categories if not already fetched
    // if (api.categories.isEmpty) {
    //   api.fetchCategories();
    // }

    // Function to filter products by price range and category
    List<CardItem> _filterProducts(List<CardItem> products) {
      List<CardItem> filteredProducts = products;

      // Filter by price range
      if (_minPrice != null || _maxPrice != null) {
        filteredProducts = filteredProducts.where((product) {
          final price = product.price;
          return (_minPrice == null || price >= _minPrice!) &&
              (_maxPrice == null || price <= _maxPrice!);
        }).toList();
      }

      // Filter by category
      if (_selectedCategory != null && _selectedCategory!.isNotEmpty) {
        filteredProducts = filteredProducts.where((product) {
          return product.category == _selectedCategory;
        }).toList();
      }

      // Filter by category search text
      if (_categorySearch.isNotEmpty) {
        filteredProducts = filteredProducts.where((product) {
          return product.category != null &&
              product.category
                  .toLowerCase()
                  .contains(_categorySearch.toLowerCase());
        }).toList();
      }

      return filteredProducts;
    }

    // Sorting function
    void _sortProducts(List<CardItem> products, String order) {
      if (order == 'Ascending') {
        products.sort((a, b) => a.price.compareTo(b.price));
      } else {
        products.sort((a, b) => b.price.compareTo(a.price));
      }
    }

    List<CardItem> filteredProducts = _filterProducts(api.datauser);
    _sortProducts(filteredProducts, _sortOrder);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter and Sort Products'),
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
                });
              },
            ),
            const SizedBox(height: 16.0),
            // Price Range Inputs
            TextField(
              decoration: const InputDecoration(
                labelText: 'Min Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  _minPrice = value.isNotEmpty ? double.tryParse(value) : null;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Max Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  _maxPrice = value.isNotEmpty ? double.tryParse(value) : null;
                });
              },
            ),
            const SizedBox(height: 16.0),
            // Category Search TextField
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Category',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _categorySearch = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            // Category Dropdown
            DropdownButton<String>(
              hint: const Text('Select Category'),
              value: _selectedCategory,
              items: filteredProducts.map((category) {
                return DropdownMenuItem<String>(
                  value: category.category,
                  child: Text(category.category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 16.0),
            // Display sorted and filtered products
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  var productdata = filteredProducts[index];
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
