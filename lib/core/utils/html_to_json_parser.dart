import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;
import 'package:html_unescape/html_unescape.dart';

class HtmlToJsonHelper {
  // Fungsi untuk mendeteksi apakah teks mengandung karakter Arab
  static bool isArabic(String text) {
    final arabicPattern = RegExp(r'[\u0600-\u06FF]');
    return arabicPattern.hasMatch(text);
  }

  // Fungsi untuk mendeteksi format (bold, italic, normal)
  static String detectFormat(dom.Element element) {
    if (element.localName == 'strong' || element.localName == 'b') {
      return 'bold';
    } else if (element.localName == 'em' || element.localName == 'i') {
      return 'italic';
    }
    return 'normal';
  }

  // Fungsi untuk memproses paragraf dan mendeteksi format
  static List<Map<String, dynamic>> processParagraph(dom.Element paragraph) {
    List<Map<String, dynamic>> formattedText = [];

    // Proses setiap elemen dalam paragraf
    for (var child in paragraph.children) {
      String text = child.text.trim();
      if (text.isNotEmpty) {
        formattedText.add({
          'text': text,
          'format': detectFormat(child),
          'type': isArabic(text) ? 'arabic' : 'text',
        });
      }
    }
    return formattedText;
  }

  // Fungsi untuk memproses list terurut <ol> atau <ul>
  static List<Map<String, dynamic>> processList(dom.Element listElement) {
    List<Map<String, dynamic>> listItems = [];
    int index = 1; // Untuk menghitung nomor urut pada <ol>

    for (var listItem in listElement.children) {
      String text = listItem.text.trim();
      if (text.isNotEmpty) {
        listItems.add({
          'text': text,
          'format': 'normal', // Format normal untuk item list
          'type': isArabic(text) ? 'arabic' : 'text',
          'number': listElement.localName == 'ol' ? index++ : null, // Menambahkan nomor urut untuk <ol>
        });
      }
    }
    return listItems;
  }

  static String cleanHtml(String input) {
    // Langkah 1: Hapus semua tag HTML menggunakan regex
    final textWithoutHtml = input.replaceAll(RegExp(r'</?[^>]+(>|$)'), '');

    // Langkah 2: Decode entitas HTML secara otomatis
    final unescape = HtmlUnescape();
    final decodedText = unescape.convert(textWithoutHtml);

    // Langkah 3: Trim spasi ekstra di awal dan akhir teks
    return decodedText.trim();
  }

// Fungsi untuk mengonversi HTML ke JSON berdasarkan paragraf dan list
  static Map<String, dynamic> convertHtmlToJson(String html) {
    dom.Document document = parse(html);
    List<Map<String, dynamic>> content = [];

    // Iterasi untuk setiap elemen dalam HTML dan menghilangkan elemen kosong (termasuk <p> yang kosong)
    for (var element in document.body!.children.where((e) {
      // Hanya masukkan elemen yang punya teks tidak kosong
      String trimmedText = e.text.trim();
      return trimmedText.isNotEmpty || e.children.isNotEmpty;
    })) {
      if (element.localName == 'p') {
        // Memproses elemen <p> sebagai paragraf
        var paragraphData = processParagraph(element);

        // Hanya tambahkan paragraf jika ada konten di dalamnya
        if (paragraphData.isNotEmpty) {
          content.add({'paragraph': paragraphData});
        }
      } else if (element.localName == 'ol' || element.localName == 'ul') {
        // Memproses elemen <ol> dan <ul> sebagai list
        var listData = processList(element);
        content.add({
          'list': {
            'type': element.localName == 'ol' ? 'ordered' : 'unordered',
            'items': listData,
          }
        });
      } else if (element.localName == 'img') {
        // Memproses elemen <img>
        String? src = element.attributes['src'];
        String? alt = element.attributes['alt'];

        // Tambahkan elemen gambar ke dalam konten jika src ada
        if (src != null) {
          content.add({
            'image': {
              'src': src,
              'alt': alt ?? '', // Gunakan string kosong jika tidak ada atribut alt
            }
          });
        }
      }

    }

    return {'content': content};
  }
}
