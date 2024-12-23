import 'package:flutter/material.dart';
import 'package:persistansi/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Prices',
      home: CryptoScreen(),
    );
  }
}

class CryptoScreen extends StatefulWidget {
   const CryptoScreen({super.key});

  @override
  _CryptoScreenState createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  late Future<List<dynamic>> cryptoDataFuture;
  List<dynamic>? filteredData;

  @override
  void initState() {
    super.initState();
    cryptoDataFuture = CryptoData().fetchCrypto();
  }

  void filterCrypto(String query, List<dynamic> data) {
    setState(() {
      if (query.isEmpty) {
        filteredData = null;
      } else {
        filteredData = data.where((crypto) {
          return crypto['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Crypto',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor:  Color.fromRGBO(58, 66, 86, 1.0),
      body: FutureBuilder<List<dynamic>>(
        future:
            cryptoDataFuture, //untuk menarik data pada fetchPost yang ada pada main.dart
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<dynamic> data = filteredData ?? snapshot.data!;
            data.sort(
                (a, b) => b['current_price'].compareTo(a['current_price']));
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'search',
                      border: OutlineInputBorder(
                       
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        
                      )
                    ),
                    onChanged: (value) {
                      filterCrypto(value, snapshot.data!);
                    },
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final crypto = data[index];
                          return Card(
                            color: Colors.black,
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: ListTile(
                              leading: Image.network(
                                crypto['image'],
                                width: 50,
                                height: 50,
                              ),
                              title: Text(crypto['name'], style: TextStyle(color: Colors.white),),
                              subtitle:
                                  Text('Price: \$${crypto['current_price']}', style: TextStyle(color: Colors.grey[600]),),
                              trailing: Text(
                                'Change: ${crypto['price_change_percentage_24h'].toStringAsFixed(2)}%',
                                style: TextStyle(
                                  color:
                                      crypto['price_change_percentage_24h'] >= 0
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                            ),
                          );
                        }))
              ],
            );
          }
        },
      ),
    );
  }
}
