import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class GoogleSheetsOrdersForm{
  //לא לשכוח להוסיף ערך גם ב()toParameters !
  String fullName = "";
  String phone = "";
  String mail = "";
  String city = "";
  String street = "";

  String link = "";
  String size = "M"; //ברירת מחדל
  String color = "";
  String referred = "";
  String introReferred = "";
  var dateSubmit;

  String advertiserName = "";
  String whatsAppNumber = "";
  var dateJoined;
  //לא לשכוח להוסיף ערך גם ב()toParameters !

  GoogleSheetsOrdersForm({this.fullName, this.phone, this.mail, this.city, this.street,
    this.link, this.size, this.color, this.referred,this.introReferred ,this.dateSubmit,
    this.advertiserName, this.whatsAppNumber, this.dateJoined});

  String toParameters() => "?fullName=$fullName&phone=$phone&mail=$mail&city=$city&street=$street&link=$link&size=$size&color=$color&referred=$referred&introReferred=$introReferred&dateSubmit=$dateSubmit&advertiserName=$advertiserName&whatsAppNumber=$whatsAppNumber&dateJoined=$dateJoined";
}

/*
?fullName=$fullName
&phone=$phone
&mail=$mail
&city=$city
&street=$street

&link=$link
&size=$size
&color=$color
&referred=$referred
*/

class FormController{
  final void Function(String) callback;
  // static const String URL = "https://script.googleusercontent.com/macros/echo?user_content_key=O2Veo1F2KLKBAacM632DUy3CyK6sBCGlag9bI0NKG-_LEj07Bqg9rQJLewpL1IgjNGiuyE_YtwM1hz4qd3t9Brz52YFXXAeWm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnFsJlOOVvtUfLMSc0yBAXSPKGVk9NcVbqEEQg2S_Bxo3x-y25C5nKMDkPaDqLMI9Rg&lib=M0DKGm_2neOF1CXheG8Wsju3K9VxzWrpr";
  static const String URL = "https://script.google.com/macros/s/AKfycbxU9-SJbSTmoH61lNsdBiy3UGiW-FW7kVvpiJ7cyMROXxvTOVs/exec";
  static const STATUS_SUCCESS = "SUCCESS";
  FormController(this.callback);

  void submitForm(GoogleSheetsOrdersForm googleSheetsConnection) async{
    try{
      await http.get(URL + googleSheetsConnection.toParameters() ).then(
              (response){
            callback(convert.jsonDecode(response.body)['status']);
          });
    } catch(e){
      print(e);
    }
  }
}
