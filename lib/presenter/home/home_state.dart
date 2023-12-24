class HomeState {
  final bool isLoading;
  final bool hasError;
  final String errorMessage;

  HomeState(
      {this.isLoading = false, this.hasError = false, this.errorMessage = ''});

  factory HomeState.loading() => HomeState(isLoading: true);

  factory HomeState.success() => HomeState();

  factory HomeState.error(String errorMessage) =>
      HomeState(hasError: true, errorMessage: errorMessage);
}
