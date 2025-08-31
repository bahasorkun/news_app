import 'package:flutter/material.dart';
import 'package:news_app/features/pharmacy/data/models/pharmacy_model.dart';

class PharmacyCard extends StatelessWidget {
  final PharmacyModel item;
  final VoidCallback onCall;
  final VoidCallback onShowOnMap;

  const PharmacyCard({
    super.key,
    required this.item,
    required this.onCall,
    required this.onShowOnMap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 6,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Theme(
          data: theme.copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            title: Text(
              item.name.toUpperCase(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            childrenPadding: EdgeInsets.fromLTRB(12, 0, 12, 16),
            children: [
              SizedBox(height: 4),
              _Row("İlçe:", item.dist),
              SizedBox(height: 4),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  Text("Telefon Numarası:", style: theme.textTheme.bodyMedium),
                  if (item.phone.trim().isNotEmpty)
                    InkWell(
                      onTap: onCall,
                      child: Text(
                        item.phone,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.blueGrey.shade400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  else
                    Text("-", style: theme.textTheme.bodyMedium),
                ],
              ),
              if (item.address.trim().isNotEmpty) ...[
                SizedBox(height: 12),
                Text("Adres:", style: theme.textTheme.bodyMedium),
                SizedBox(height: 4),
                Text(
                  item.address,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.blueGrey.shade400,
                  ),
                ),
              ],
              SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: onShowOnMap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF8E8E),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  ),
                  child: Text(
                    "HARİTADA GÖSTER",
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  const _Row(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          SizedBox(width: 6),
          Flexible(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.blueGrey.shade400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
