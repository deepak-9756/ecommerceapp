import 'package:dio/dio.dart';
import 'package:ecommerceapp/modal/CardModal.dart';
import 'package:flutter/material.dart';

class ApiService extends ChangeNotifier {
  final String url = "https://fakestoreapi.com/products/";
  final dio = Dio();
  List<CardItem> datauser = [];

  Future<List<CardItem>> getData() async {
    Response responce = await dio.get(url);
    List<dynamic> data = responce.data;
    try {
      print("ufhd${responce}");

      datauser = List<CardItem>.from(data.map((e) => CardItem.fromJson(e)));
    } catch (e) {
      print("fushgjdbjk$e");
    }

    return List<CardItem>.from(data.map((e) => CardItem.fromJson(e)));
  }
}
