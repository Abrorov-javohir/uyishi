import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uyishi/models/company.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<Company> futureCompany;

  @override
  void initState() {
    super.initState();
    futureCompany = fetchCompany();
  }

  Future<Company> fetchCompany() async {
    const jsonString = '''
    {
      "company": "Tech Solutions",
      "location": "San Francisco",
      "employees": [
        {
          "name": "Alice",
          "age": 30,
          "position": "Developer",
          "skills": ["Dart", "Flutter", "Firebase"]
        },
        {
          "name": "Bob",
          "age": 25,
          "position": "Designer",
          "skills": ["Photoshop", "Illustrator"]
        }
      ],
      "products": [
        {
          "name": "Product A",
          "price": 29.99,
          "inStock": true
        },
        {
          "name": "Product B",
          "price": 49.99,
          "inStock": false
        }
      ]
    }
    ''';

    final companyMap = jsonDecode(jsonString);
    return Company.fromJson(companyMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        title: const Text(
          "RTS Business",
          style: TextStyle(color: Colors.red),
        ),
        actions: const [
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
        ],
      ),
      body: FutureBuilder<Company>(
        future: futureCompany,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final company = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  Card(
                    color: Colors.blue,
                    child: ListTile(
                      title: Text(
                        company.company,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text("Location: ${company.location}"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...company.employees
                      .map((employee) => Card(
                            color: Colors.red,
                            child: ListTile(
                              title: Text(
                                employee.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Age: ${employee.age}"),
                                  Text("Position: ${employee.position}"),
                                  Text("Skills: ${employee.skills.join(', ')}"),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                  const SizedBox(height: 20),
                  ...company.products
                      .map((product) => Card(
                            color: Colors.yellow,
                            child: ListTile(
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Price: \$${product.price}'),
                                  Text(
                                      'In Stock: ${product.inStock ? "True" : "False"}'),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
