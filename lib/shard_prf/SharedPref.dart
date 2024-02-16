import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

 static late SharedPreferences sharedPreferences;

 static Future <SharedPreferences>init()async{
     return sharedPreferences=await SharedPreferences.getInstance();

  }

 static  Future <bool> setDate({required String key,required bool value})async{
   return await sharedPreferences.setBool(key, value);

  }

 static dynamic getDate({required String? key}){
   return sharedPreferences.get(key??'');


 }

 static Future<bool>  savaData({required String key,required dynamic value})async{
     if(value is String)   return  await  sharedPreferences.setString(key, value);
   if(value is int)   return  await  sharedPreferences.setInt(key, value);
     return  await  sharedPreferences.setBool(key, value);

 }

 static Future<bool> removeData({required String key})async{
   

   return await sharedPreferences.remove(key);

 }

}

