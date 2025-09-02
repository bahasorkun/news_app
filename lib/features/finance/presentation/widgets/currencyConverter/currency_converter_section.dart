import 'package:flutter/material.dart';
import 'package:news_app/features/finance/data/finance_api.dart';
import 'package:news_app/features/finance/data/models/currency_to_all_model.dart';

class CurrencyConverterSection extends StatefulWidget {
  const CurrencyConverterSection({super.key});

  @override
  State<CurrencyConverterSection> createState() =>
      _CurrencyConverterSectionState();
}

class _CurrencyConverterSectionState extends State<CurrencyConverterSection> {
  final _api = FinanceApi();
  final _amountCtrl = TextEditingController();

  String _base = 'USD';
  String _target = 'TRY';
  List<String> _codes = const [];
  bool _codesLoading = true;
  double? _result;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _prefetch();
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _prefetch() async => _loadCodesForBase(_base);

  Future<void> _loadCodesForBase(String base) async {
    if (!mounted) return;
    setState(() => _codesLoading = true);
    try {
      final resp = await _api.getCurrencyToAll(base: base, amount: 1);
      final set = resp.items
          .map((e) => e.code.toUpperCase())
          .where((e) => e.isNotEmpty)
          .toSet();
      final baseU = base.toUpperCase();
      set.add(baseU); // seçilen base her zaman listede bulunsun
      final codes = set.toList()..sort();
      if (codes.isNotEmpty) {
        final nextBase = baseU;
        String nextTarget = _target.toUpperCase();
        if (!codes.contains(nextTarget) || nextTarget == nextBase) {
          nextTarget = codes.firstWhere(
            (c) => c != nextBase,
            orElse: () => codes.first,
          );
        }
        if (!mounted) return;
        setState(() {
          _codes = codes;
          _base = nextBase;
          _target = nextTarget;
        });
      }
    } finally {
      if (mounted) setState(() => _codesLoading = false);
    }
  }

  Future<void> _convert() async {
    final amt = double.tryParse(_amountCtrl.text.replaceAll(',', '.')) ?? 0.0;
    setState(() {
      _loading = true;
      _error = null;
      _result = null;
    });
    try {
      final resp = await _api.getCurrencyToAll(base: _base, amount: amt);
      final item = resp.items.firstWhere(
        (e) => e.code.toUpperCase() == _target.toUpperCase(),
        orElse: () =>
            const CurrencyToAllItem(code: '', name: '', rate: 0, calculated: 0),
      );
      if (!mounted) return;
      setState(() => _result = item.calculated);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = 'Döviz dönüşümü başarısız');
    } finally {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  void _swap() {
    setState(() {
      final tmp = _base;
      _base = _target;
      _target = tmp;
      _result = null;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Döviz Dönüştürücü',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Para Birimi Dönüştürücü',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _CurrencyButton(
                        value: _base,
                        items: _codes,
                        enabled: !_codesLoading,
                        onChanged: (v) {
                          setState(() {
                            _base = v;
                            if (!_codes.contains(v)) {
                              final list = [..._codes, v];
                              list.sort();
                              _codes = list;
                            }
                          });
                          _loadCodesForBase(v);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    _SwapButton(onTap: _swap),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _CurrencyButton(
                        value: _target,
                        items: _codes,
                        enabled: !_codesLoading,
                        onChanged: (v) => setState(() => _target = v),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _amountCtrl,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Miktar',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _result == null ? '0.00' : _result!.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                ],
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _convert,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.indigo,
                      disabledBackgroundColor: Colors.indigoAccent.shade100,
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _loading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'DÖNÜŞTÜR',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CurrencyButton extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final bool enabled;

  const _CurrencyButton({
    required this.value,
    required this.items,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value)
              ? value
              : (items.isNotEmpty ? items.first : null),
          isExpanded: true,
          hint: const Text('—'),
          items: items
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          onChanged: enabled
              ? (v) {
                  if (v != null) onChanged(v);
                }
              : null,
        ),
      ),
    );
  }
}

class _SwapButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SwapButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(color: Colors.indigo, shape: BoxShape.circle),
        child: const Icon(Icons.swap_horiz, color: Colors.white),
      ),
    );
  }
}
