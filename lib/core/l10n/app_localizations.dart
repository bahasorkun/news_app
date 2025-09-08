import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  final Locale locale;
  const AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocDelegate();

  static const Map<String, Map<String, String>> _values = {
    'tr': {
      'settings': 'Ayarlar',
      'darkTheme': 'Koyu Tema',
      'language': 'Dil',
      'turkish': 'Türkçe',
      'english': 'İngilizce',
      'home': 'Ana Sayfa',
      'about': 'Hakkında',
      'login': 'Giriş Yap',
      'finance': 'Finans',
      'football': 'Futbol',
      'news': 'Haberler',
      'weather': 'Hava',
      'pharmacy': 'Eczane',
      'financeMarkets': 'Finans Piyasaları',
      'bist100': 'BIST 100 Endeksi',
      'results': 'Sonuçlar',
      'table': 'Puan Durumu',
      'goalKings': 'Gol Krallığı',
      'selectLeague': 'Lig seçiniz',
      'noLeagues': 'Lig bulunamadı',
      'retry': 'Tekrar Dene',
      'error': 'Hata',
      'noResults': 'Sonuç bulunamadı',
      'noTable': 'Puan durumu yok',
      'noGoalKings': 'Gol krallığı verisi yok',
      'exchangeRates': 'Döviz Kurları',
      'buy': 'Alış',
      'sell': 'Satış',
      'showAll': 'Tümünü Göster >>',
      'showLess': 'Daha Az Göster <<',
      'preciousMetals': 'Kıymetli Madenler',
      'gramGold': 'Gram Altın',
      'ounceGold': 'ONS Altın',
      'silver': 'Gümüş',
      'preciousMetalsError': 'Kıymetli maden verileri alınamadı',
      'commodityMarket': 'Emtia Piyasası',
      'commodityError': 'Emtia verileri alınamadı',
      'noCommodities': 'Gösterilecek emtia bulunamadı',
      'currencyDataError': 'Döviz verisi alınamadı',
      'converter': 'Döviz Dönüştürücü',
      'converterSubtitle': 'Para Birimi Dönüştürücü',
      'amount': 'Miktar',
      'convert': 'DÖNÜŞTÜR',
      'convertError': 'Döviz dönüşümü başarısız',
      'onCallPharmacies': 'Nöbetçi Eczaneler',
      'citySelection': 'İl Seçimi *',
      'selectCity': 'Bir il seçin',
      'districtSelection': 'İlçe Seçimi',
      'selectCityFirst': 'Önce il seçin',
      'selectDistrict': 'Bir ilçe seçin',
      'search': 'SORGULA',
      'districtLabel': 'İlçe:',
      'phoneNumber': 'Telefon Numarası:',
      'address': 'Adres:',
      'showOnMap': 'HARİTADA GÖSTER',
      'mapOpenFailed': 'Harita açılamadı',
      'callFailed': 'Arama Başlatılamadı',
      'pharmacyQuery': 'Nöbetçi Eczane Sorgulama',
      'noRecords': 'Kayıt Bulunamadı',
      'anErrorOccurred': 'Bir hata oluştu',
      'enterCity': 'Şehir adını giriniz',
      'weatherEmpty': 'Hava durumu verisi alınamadı veya boş geldi.',
      'weatherError': 'Hava durumu alınamadı',
      'humidity': 'Nem',
      'max': 'Max',
      'min': 'Min',
      'newsError': 'Haberler alınamadı',
      'noNews': 'Hiç haber yok',
      'newsDetail': 'Haber Detayı',
      'bistError': 'BIST verisi alınamadı',
      'crypto': 'Kripto Paralar',
      'cryptoError': 'Kripto verileri alınamadı',
      'noCrypto': 'Gösterilecek kripto bulunamadı',
    },
    'en': {
      'settings': 'Settings',
      'darkTheme': 'Dark Theme',
      'language': 'Language',
      'turkish': 'Turkish',
      'english': 'English',
      'home': 'Home',
      'about': 'About',
      'login': 'Sign In',
      'finance': 'Finance',
      'football': 'Football',
      'news': 'News',
      'weather': 'Weather',
      'pharmacy': 'Pharmacy',
      'financeMarkets': 'Financial Markets',
      'bist100': 'BIST 100 Index',
      'results': 'Results',
      'table': 'Standings',
      'goalKings': 'Top Scorers',
      'selectLeague': 'Select a league',
      'noLeagues': 'No leagues found',
      'retry': 'Retry',
      'error': 'Error',
      'noResults': 'No results',
      'noTable': 'No standings',
      'noGoalKings': 'No top scorers',
      'exchangeRates': 'Exchange Rates',
      'buy': 'Buy',
      'sell': 'Sell',
      'showAll': 'Show All >>',
      'showLess': 'Show Less <<',
      'preciousMetals': 'Precious Metals',
      'gramGold': 'Gram Gold',
      'ounceGold': 'Ounce Gold',
      'silver': 'Silver',
      'preciousMetalsError': 'Failed to fetch precious metals',
      'commodityMarket': 'Commodity Market',
      'commodityError': 'Failed to fetch commodities',
      'noCommodities': 'No commodities to show',
      'currencyDataError': 'Failed to fetch currency rates',
      'converter': 'Currency Converter',
      'converterSubtitle': 'Currency Converter',
      'amount': 'Amount',
      'convert': 'CONVERT',
      'convertError': 'Conversion failed',
      'onCallPharmacies': 'On-call Pharmacies',
      'citySelection': 'City Selection *',
      'selectCity': 'Select a city',
      'districtSelection': 'District Selection',
      'selectCityFirst': 'Select city first',
      'selectDistrict': 'Select a district',
      'search': 'SEARCH',
      'districtLabel': 'District:',
      'phoneNumber': 'Phone Number:',
      'address': 'Address:',
      'showOnMap': 'SHOW ON MAP',
      'mapOpenFailed': 'Could not open map',
      'callFailed': 'Could not start call',
      'pharmacyQuery': 'On-call Pharmacy Query',
      'noRecords': 'No records found',
      'anErrorOccurred': 'An error occurred',
      'enterCity': 'Enter city name',
      'weatherEmpty': 'Weather data not available or empty.',
      'weatherError': 'Failed to fetch weather',
      'humidity': 'Humidity',
      'max': 'Max',
      'min': 'Min',
      'newsError': 'Failed to fetch news',
      'noNews': 'No news available',
      'newsDetail': 'News Detail',
      'bistError': 'Failed to fetch BIST data',
      'crypto': 'Cryptocurrencies',
      'cryptoError': 'Failed to fetch crypto data',
      'noCrypto': 'No cryptocurrencies to show',
    },
  };

  String t(String key) {
    final lang = locale.languageCode;
    return _values[lang]?[key] ?? _values['en']![key] ?? key;
  }
}

class _AppLocDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocDelegate();
  @override
  bool isSupported(Locale locale) =>
      const ['tr', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      SynchronousFuture(AppLocalizations(locale));

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
