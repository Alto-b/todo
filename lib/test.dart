

import 'dart:convert';

Future<void> post() async{
  String url="";
  body={

  };
  Uri uri = Uri.parse(url);
  final response = await http.post(uri,body:jsonEncode(body),header:{});
  if(response.statusCode == 200){

  }
  else{
    
  }
}