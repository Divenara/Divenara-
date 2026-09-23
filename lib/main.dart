import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const DivenaraApp());

const currencies = {
  'TZS': ['Tanzanian Shilling', 1.0],
  'USD': ['US Dollar', 0.00039],
  'EUR': ['Euro', 0.00033],
  'GBP': ['British Pound', 0.00029],
  'KES': ['Kenyan Shilling', 0.060],
  'UGX': ['Ugandan Shilling', 1.44],
  'NGN': ['Nigerian Naira', 0.60],
  'ZAR': ['South African Rand', 0.0070],
  'INR': ['Indian Rupee', 0.033],
  'CNY': ['Chinese Yuan', 0.0028],
  'JPY': ['Japanese Yen', 0.057],
  'CAD': ['Canadian Dollar', 0.00053],
  'AUD': ['Australian Dollar', 0.00060],
  'AED': ['UAE Dirham', 0.00143],
  'GHS': ['Ghanaian Cedi', 0.0050],
};

const languages = [
  'English',
  'Swahili',
  'French',
  'Italian',
  'German',
  'Spanish',
  'Portuguese',
  'Arabic',
  'Chinese',
  'Hindi',
  'Russian',
];

final Map<String, Map<String, String>> tr = {
  'English': {
    'home': 'Home',
    'transactions': 'Transactions',
    'budgets': 'Budgets',
    'savings': 'Savings',
    'analytics': 'Analytics',
    'settings': 'Settings',
    'balance': 'Total Balance',
    'income': 'Income',
    'expenses': 'Expenses',
    'addIncome': 'Add Income',
    'addExpense': 'Add Expense',
    'accounts': 'Accounts',
    'changeLanguage': 'Change Language',
    'baseCurrency': 'Base Currency',
    'hideBalance': 'Hide Balances',
    'showBalance': 'Show Balances',
    'pin': 'App PIN Lock',
    'backup': 'Backup & Restore',
    'addAccount': 'Add Account',
    'addBudget': 'Add Budget',
    'addGoal': 'Add Savings Goal',
    'noData': 'No data yet',
  },
  'Swahili': {
    'home': 'Nyumbani',
    'transactions': 'Miamala',
    'budgets': 'Bajeti',
    'savings': 'Akiba',
    'analytics': 'Uchambuzi',
    'settings': 'Mipangilio',
    'balance': 'Salio Jumla',
    'income': 'Mapato',
    'expenses': 'Matumizi',
    'addIncome': 'Ongeza Mapato',
    'addExpense': 'Ongeza Matumizi',
    'accounts': 'Akaunti',
    'changeLanguage': 'Badilisha Lugha',
    'baseCurrency': 'Sarafu Kuu',
    'hideBalance': 'Ficha Salio',
    'showBalance': 'Onyesha Salio',
    'pin': 'PIN ya App',
    'backup': 'Hifadhi na Rejesha',
    'addAccount': 'Ongeza Akaunti',
    'addBudget': 'Ongeza Bajeti',
    'addGoal': 'Ongeza Lengo la Akiba',
    'noData': 'Hakuna data bado',
  },
  'French': {
    'home': 'Accueil',
    'transactions': 'Transactions',
    'budgets': 'Budgets',
    'savings': 'Épargne',
    'analytics': 'Analyses',
    'settings': 'Paramètres',
    'balance': 'Solde Total',
    'income': 'Revenus',
    'expenses': 'Dépenses',
    'addIncome': 'Ajouter un revenu',
    'addExpense': 'Ajouter une dépense',
    'accounts': 'Comptes',
    'changeLanguage': 'Changer de langue',
    'baseCurrency': 'Devise principale',
    'hideBalance': 'Masquer les soldes',
    'showBalance': 'Afficher les soldes',
    'pin': 'PIN de l’application',
    'backup': 'Sauvegarde et restauration',
    'addAccount': 'Ajouter un compte',
    'addBudget': 'Ajouter un budget',
    'addGoal': 'Ajouter un objectif',
    'noData': 'Aucune donnée',
  },
  'Italian': {
    'home': 'Home',
    'transactions': 'Transazioni',
    'budgets': 'Budget',
    'savings': 'Risparmi',
    'analytics': 'Analisi',
    'settings': 'Impostazioni',
    'balance': 'Saldo Totale',
    'income': 'Entrate',
    'expenses': 'Spese',
    'addIncome': 'Aggiungi entrata',
    'addExpense': 'Aggiungi spesa',
    'accounts': 'Conti',
    'changeLanguage': 'Cambia lingua',
    'baseCurrency': 'Valuta principale',
    'hideBalance': 'Nascondi saldi',
    'showBalance': 'Mostra saldi',
    'pin': 'PIN dell’app',
    'backup': 'Backup e ripristino',
    'addAccount': 'Aggiungi conto',
    'addBudget': 'Aggiungi budget',
    'addGoal': 'Aggiungi obiettivo',
    'noData': 'Nessun dato',
  },
  'German': {
    'home': 'Startseite',
    'transactions': 'Transaktionen',
    'budgets': 'Budgets',
    'savings': 'Sparen',
    'analytics': 'Analysen',
    'settings': 'Einstellungen',
    'balance': 'Gesamtsaldo',
    'income': 'Einnahmen',
    'expenses': 'Ausgaben',
    'addIncome': 'Einnahmen hinzufügen',
    'addExpense': 'Ausgabe hinzufügen',
    'accounts': 'Konten',
    'changeLanguage': 'Sprache ändern',
    'baseCurrency': 'Basiswährung',
    'hideBalance': 'Salden ausblenden',
    'showBalance': 'Salden anzeigen',
    'pin': 'App-PIN',
    'backup': 'Sichern und Wiederherstellen',
    'addAccount': 'Konto hinzufügen',
    'addBudget': 'Budget hinzufügen',
    'addGoal': 'Sparziel hinzufügen',
    'noData': 'Noch keine Daten',
  },
};

String money(double n, String currency, bool hidden) {
  if (hidden) return '••••••';
  return '$currency ${n.toStringAsFixed(2)}';
}

class DivenaraApp extends StatefulWidget {
  const DivenaraApp({super.key});

  @override
  State<DivenaraApp> createState() => _DivenaraAppState();
}

class _DivenaraAppState extends State<DivenaraApp> {
  String language = 'English';

  @override
  void initState() {
    super.initState();
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final p = await SharedPreferences.getInstance();
    setState(() => language = p.getString('language') ?? 'English');
  }

  Future<void> setLanguage(String value) async {
    final p = await SharedPreferences.getInstance();
    await p.setString('language', value);
    setState(() => language = value);
  }

  String t(String key) => tr[language]?[key] ?? tr['English']![key] ?? key;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Divenara',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(
        language: language,
        t: t,
        setLanguage: setLanguage,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String language;
  final String Function(String) t;
  final Future<void> Function(String) setLanguage;

  const HomePage({
    super.key,
    required this.language,
    required this.t,
    required this.setLanguage,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  bool loading = true;
  bool hidden = false;
  bool locked = false;
  String base = 'TZS';
  String pin = '';

  List<Map<String, dynamic>> accounts = [];
  List<Map<String, dynamic>> transactions = [];
  List<Map<String, dynamic>> budgets = [];
  List<Map<String, dynamic>> goals = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  String t(String key) => widget.t(key);

  Future<void> loadData() async {
    final p = await SharedPreferences.getInstance();

    final a = p.getString('accounts');
    final tx = p.getString('transactions');
    final b = p.getString('budgets');
    final g = p.getString('goals');

    accounts = a == null
        ? [
            {'name': 'Cash', 'currency': 'TZS', 'balance': 0.0},
            {'name': 'Bank', 'currency': 'TZS', 'balance': 0.0},
            {'name': 'M-Pesa', 'currency': 'TZS', 'balance': 0.0},
            {'name': 'Airtel Money', 'currency': 'TZS', 'balance': 0.0},
          ]
        : List<Map<String, dynamic>>.from(jsonDecode(a));

    transactions =
        tx == null ? [] : List<Map<String, dynamic>>.from(jsonDecode(tx));

    budgets =
        b == null ? [] : List<Map<String, dynamic>>.from(jsonDecode(b));

    goals =
        g == null ? [] : List<Map<String, dynamic>>.from(jsonDecode(g));

    base = p.getString('baseCurrency') ?? 'TZS';
    hidden = p.getBool('hidden') ?? false;
    pin = p.getString('pin') ?? '';

    setState(() {
      loading = false;
      locked = pin.isNotEmpty;
    });
  }

  Future<void> save() async {
    final p = await SharedPreferences.getInstance();
    await p.setString('accounts', jsonEncode(accounts));
    await p.setString('transactions', jsonEncode(transactions));
    await p.setString('budgets', jsonEncode(budgets));
    await p.setString('goals', jsonEncode(goals));
    await p.setString('baseCurrency', base);
    await p.setBool('hidden', hidden);
    await p.setString('pin', pin);
  }

  double rate(String from) {
    final r = currencies[from]?[1] as double? ?? 1;
    final baseRate = currencies[base]?[1] as double? ?? 1;
    return r / baseRate;
  }

  double converted(double amount, String currency) {
    return amount * rate(currency);
  }

  double get totalBalance => accounts.fold(
        0,
        (sum, a) =>
            sum + converted((a['balance'] as num).toDouble(), a['currency']),
      );

  double get totalIncome => transactions
      .where((x) => x['type'] == 'income')
      .fold(0, (s, x) => s + converted(
          (x['amount'] as num).toDouble(), x['currency']));

  double get totalExpense => transactions
      .where((x) => x['type'] == 'expense')
      .fold(0, (s, x) => s + converted(
          (x['amount'] as num).toDouble(), x['currency']));

  Future<void> addTransaction(bool income) async {
    final amount = TextEditingController();
    final note = TextEditingController();
    String currency = base;
    String account = accounts.first['name'];

    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setD) => AlertDialog(
          title: Text(income ? t('addIncome') : t('addExpense')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amount,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
              TextField(
                controller: note,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              DropdownButtonFormField<String>(
                initialValue: currency,
                decoration: const InputDecoration(labelText: 'Currency'),
                items: currencies.keys
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setD(() => currency = v!),
              ),
              DropdownButtonFormField<String>(
                initialValue: account,
                decoration: const InputDecoration(labelText: 'Account'),
                items: accounts
                    .map((a) => DropdownMenuItem(
                          value: a['name'].toString(),
                          child: Text(a['name'].toString()),
                        ))
                    .toList(),
                onChanged: (v) => setD(() => account = v!),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final value = double.tryParse(amount.text);
                if (value == null || value <= 0) return;

                final a = accounts.firstWhere((x) => x['name'] == account);
                final accountCurrency = a['currency'].toString();

                final convertedAmount =
                    value * rate(currency) /
                    (rate(accountCurrency) == 0 ? 1 : rate(accountCurrency));

                if (!income &&
                    (a['balance'] as num).toDouble() < convertedAmount) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Insufficient balance')),
                    );
                  }
                  return;
                }

                a['balance'] =
                    (a['balance'] as num).toDouble() +
                    (income ? convertedAmount : -convertedAmount);

                transactions.insert(0, {
                  'type': income ? 'income' : 'expense',
                  'amount': value,
                  'currency': currency,
                  'account': account,
                  'note': note.text.isEmpty ? 'Transaction' : note.text,
                  'date': DateTime.now().toIso8601String(),
                });

                await save();
                if (context.mounted) Navigator.pop(context);
                setState(() {});
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addAccount() async {
    final name = TextEditingController();
    String currency = base;

    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setD) => AlertDialog(
          title: Text(t('addAccount')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Account name'),
              ),
              DropdownButtonFormField<String>(
                initialValue: currency,
                items: currencies.keys
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setD(() => currency = v!),
                decoration: const InputDecoration(labelText: 'Currency'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                if (name.text.trim().isEmpty) return;
                accounts.add({
                  'name': name.text.trim(),
                  'currency': currency,
                  'balance': 0.0,
                });
                await save();
                if (context.mounted) Navigator.pop(context);
                setState(() {});
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addBudget() async {
    final name = TextEditingController();
    final amount = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t('addBudget')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Budget name'),
            ),
            TextField(
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Limit ($base)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final value = double.tryParse(amount.text);
              if (value == null || value <= 0) return;
              budgets.add({
                'name': name.text.isEmpty ? 'Monthly Budget' : name.text,
                'limit': value,
              });
              await save();
              if (context.mounted) Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> addGoal() async {
    final name = TextEditingController();
    final target = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t('addGoal')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Goal name'),
            ),
            TextField(
              controller: target,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Target ($base)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final value = double.tryParse(target.text);
              if (value == null || value <= 0) return;
              goals.add({
                'name': name.text.isEmpty ? 'Savings Goal' : name.text,
                'target': value,
                'saved': 0.0,
              });
              await save();
              if (context.mounted) Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> changePin() async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t('pin')),
        content: TextField(
          controller: controller,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: const InputDecoration(labelText: 'Enter 4–6 digit PIN'),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              pin = '';
              await save();
              if (context.mounted) Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Remove PIN'),
          ),
          FilledButton(
            onPressed: () async {
              if (controller.text.length < 4) return;
              pin = controller.text;
              await save();
              if (context.mounted) Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Set PIN'),
          ),
        ],
      ),
    );
  }

  Future<void> unlock() async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Divenara Locked'),
        content: TextField(
          controller: controller,
          obscureText: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'PIN'),
        ),
        actions: [
          FilledButton(
            onPressed: () {
              if (controller.text == pin) {
                Navigator.pop(context);
                setState(() => locked = false);
              }
            },
            child: const Text('Unlock'),
          ),
        ],
      ),
    );
  }

  Future<void> backupRestore() async {
    final data = jsonEncode({
      'accounts': accounts,
      'transactions': transactions,
      'budgets': budgets,
      'goals': goals,
      'baseCurrency': base,
      'hidden': hidden,
      'pin': pin,
    });

    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t('backup')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Backup copies your Divenara data as JSON. '
              'Keep it somewhere safe.',
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: data));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Backup copied')),
                  );
                }
              },
              icon: const Icon(Icons.copy),
              label: const Text('Copy Backup'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              maxLines: 3,
              decoration:
                  const InputDecoration(labelText: 'Paste backup here'),
            ),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () async {
              try {
                final d = jsonDecode(controller.text);
                accounts =
                    List<Map<String, dynamic>>.from(d['accounts'] ?? []);
                transactions =
                    List<Map<String, dynamic>>.from(d['transactions'] ?? []);
                budgets =
                    List<Map<String, dynamic>>.from(d['budgets'] ?? []);
                goals = List<Map<String, dynamic>>.from(d['goals'] ?? []);
                base = d['baseCurrency'] ?? 'TZS';
                hidden = d['hidden'] ?? false;
                pin = d['pin'] ?? '';
                await save();
                if (context.mounted) Navigator.pop(context);
                setState(() {});
              } catch (_) {}
            },
            child: const Text('Restore'),
          ),
        ],
      ),
    );
  }

  Future<void> settings() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => StatefulBuilder(
        builder: (context, setD) => Padding(
          padding: const EdgeInsets.all(18),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                t('settings'),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(t('changeLanguage')),
                subtitle: Text(widget.language),
                onTap: () async {
                  final selected = await showDialog<String>(
                    context: context,
                    builder: (_) => SimpleDialog(
                      title: Text(t('changeLanguage')),
                      children: languages
                          .map((x) => SimpleDialogOption(
                                onPressed: () => Navigator.pop(context, x),
                                child: Text(x),
                              ))
                          .toList(),
                    ),
                  );
                  if (selected != null) {
                    await widget.setLanguage(selected);
                    if (context.mounted) Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.currency_exchange),
                title: Text(t('baseCurrency')),
                subtitle: Text(base),
                onTap: () async {
                  final selected = await showDialog<String>(
                    context: context,
                    builder: (_) => SimpleDialog(
                      title: Text(t('baseCurrency')),
                      children: currencies.keys
                          .map((x) => SimpleDialogOption(
                                onPressed: () => Navigator.pop(context, x),
                                child: Text(
                                  '$x — ${currencies[x]![0]}',
                                ),
                              ))
                          .toList(),
                    ),
                  );
                  if (selected != null) {
                    base = selected;
                    await save();
                    setD(() {});
                    setState(() {});
                  }
                },
              ),
              SwitchListTile(
                value: hidden,
                title: Text(hidden ? t('showBalance') : t('hideBalance')),
                secondary: const Icon(Icons.visibility),
                onChanged: (v) async {
                  hidden = v;
                  await save();
                  setD(() {});
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: Text(t('pin')),
                subtitle: Text(pin.isEmpty ? 'Not set' : 'Enabled'),
                onTap: changePin,
              ),
              ListTile(
                leading: const Icon(Icons.backup),
                title: Text(t('backup')),
                onTap: backupRestore,
              ),
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Currency conversion uses built-in planning rates. '
                  'Rates are not live market rates and should not be used '
                  'for payment settlement.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget home() {
    return RefreshIndicator(
      onRefresh: loadData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Divenara',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t('balance')),
                  const SizedBox(height: 8),
                  Text(
                    money(totalBalance, base, hidden),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      stat(t('income'), totalIncome, Icons.arrow_downward),
                      stat(t('expenses'), totalExpense, Icons.arrow_upward),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => addTransaction(true),
                  icon: const Icon(Icons.add),
                  label: Text(t('income')),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => addTransaction(false),
                  icon: const Icon(Icons.remove),
                  label: Text(t('expenses')),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          sectionTitle(t('accounts')),
          ...accounts.map(accountTile),
        ],
      ),
    );
  }

  Widget stat(String title, double value, IconData icon) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 5),
        Text(title),
        Text(
          money(value, base, hidden),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget accountTile(Map<String, dynamic> a) {
    final amount = (a['balance'] as num).toDouble();
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.account_balance_wallet)),
        title: Text(a['name']),
        subtitle: Text(a['currency']),
        trailing: Text(
          money(amount, a['currency'], hidden),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget transactionPage() {
    if (transactions.isEmpty) {
      return Center(child: Text(t('noData')));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: transactions.length,
      itemBuilder: (_, i) {
        final x = transactions[i];
        final income = x['type'] == 'income';
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(income ? Icons.add : Icons.remove),
            ),
            title: Text(x['note']),
            subtitle: Text('${x['account']} • ${x['date'].toString().split('T').first}'),
            trailing: Text(
              '${income ? '+' : '-'} ${money((x['amount'] as num).toDouble(), x['currency'], hidden)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: income ? Colors.green : Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget budgetPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(t('budgets'),
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            IconButton(
              onPressed: addBudget,
              icon: const Icon(Icons.add_circle),
            ),
          ],
        ),
        ...budgets.map((b) {
          final limit = (b['limit'] as num).toDouble();
          final spent = totalExpense;
          final progress = (spent / limit).clamp(0.0, 1.0);
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(b['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 8),
                  Text(
                    '${money(spent, base, hidden)} / ${money(limit, base, hidden)}',
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget savingsPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(t('savings'),
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            IconButton(
              onPressed: addGoal,
              icon: const Icon(Icons.add_circle),
            ),
          ],
        ),
        ...goals.map((g) {
          final target = (g['target'] as num).toDouble();
          final saved = (g['saved'] as num).toDouble();
          final progress = (saved / target).clamp(0.0, 1.0);
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(g['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 8),
                  Text(
                    '${money(saved, base, hidden)} / ${money(target, base, hidden)}',
                  ),
                  Text('${(progress * 100).toStringAsFixed(1)}%'),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget analyticsPage() {
    final net = totalIncome - totalExpense;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          t('analytics'),
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 18),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                analyticsRow(t('income'), totalIncome, Icons.trending_up),
                analyticsRow(t('expenses'), totalExpense, Icons.trending_down),
                analyticsRow('Net', net, Icons.account_balance),
                analyticsRow(
                    'Savings rate',
                    totalIncome == 0
                        ? 0
                        : ((net / totalIncome) * 100),
                    Icons.savings),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(18),
            child: Text(
              'Financial analytics help you understand income, '
              'expenses, net cash flow and savings performance.',
            ),
          ),
        ),
      ],
    );
  }

  Widget analyticsRow(String title, double value, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Text(
        title == 'Savings rate'
            ? '${value.toStringAsFixed(1)}%'
            : money(value, base, hidden),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget currentPage() {
    switch (index) {
      case 0:
        return home();
      case 1:
        return transactionPage();
      case 2:
        return budgetPage();
      case 3:
        return savingsPage();
      case 4:
        return analyticsPage();
      default:
        return home();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (locked) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && locked) unlock();
      });
    }

    final labels = [
      t('home'),
      t('transactions'),
      t('budgets'),
      t('savings'),
      t('analytics'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(labels[index]),
        actions: [
          IconButton(
            onPressed: settings,
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: currentPage(),
      floatingActionButton: index == 1
          ? FloatingActionButton(
              onPressed: () => addTransaction(false),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: t('home'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.receipt_long_outlined),
            selectedIcon: const Icon(Icons.receipt_long),
            label: t('transactions'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: const Icon(Icons.account_balance_wallet),
            label: t('budgets'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.savings_outlined),
            selectedIcon: const Icon(Icons.savings),
            label: t('savings'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.analytics_outlined),
            selectedIcon: const Icon(Icons.analytics),
            label: t('analytics'),
          ),
        ],
      ),
    );
  }
}
