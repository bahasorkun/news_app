String shortDay(String d) {
  final lower = d.toLowerCase();
  switch (lower) {
    case 'pazartesi':
      return 'Pzt';
    case 'salı':
      return 'Salı';
    case 'çarşamba':
      return 'Çar';
    case 'perşembe':
      return 'Per';
    case 'cuma':
      return 'Cum';
    case 'cumartesi':
      return 'Cmt';
    case 'pazar':
      return 'Paz';
    default:
      return d;
  }
}
