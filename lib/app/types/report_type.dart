
enum ReportType {
  daily, monthly
}

extension ReportTypeExtension on ReportType {

  String name(){
    switch(this){
      case ReportType.daily: return "Diário";
      case ReportType.monthly: return "Mensal";
    }
  }
}