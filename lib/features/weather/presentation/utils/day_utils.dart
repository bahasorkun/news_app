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
    // English
    case 'monday':
      return 'Mon';
    case 'tuesday':
      return 'Tue';
    case 'wednesday':
      return 'Wed';
    case 'thursday':
      return 'Thu';
    case 'friday':
      return 'Fri';
    case 'saturday':
      return 'Sat';
    case 'sunday':
      return 'Sun';
    default:
      return d;
  }
}
