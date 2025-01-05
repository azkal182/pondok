// lib/helpers/pasaran_jawa_helper.dart

const List<String> pasaranJawa = ["Legi", "Pahing", "Pon", "Wage", "Kliwon"];

String convertDateToPasaranJawa(DateTime date) {
  // Tanggal 1 Suro 1555 Javanese (epoch reference)
  DateTime epochJava = DateTime(1633, 2, 8);

  // Menghitung jumlah hari antara tanggal yang diberikan dan epochJava
  int daysBetween = date.difference(epochJava).inDays;

  // Menentukan indeks pasaran berdasarkan sisa pembagian 5
  int pasaranIndex = daysBetween % 5;

  // Mengembalikan nama pasaran Jawa
  return pasaranJawa[pasaranIndex];
}
