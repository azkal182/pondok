import 'dart:convert';
import 'package:equatable/equatable.dart';

class BalanceEntity extends Equatable {
  final int id;
  final String noRekening;
  final String saldoTabungan; // saldoTabungan dalam format string
  final int saldoUpt; // saldoUpt sudah berupa integer

  const BalanceEntity({
    required this.id,
    required this.noRekening,
    required this.saldoTabungan,
    required this.saldoUpt,
  });

  // Method to convert from JSON
  factory BalanceEntity.fromJson(Map<String, dynamic> json) {
    return BalanceEntity(
      id: json['id'],
      noRekening: json['no_rekening'],
      saldoTabungan: json['saldo_tabungan'], // String value
      saldoUpt: json['saldo_upt'], // Integer value
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'no_rekening': noRekening,
      'saldo_tabungan': saldoTabungan, // String value
      'saldo_upt': saldoUpt, // Integer value
    };
  }

  // Method to convert from a JSON string
  static BalanceEntity fromJsonString(String jsonString) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return BalanceEntity.fromJson(jsonMap['data']);
  }

  // Method to convert to a JSON string
  String toJsonString() {
    final Map<String, dynamic> jsonMap = toJson();
    return json.encode({'data': jsonMap});
  }

  @override
  List<Object?> get props => [id, noRekening, saldoTabungan, saldoUpt];
}
