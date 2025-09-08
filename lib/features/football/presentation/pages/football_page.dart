import 'package:flutter/material.dart';
import 'package:news_app/core/l10n/app_localizations.dart';
import 'package:news_app/features/football/data/football_api.dart';
import 'package:news_app/features/football/data/models/goal_king_item.dart';
import 'package:news_app/features/football/data/models/league_item.dart';
import 'package:news_app/features/football/data/models/result_item.dart';
import 'package:news_app/features/football/data/models/standing_item.dart';

class FootballPage extends StatefulWidget {
  const FootballPage({super.key});

  @override
  State<FootballPage> createState() => _FootballPageState();
}

class _FootballPageState extends State<FootballPage> {
  final _api = FootballApi();

  // Nullable olarak tut: initState içinde ayarlanır
  Future<List<LeagueItem>>? _leaguesFuture;
  String? _selectedLeagueKey;

  Future<List<ResultItem>>? _resultsFuture;
  Future<List<StandingItem>>? _tableFuture;
  Future<List<GoalKingItem>>? _goalKingsFuture;

  @override
  void initState() {
    super.initState();
    _leaguesFuture = _api.getLeagues();
    _leaguesFuture!
        .then((leagues) {
          if (!mounted || leagues.isEmpty) return;
          final defaultKey = leagues
              .firstWhere(
                (e) => e.key.toLowerCase() == 'super-lig',
                orElse: () => leagues.first,
              )
              .key;
          _setLeague(defaultKey);
        })
        .catchError((_) {}); // Hata UI'da gösterilecek
  }

  void _setLeague(String leagueKey) {
    setState(() {
      _selectedLeagueKey = leagueKey;
      _resultsFuture = _api.getResults(leagueKey);
      _tableFuture = _api.getLeagueTable(leagueKey);
      _goalKingsFuture = _api.getGoalKings(leagueKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          _LeagueSelector(
            leaguesFuture: _leaguesFuture,
            selectedKey: _selectedLeagueKey,
            onChanged: (key) => _setLeague(key),
            onRetry: () {
              setState(() {
                _leaguesFuture = _api.getLeagues();
              });
            },
          ),
          Builder(
            builder: (context) {
              final loc = AppLocalizations.of(context);
              return TabBar(
                tabs: [
                  Tab(text: loc.t('results')),
                  Tab(text: loc.t('table')),
                  Tab(text: loc.t('goalKings')),
                ],
              );
            },
          ),
          Expanded(
            child: TabBarView(
              children: [
                _ResultsTab(future: _resultsFuture),
                _TableTab(future: _tableFuture),
                _GoalKingsTab(future: _goalKingsFuture),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LeagueSelector extends StatelessWidget {
  final Future<List<LeagueItem>>? leaguesFuture;
  final String? selectedKey;
  final ValueChanged<String> onChanged;
  final VoidCallback? onRetry;

  const _LeagueSelector({
    required this.leaguesFuture,
    required this.selectedKey,
    required this.onChanged,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (leaguesFuture == null) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: LinearProgressIndicator(),
      );
    }
    return FutureBuilder<List<LeagueItem>>(
      future: leaguesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: LinearProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          final err = snapshot.error.toString();
          final needsSubscription = err.toLowerCase().contains('subscription');
          final loc = AppLocalizations.of(context);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  needsSubscription
                      ? 'CollectAPI: Football API subscription not found.'
                      : '${loc.t('error')}: $err',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                if (needsSubscription)
                  const Text(
                    'CollectAPI: enable Football API trial/subscription and retry.',
                  ),
                const SizedBox(height: 8),
                if (onRetry != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton.icon(
                      onPressed: onRetry,
                      icon: const Icon(Icons.refresh),
                      label: Text(loc.t('retry')),
                    ),
                  ),
              ],
            ),
          );
        }
        final leagues = snapshot.data ?? [];
        if (leagues.isEmpty) {
          final loc = AppLocalizations.of(context);
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(loc.t('noLeagues')),
          );
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: DropdownButtonFormField<String>(
            value: selectedKey,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).t('selectLeague'),
              border: OutlineInputBorder(),
              isDense: true,
            ),
            items: leagues
                .map(
                  (e) => DropdownMenuItem(value: e.key, child: Text(e.league)),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
        );
      },
    );
  }
}

class _ResultsTab extends StatelessWidget {
  final Future<List<ResultItem>>? future;

  const _ResultsTab({required this.future});

  @override
  Widget build(BuildContext context) {
    if (future == null) {
      return Center(
        child: Text(AppLocalizations.of(context).t('selectLeague')),
      );
    }
    return FutureBuilder<List<ResultItem>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          final loc = AppLocalizations.of(context);
          return Center(child: Text('${loc.t('error')}: ${snapshot.error}'));
        }
        final items = snapshot.data ?? [];
        if (items.isEmpty)
          return Center(
            child: Text(AppLocalizations.of(context).t('noResults')),
          );
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final m = items[i];
            return Card(
              child: ListTile(
                title: Text('${m.home} vs ${m.away}'),
                subtitle: Text(m.date),
                trailing: Text(
                  m.score,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _TableTab extends StatelessWidget {
  final Future<List<StandingItem>>? future;

  const _TableTab({required this.future});

  @override
  Widget build(BuildContext context) {
    if (future == null)
      return Center(
        child: Text(AppLocalizations.of(context).t('selectLeague')),
      );
    return FutureBuilder<List<StandingItem>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          final loc = AppLocalizations.of(context);
          return Center(child: Text('${loc.t('error')}: ${snapshot.error}'));
        }
        final table = snapshot.data ?? [];
        if (table.isEmpty)
          return Center(child: Text(AppLocalizations.of(context).t('noTable')));

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: table.length,
          itemBuilder: (context, i) {
            final t = table[i];
            return Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    SizedBox(width: 24, child: Text(t.rank.toString())),
                    const SizedBox(width: 8),
                    Expanded(child: Text(t.team)),
                    const SizedBox(width: 8),
                    Text('${t.play}O '),
                    Text('${t.win}G '),
                    Text('${t.lose}M  '),
                    Text('${t.point} P'),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _GoalKingsTab extends StatelessWidget {
  final Future<List<GoalKingItem>>? future;

  const _GoalKingsTab({required this.future});

  @override
  Widget build(BuildContext context) {
    if (future == null)
      return Center(
        child: Text(AppLocalizations.of(context).t('selectLeague')),
      );
    return FutureBuilder<List<GoalKingItem>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          final loc = AppLocalizations.of(context);
          return Center(child: Text('${loc.t('error')}: ${snapshot.error}'));
        }
        final list = snapshot.data ?? [];
        if (list.isEmpty) {
          return Center(
            child: Text(AppLocalizations.of(context).t('noGoalKings')),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final p = list[i];
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${i + 1}')),
                title: Text(p.name),
                subtitle: Text('${p.play} maç'),
                trailing: Text('${p.goals} gol'),
              ),
            );
          },
        );
      },
    );
  }
}
