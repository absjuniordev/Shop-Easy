class AuthException implements Exception {
  final String key;
  static const Map<String, String> erros = {
    'EMAIL_EXISTS': 'E-mail já cadastrado',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Acesso bloqueado temporariamente. Tente mais tarde',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado',
    'INVALID_LOGIN_CREDENTIALS': 'Senha informada não confere',
    'USER_DISABLED': 'A conta do usuario foi desabilitada',
  };
  AuthException({
    required this.key,
  });

  @override
  String toString() {
    return erros[key] ?? 'Ocorreu um erro no processo de qautenticação';
  }
}
