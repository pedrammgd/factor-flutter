import 'package:dio/dio.dart';

Dio httpClient() {
  return Dio(BaseOptions(
      baseUrl: 'https://parseapi.back4app.com/classes',
      receiveDataWhenStatusError: true,
      headers: {
        'X-Parse-Application-Id': 'nZLXEWExCdEBnZpQ06NzKpF8bUmDpdbqUi39BOxO',
        'X-Parse-REST-API-Key': '4ZVwIcoSaLWPAkxlSOpV9gyggvGtrHiUTig2kTTP',
        'Content-Type': 'application/json'
      },
      connectTimeout: 5000));
}
