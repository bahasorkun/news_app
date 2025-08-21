import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/app_appbar.dart';
import 'package:news_app/core/widgets/app_drawer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const AppAppbar(title: 'Hakkında'),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          // Uygulama başlığı + versiyon kartı
          _InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Haber Uygulaması',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Versiyon: 1.0.0',
                  style: TextStyle(
                    fontSize: 18,
                    color: cs.onSurface.withValues(alpha: .8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Uygulama Hakkında
          _InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Uygulama Hakkında',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'NewsApp, size kapsamlı bilgiye tek bir yerden erişim imkânı sunar. '
                  'Güncel haberler, futbol liglerinin son durumu, anlık finans piyasaları verileri, '
                  'detaylı hava durumu bilgileri ve nöbetçi eczaneler gibi birçok farklı kategoriye '
                  'kolayca ulaşabilirsiniz. İhtiyacınız olan her bilgiye hızlı ve pratik erişim için '
                  'tasarlanmıştır.',
                  style: TextStyle(fontSize: 18, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Geliştirici
          _InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Geliştirici',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
                  ),
                ),
                SizedBox(height: 12),
                Text('Baha Sorkun', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),

          const SizedBox(height: 28),
          Center(
            child: Text(
              '© 2025 NewsApp. Tüm Hakları Saklıdır.',
              textAlign: TextAlign.center,
              style: TextStyle(color: cs.onSurface.withValues(alpha: .6)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Tekrarlayan kart görünümü için basit bir yardımcı widget
class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Card(
      elevation: 6, // daha belirgin gölge
      shadowColor: cs.primary.withValues(alpha: .18),
      surfaceTintColor: cs.primary.withValues(alpha: .06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: cs.outline.withValues(alpha: .25), // hafif çerçeve
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: child,
      ),
    );
  }
}
