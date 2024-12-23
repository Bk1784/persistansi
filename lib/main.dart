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
      title: 'Bagus Kurniaawan',
      
      home: PhotoScreen(),
    );
  }
}

class PhotoScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API-post'),
      ),
      body: FutureBuilder<List<dynamic>>(
          future: apiService
              .fetchPhotos(), //untuk menarik data pada fetchPost yang ada pada main.dart
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        snapshot.data![index]['thumbnailUrl'],
                        fit: BoxFit.cover,
                        height: 120,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data![index]['title'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
            }
          }),
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('API-post'),
  //     ),
  //     body: FutureBuilder<List<dynamic>>(
  //         future: apiService.fetchPhotos(), //untuk menarik data pada fetchPost yang ada pada main.dart
  //         builder: (context, snapshot) {
  //           if (snapshot.hasError) {
  //             return Center(
  //               child: CircularProgressIndicator(),
  //             );
  //           } else if (snapshot.hasError) {
  //             return Center(
  //               child: Text('Error: ${snapshot.error}'),
  //             );
  //           } else {
  //             return ListView.builder(
  //                 itemCount: snapshot
  //                     .data!.length, // menghitung data yang ada pada list
  //                 itemBuilder: (context, index) {
  //                   // membuat ketika data dipilih sesuai dengan index
  //                   return ListTile(
  //                     title: Text(snapshot.data![index]
  //                         ['title']), // mengambil data yang ada pada title json
  //                     subtitle: Text(snapshot.data![index]
  //                         ['body']), //mengambil data yang ada pada body json
  //                   );
  //                 });
  //           }
  //         }),
  //   );
  // }
}
