import 'dart:convert';

import 'package:uyishi/models/company.dart';
import 'package:uyishi/models/employee.dart';
import 'package:uyishi/models/product.dart';

class CompanyController {
  String json = """
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
""";

  getCompanyinfo() {
    final mapData = jsonDecode(json);
    Company company = Company(
      company: mapData['company'],
      location: mapData['location'],
      employees: (mapData['employees'] as List)
          .map((employeeData) => Employee(
                name: employeeData['name'],
                age: employeeData['age'],
                position: employeeData['position'],
                skills: List<String>.from(employeeData['skills']),
              ))
          .toList(),
      products: (mapData['products'] as List)
          .map((productData) => Product(
                name: productData['name'],
                price: productData['price'],
                inStock: productData['inStock'],
              ))
          .toList(),
    );
    print(company.location);
  }

  getproducts() {}
}
