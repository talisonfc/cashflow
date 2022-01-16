class MonthReportModel {
  int month;
  double totalIncome;
  double totalExpense;

  MonthReportModel(
      {this.totalIncome = 0, this.totalExpense = 0, required this.month});
}
