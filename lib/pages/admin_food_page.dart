import 'package:flutter/material.dart';
import 'package:kantin_app/main.dart';
import 'package:kantin_app/pages/form_food.dart';
import 'package:kantin_app/pages/home_page.dart';

class AdminFoodPage extends StatefulWidget {
  const AdminFoodPage({Key? key}) : super(key: key);

  @override
  _AdminFoodPageState createState() => _AdminFoodPageState();
}

class _AdminFoodPageState extends State<AdminFoodPage> {
  late Future<List<dynamic>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    final response = await supabase.from('Makanan').select('*');
    return response as List<dynamic>;
  }

  void refreshData() {
    setState(() {
      futureData = fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWideScreen = constraints.maxWidth > 600;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainApp(),
                                ),
                              ).then(
                                (value) {
                                  refreshData(); // Refresh data when coming back from the FormFood page
                                },
                              );
                            },
                            mini: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.red,
                              size: 25,
                            ),
                          ),
                          FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: () {},
                            mini: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FormFood(),
                              ),
                            ).then(
                              (value) {
                                refreshData(); // Refresh data when coming back from the FormFood page
                              },
                            );
                          },
                          label: const Text(
                            "Add Food",
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder(
                      future: futureData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No data found');
                        } else {
                          final data = snapshot.data!;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: isWideScreen ? 40 : 20,
                              columns: const <DataColumn>[
                                DataColumn(label: Text("Image")),
                                DataColumn(label: Text("Name")),
                                DataColumn(label: Text("Category")),
                                DataColumn(label: Text("Price")),
                                DataColumn(label: Text("Actions")),
                              ],
                              rows: data.map<DataRow>(
                                (item) {
                                  final imageUrl = item['Image_url'] ??
                                      'https://via.placeholder.com/150';
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Image.network(
                                          imageUrl,
                                          width: 50,
                                          height: 50,
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              const Icon(Icons.broken_image),
                                        ),
                                      ),
                                      DataCell(Text(item['Nama'] ?? 'N/A')),
                                      DataCell(Text(item['Kategori'] ?? 'N/A')),
                                      DataCell(Text(
                                          item['Harga']?.toString() ?? 'N/A')),
                                      DataCell(
                                        IconButton(
                                          onPressed: () async {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("No"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      await supabase
                                                          .from('Makanan')
                                                          .delete()
                                                          .eq('id', item['id']);
                                                      refreshData();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("Yes"),
                                                  )
                                                ],
                                                content: const Text(
                                                    "Are you sure you would like to delete this entry?"),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.delete),
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ).toList(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
