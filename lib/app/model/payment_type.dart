

enum PaymentType {
  cash, credit_card, debit_card, pix
}

extension PaymentTypeExtension on PaymentType {

  String name(){
    switch(this){
      case PaymentType.cash: return "Dinheiro";
      case PaymentType.credit_card: return "Cartão de crédito";
      case PaymentType.debit_card: return "Cartão de débito";
      case PaymentType.pix: return "Pix";
    }
  }

  String code(){
    switch(this){
      case PaymentType.cash: return "cash";
      case PaymentType.credit_card: return "credit_card";
      case PaymentType.debit_card: return "debit_card";
      case PaymentType.pix: return "pix";
    }
  }
}

class PaymentTypeBuilder {
  static PaymentType build(String? v){
    switch(v){
      case "cash": return PaymentType.cash;
      case "credit_card": return PaymentType.credit_card;
      case "debit_card": return PaymentType.debit_card;
      case "pix": return PaymentType.pix;
      default: return PaymentType.cash;
    }
  }
}