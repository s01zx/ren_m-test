import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/others.dart';
import 'package:flutter_application_1/models/trans_model.dart';
import 'package:http/http.dart' as http;

class AppProvider with ChangeNotifier {
  List<TransModel> transList = [];

  List<TransModel> get transactionlist {
    return [...transList];
  }

  Future<bool> getTransactionHistory() async {
    var url = Uri.parse(
        "https://api-sandbox.renmoney.com/deposit-transfer/api/v3/investment/3580016662/transactions");

    try {
      var post = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Sourceappid": sourceappid,
          "Authorization": "Bearer $bearerToken",
        },
      ).timeout(const Duration(seconds: 20), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Check your internet and try again!');
      });

      var response = json.decode(post.body);
      //print(response);

      if (post.statusCode != 200) {
        throw Exception("Something went wrong");
      } else {
        var data = response["data"]["clientTransactions"] as List<dynamic>;
        data.forEach((element) {
          transList.add(TransModel(
            id: element["transactionId"].toString(),
            type: element["type"],
            amount: element["amount"].toString(),
            desc: element["comment"] ?? "N/A",
            date: element["entryDate"],
          ));
        });

        return true;
      }
    } on Exception catch (e) {
      throw e;
    }
  }
}
