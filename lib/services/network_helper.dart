
import 'dart:convert';


import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;


class NetworkHelper{

  NetworkHelper( this.Url);

 final  String Url ;


 Future<dynamic> getData()async{
   var response = await http.get(Uri.parse(Url));


if (response.statusCode == 200) {
   var decoderJson = jsonDecode(response.body);
   return decoderJson ;
} else {
  print('something is wrong try again ');
}
 }

}