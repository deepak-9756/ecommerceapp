import 'package:ecommerceapp/Widgets/cardwidget.dart';
import 'package:ecommerceapp/Widgets/filterwidget.dart';
import 'package:ecommerceapp/Widgets/idrangewidget.dart';
import 'package:ecommerceapp/Widgets/pricerangewidget.dart';
import 'package:ecommerceapp/modal/CardModal.dart';
import 'package:ecommerceapp/service/apiservide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ApiService>(create: (_) => ApiService())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<CardItem>>(
        future: api.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("jhghjb");
            return Column(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white, // Background color
                    // Text color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  child: const Text("Sorting Product According Price"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SortPriceWidget()));
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white, // Background color
                    // Text color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  child: const Text("Price Ranges"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PriceRangeWidget()));
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white, // Background color
                    // Text color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  child: const Text("Filter Categories"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FilterWidget()));
                  },
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return CardWidget(
                          index: index,
                        );
                      }),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
