import 'package:flutter/material.dart';
import 'package:kantin_app/main.dart';
import 'package:kantin_app/pages/form_food.dart';
import 'package:kantin_app/widgets/form_food_entry.dart';

class AdminFoodPage extends StatelessWidget {
  const AdminFoodPage({super.key});

  Future<List<dynamic>> fetchData() async {
    final response = await supabase.from('Makanan').select('*');
    return response as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    onPressed: () {},
                    mini: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.person_outline,
                        color: Colors.black, size: 25),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FormFood(),
                        ),
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
                          horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FutureBuilder(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No data found');
                    } else {
                      final data = snapshot.data!;
                      return DataTable(
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
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image),
                                  ),
                                ),
                                DataCell(Text(item['Nama'] ?? 'N/A')),
                                DataCell(Text(item['Kategori'] ?? 'N/A')),
                                DataCell(
                                    Text(item['Harga']?.toString() ?? 'N/A')),
                                DataCell(
                                  IconButton(
                                    onPressed: () async {
                                      await supabase
                                          .from('Makanan')
                                          .delete()
                                          .eq('id', item['id']);
                                      // setState(() {});
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            );
                          },
                        ).toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
