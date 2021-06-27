

import 'package:caixabios/app/cash_flow/widgets/output_options.dart';

class ExpenseModel {

  DateTime createdAt;
  String description;
  double value;
  OutputOption outputOption;

  ExpenseModel({this.createdAt, this.description, this.value, this.outputOption});

  ExpenseModel.fromJson(Map<String, dynamic> json){
    createdAt = DateTime.fromMillisecondsSinceEpoch(json["createdAt"]);
    description = json["description"];
    value = json["value"];
    outputOption = OutputOptionBuilder.build(json["dailyFund"]);
  }

  Map<String, dynamic> toJson(){
    return {
      "createdAt": createdAt.millisecondsSinceEpoch,
      "description": description,
      "value": value,
      "outputOption": outputOption.code()
    };
  }

}

enum OutputOption {
  local, geral
}

extension OutputOptionExtension on OutputOption {

  String name(){
    switch(this){
      case OutputOption.local: return "Caixa diário";
      case OutputOption.geral: return "Caixa geral";
    }
  }

  String code(){
    switch(this){
      case OutputOption.local: return "local";
      case OutputOption.geral: return "geral";
      default: return null;
    }
  }
}

class OutputOptionBuilder{

  static OutputOption build(String code){
    switch(code){
      case "local": return OutputOption.local;
      case "geral": return OutputOption.geral;
      default: return null;
    }
  }
}