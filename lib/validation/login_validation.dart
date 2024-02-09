class LoginValidation {
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email é obrigatório';
    }
    if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
      return 'Informe um email válido';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (value.length < 3) {
      return 'A senha precisa de pelo menos 6 caracteres';
    }
    return null;
  }
}
