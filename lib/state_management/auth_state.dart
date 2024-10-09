class AuthState {
  final bool isLoggedIn;
  final bool isLoading;
  AuthState({this.isLoggedIn = false, this.isLoading = false});

  AuthState update({bool? isLoggedIn, bool? isLoading}) => AuthState(
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        isLoading: isLoading ?? this.isLoading,
      );
}
