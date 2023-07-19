import 'dart:convert';

import 'package:news_dekho/utils/variables.dart';
import 'package:http/http.dart' as http;

import '../utils/APIkey.dart';

Future<List> fetchNews(String category) async {
  String lang = '';
  if (variables.country == '')
    lang = 'en'; //if global is selected then the language is set to 'en'
  try {
    var result;
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?language=$lang&category=$category&country=${variables.country}&page=${variables.pageNo.toString()}&apiKey=${APIkey.key1}&q=${variables.query}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      result = json.decode(response.body);

      print('Done:  ${response.statusCode}');
      //Calculating the paeg no.
      if (result['articles'] != null) {
        if (result['totalResults'] > 0) {
          var total = result['totalResults'] / 20;
          variables.maxPages = total.ceil();
          //As we only have the access upto 100 results
          if (variables.maxPages > 5) variables.maxPages = 5;
        }
        print(
            'TotalResult=${result['totalResults']}, pages=${variables.maxPages}');
        print('PageResults: ${result['articles'].length}');
        return result['articles']; // Return the articles immediately
      } else {
        print('No articles found.');
      }
    } else if (response.statusCode == 429) {
      //If there is too many request, then providing an alternative API key
      url = Uri.parse(
          'https://newsapi.org/v2/top-headlines?language=$lang&category=$category&country=${variables.country}&page=${variables.pageNo.toString()}&apiKey=${APIkey.key2}&q=${variables.query}');
      final response_1 = await http.get(url);
      if (response_1.statusCode == 200) {
        result = json.decode(response_1.body);
        if (result['articles'] != null) {
          if (result['totalResults'] > 0) {
            var total = result['totalResults'] / 20;
            variables.maxPages = total.ceil();
          }
          print(
              'TotalResult=${result['totalResults']}, pages=${variables.maxPages}');
          print('PageResults: ${result['articles'].length}');
          return result['articles']; // Return the articles
        } else {
          print('No articles found.');
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return []; // Return an empty list if no articles are found
  } catch (error) {
    print('Error: $error');
    return []; // Return an empty list in case of any errors
  }
}
