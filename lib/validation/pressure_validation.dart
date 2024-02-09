class PressureValidation {
  String? validateNumber(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Informe um valor válido';
    }
    return null;
  }
}
