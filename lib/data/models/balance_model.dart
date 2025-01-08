import 'dart:convert';

import '../../domain/entities/balance_entity.dart';

class BalanceModel extends BalanceEntity {
  final int saldoTabunganInt; // saldoTabungan diubah ke integer

  BalanceModel({
    required super.id,
    required super.noRekening,
    required super.saldoTabungan,
    required super.saldoUpt,
  }) : saldoTabunganInt = _convertToInt(saldoTabungan);

  // Helper function to convert String saldo to int
  static int _convertToInt(String value) {
    return (double.tryParse(value) ?? 0).truncate();
  }

  // Factory constructor to convert from Entity to Model
  factory BalanceModel.fromEntity(BalanceEntity entity) {
    return BalanceModel(
      id: entity.id,
      noRekening: entity.noRekening,
      saldoTabungan: entity.saldoTabungan,
      saldoUpt: entity.saldoUpt,
    );
  }

  // Method to convert to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'no_rekening': noRekening,
      'saldo_tabungan': saldoTabunganInt,
      'saldo_upt': saldoUpt,
    };
  }

  // Method to convert from JSON
  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      id: json['id'],
      noRekening: json['no_rekening'],
      saldoTabungan: json['saldo_tabungan'].toString(),
      saldoUpt: json['saldo_upt'],
    );
  }

  // Method to convert from a JSON string
  static BalanceModel fromJsonString(String jsonString) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return BalanceModel.fromJson(jsonMap['data']);
  }

  // Method to convert to a JSON string
  @override
  String toJsonString() {
    final Map<String, dynamic> jsonMap = toJson();
    return json.encode({'data': jsonMap});
  }

  @override
  List<Object?> get props => [id, noRekening, saldoTabunganInt, saldoUpt];
}
