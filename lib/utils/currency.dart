/// Formats an integer so'm amount with space-grouped thousands, per the
/// spec's currency display rule (e.g. 345210 → "345 210 so'm").
String formatSom(int amount) {
  final digits = amount.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    final posFromEnd = digits.length - i;
    buffer.write(digits[i]);
    if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(' ');
  }
  return '${amount < 0 ? '-' : ''}$buffer so\'m';
}

/// Formats a quantity, dropping the decimal point when it's a whole number
/// (e.g. 8.0 → "8", 14.4 → "14.4").
String formatQuantity(double value) {
  return value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toStringAsFixed(1);
}
