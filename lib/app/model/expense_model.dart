class ExpenseModel {
  String? id;
  DateTime? createdAt;
  String description;
  double value;
  OutputOption outputOption;

  ExpenseModel(
      {this.createdAt,
      this.description = '',
      this.value = 0,
      this.outputOption = OutputOption.local});

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
        createdAt: DateTime.fromMillisecondsSinceEpoch(json["createdAt"]),
        description: json["description"],
        value: json["value"],
        outputOption: OutputOptionBuilder.build(json["outputOption"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "createdAt": createdAt?.millisecondsSinceEpoch ?? null,
      "description": description,
      "value": value,
      "outputOption": outputOption.code()
    };
  }
}

enum OutputOption { local, geral }

extension OutputOptionExtension on OutputOption {
  String name() {
    switch (this) {
      case OutputOption.local:
        return "Caixa diário";
      case OutputOption.geral:
        return "Caixa geral";
    }
  }

  String code() {
    switch (this) {
      case OutputOption.local:
        return "local";
      default:
        return "geral";
    }
  }
}

class OutputOptionBuilder {
  static OutputOption build(String code) {
    switch (code) {
      case "local":
        return OutputOption.local;
      default:
        return OutputOption.geral;
    }
  }
}
