import 'package:flutter/material.dart';
import 'dart:io';
import 'package:news_app/features/pharmacy/data/models/pharmacy_model.dart';
import 'package:news_app/features/pharmacy/data/pharmacy_api.dart';
import 'package:news_app/features/pharmacy/presentation/widgets/pharmacy_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news_app/core/l10n/app_localizations.dart';

class PharmacyResultPage extends StatefulWidget {
  final String city;
  final String district;
  const PharmacyResultPage({
    super.key,
    required this.city,
    required this.district,
  });

  @override
  State<PharmacyResultPage> createState() => _PharmacyResultPageState();
}

class _PharmacyResultPageState extends State<PharmacyResultPage> {
  final _api = PharmacyApi();
  late Future<List<PharmacyModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.getDutyPharmacies(
      city: widget.city,
      district: widget.district,
    );
  }

  //loc alanı "lat,lon" formatındaysa parse eder, değilse null döner
  (double, double)? _parseLatLng(String loc) {
    final parts = loc.split(',');
    if (parts.length == 2) {
      final lat = double.tryParse(parts[0].trim());
      final lng = double.tryParse(parts[1].trim());
      if (lat != null && lng != null) {
        return (lat, lng);
      }
    }
    return null;
  }

  /* 
    *Haritayı açma kısmı loc varsa loc yoksa adress o da yoksa isimle arama yap diyor burada
    ! cihaz ios ise apple maps andorid ise google maps açıcak şekilde düzenledim 
   */
  Future<void> _openMaps({required PharmacyModel m}) async {
    Uri uri;
    final ll = _parseLatLng(m.loc);

    if (ll != null) {
      if (Platform.isIOS) {
        uri = Uri.parse('https://maps.apple.com/?q=${ll.$1},${ll.$2}');
      } else {
        uri = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=${ll.$1},${ll.$2}',
        );
      }
    } else if (m.address.trim().isNotEmpty) {
      final q = Uri.encodeComponent(m.address);
      if (Platform.isIOS) {
        uri = Uri.parse('https://maps.apple.com/?q=$q');
      } else {
        uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$q');
      }
    } else {
      final q = Uri.encodeComponent(m.name);
      if (Platform.isIOS) {
        uri = Uri.parse('https://maps.apple.com/?q=$q');
      } else {
        uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$q');
      }
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      final loc = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.t('mapOpenFailed')),
          //Tekrar Dene butonunu ekledim.
          action: SnackBarAction(
            label: AppLocalizations.of(context).t('retry'),
            onPressed: () async {
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
          ),
        ),
      );
    }
  }

  Future<void> _call(String phone) async {
    if (phone.trim().isEmpty) return;
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context).t('callFailed'))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo.shade300,
        foregroundColor: Colors.white,
        title: Text(loc.t('pharmacy'), style: TextStyle(fontSize: 24)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  label: Text(
                    loc.t('pharmacyQuery'),
                    style: TextStyle(color: Colors.indigo),
                  ),
                  icon: Icon(Icons.arrow_back, color: Colors.indigo),
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(color: Colors.black),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  '${widget.city} - ${widget.district}\n${loc.t('onCallPharmacies')} ',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Color(0xFFFF8E8E),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<List<PharmacyModel>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('${loc.t('anErrorOccurred')}: ${snapshot.error}'),
                      );
                    }
                    final items = snapshot.data ?? [];
                    if (items.isEmpty) {
                      return Center(child: Text(loc.t('noRecords')));
                    }
                    return ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 12);
                      },
                      itemBuilder: (context, index) {
                        final it = items[index];
                        return PharmacyCard(
                          item: it,
                          onCall: () => _call(it.phone),
                          onShowOnMap: () => _openMaps(m: it),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
