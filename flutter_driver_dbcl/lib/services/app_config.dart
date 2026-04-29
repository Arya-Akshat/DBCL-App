class AppConfig {
  static const defaultBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://sugarlike-donny-nonevangelically.ngrok-free.dev',
  );
}
