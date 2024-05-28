import 'package:uyishi/models/employee.dart';
import 'package:uyishi/models/product.dart';

class Company {
  final String company;
  final String location;
  final List<Employee> employees;
  final List<Product> products;

  Company({
    required this.company,
    required this.location,
    required this.employees,
    required this.products,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      company: json['company'],
      location: json['location'],
      employees: (json['employees'] as List)
          .map((e) => Employee.fromJson(e))
          .toList(),
      products: (json['products'] as List)
          .map((p) => Product.fromJson(p))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'location': location,
      'employees': employees.map((e) => e.toJson()).toList(),
      'products': products.map((p) => p.toJson()).toList(),
    };
  }
}