import 'dart:convert';
import 'dart:io';

void main() async {
  final file = File('lib/l10n/app_en.arb');
  final content = await file.readAsString();
  final Map<String, dynamic> jsonMap = jsonDecode(content);
  final client = HttpClient();

  int count = 0;
  for (final key in jsonMap.keys) {
    String value = jsonMap[key];
    if (value.endsWith('[EN]')) {
      final textToTranslate = value.substring(0, value.length - 4).trim();
      if (textToTranslate.isEmpty) {
        jsonMap[key] = '';
        continue;
      }
      final url = Uri.parse('https://translate.googleapis.com/translate_a/single?client=gtx&sl=vi&tl=en&dt=t&q=${Uri.encodeComponent(textToTranslate)}');
      
      try {
        final request = await client.getUrl(url);
        final response = await request.close();
        if (response.statusCode == 200) {
          final responseBody = await response.transform(utf8.decoder).join();
          final jsonResponse = jsonDecode(responseBody);
          String translatedText = '';
          for (var chunk in jsonResponse[0]) {
            if (chunk[0] != null) {
              translatedText += chunk[0];
            }
          }
          jsonMap[key] = translatedText;
          print('Translated: $textToTranslate -> $translatedText');
          count++;
          
          // sleep to prevent rate limiting
          await Future.delayed(Duration(milliseconds: 100));
        } else {
          print('Error for $textToTranslate, status: ${response.statusCode}');
        }
      } catch (e) {
        print('Exception translating $key: $e');
      }
    }
  }

  client.close();
  final encoder = JsonEncoder.withIndent('  ');
  await file.writeAsString(encoder.convert(jsonMap));
  print('Done translating $count items!');
}
