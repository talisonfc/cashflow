import 'package:cashflow/domain/domain.dart';

class HomeState {
  final bool isLoading;
  final bool hasError;
  final String errorMessage;
  final List<ExpenseEntity> expenses;
  final List<IncomeEntity> incomes;

  HomeState(
      {this.isLoading = false,
      this.hasError = false,
      this.errorMessage = '',
      this.expenses = const [],
      this.incomes = const []});

  factory HomeState.loading() => HomeState(isLoading: true);

  factory HomeState.success(
          {List<ExpenseEntity> expenses = const [],
          List<IncomeEntity> incomes = const []}) =>
      HomeState(expenses: expenses, incomes: incomes);

  factory HomeState.error(String errorMessage) =>
      HomeState(hasError: true, errorMessage: errorMessage);
}
