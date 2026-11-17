import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/umkm_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api/umkm';

  Future<List<Umkm>> getUmkm() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List).map((item) => Umkm.fromJson(item)).toList();
    } else {
      throw Exception('Gagal mengambil data UMKM');
    }
  }

  Future<bool> tambahUmkm(Umkm umkm) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(umkm.toJson()),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<bool> updateUmkm(Umkm umkm) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${umkm.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(umkm.toJson()),
    );

    return response.statusCode == 200;
  }

  Future<bool> hapusUmkm(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    return response.statusCode == 200;
  }
}
