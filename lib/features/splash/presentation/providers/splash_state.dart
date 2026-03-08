sealed class SplashState {}

class SplashLoading extends SplashState {}

class SplashReady extends SplashState {
  final String welcomeMessage;
  SplashReady(this.welcomeMessage);
}

class SplashError extends SplashState {}
