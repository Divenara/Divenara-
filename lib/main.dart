import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const DivenaraApp());
}

class DivenaraApp extends StatefulWidget {
  const DivenaraApp({super.key});

  @override
  State<DivenaraApp> createState() => _DivenaraAppState();
}

class _DivenaraAppState extends State<DivenaraApp> {
  String language = 'English';

  final Map<String, Map<String, String>> translations = {
    'English': {
      'home': 'Home',
      'transactions': 'Transactions',
      'budget': 'Budget',
      'more': 'More',
      'settings': 'Settings',
      'changeLanguage': 'Change Language',
      'totalBalance': 'Total Balance',
      'income': 'Income',
      'expenses': 'Expenses',
      'quickActions': 'Quick Actions',
      'recentTransactions': 'Recent Transactions',
      'addIncome': 'Add Income',
      'addExpense': 'Add Expense',
      'description': 'Description',
      'amount': 'Amount',
      'account': 'Account',
      'saveIncome': 'Save Income',
      'saveExpense': 'Save Expense',
      'noTransactions': 'No transactions yet',
      'accounts': 'Accounts',
      'cash': 'Cash',
      'bank': 'Bank',
      'mpesa': 'M-Pesa',
      'airtelMoney': 'Airtel Money',
      'other': 'Other',
      'welcome': 'Welcome to Divenara',
      'languageSaved': 'Language saved',
      'delete': 'Delete',
    },
    'Swahili': {
      'home': 'Nyumbani',
      'transactions': 'Miamala',
      'budget': 'Bajeti',
      'more': 'Zaidi',
      'settings': 'Mipangilio',
      'changeLanguage': 'Badilisha Lugha',
      'totalBalance': 'Salio Jumla',
      'income': 'Mapato',
      'expenses': 'Matumizi',
      'quickActions': 'Vitendo vya Haraka',
      'recentTransactions': 'Miamala ya Karibuni',
      'addIncome': 'Ongeza Mapato',
      'addExpense': 'Ongeza Matumizi',
      'description': 'Maelezo',
      'amount': 'Kiasi',
      'account': 'Akaunti',
      'saveIncome': 'Hifadhi Mapato',
      'saveExpense': 'Hifadhi Matumizi',
      'noTransactions': 'Hakuna miamala bado',
      'accounts': 'Akaunti',
      'cash': 'Fedha Taslimu',
      'bank': 'Benki',
      'mpesa': 'M-Pesa',
      'airtelMoney': 'Airtel Money',
      'other': 'Nyingine',
      'welcome': 'Karibu Divenara',
      'languageSaved': 'Lugha imehifadhiwa',
      'delete': 'Futa',
    },
    'French': {
      'home': 'Accueil',
      'transactions': 'Transactions',
      'budget': 'Budget',
      'more': 'Plus',
      'settings': 'Paramètres',
      'changeLanguage': 'Changer de langue',
      'totalBalance': 'Solde total',
      'income': 'Revenus',
      'expenses': 'Dépenses',
      'quickActions': 'Actions rapides',
      'recentTransactions': 'Transactions récentes',
      'addIncome': 'Ajouter un revenu',
      'addExpense': 'Ajouter une dépense',
      'description': 'Description',
      'amount': 'Montant',
      'account': 'Compte',
      'saveIncome': 'Enregistrer le revenu',
      'saveExpense': 'Enregistrer la dépense',
      'noTransactions': 'Aucune transaction',
      'accounts': 'Comptes',
      'cash': 'Espèces',
      'bank': 'Banque',
      'mpesa': 'M-Pesa',
      'airtelMoney': 'Airtel Money',
      'other': 'Autre',
      'welcome': 'Bienvenue sur Divenara',
      'languageSaved': 'Langue enregistrée',
      'delete': 'Supprimer',
    },
    'Italian': {
      'home': 'Home',
      'transactions': 'Transazioni',
      'budget': 'Budget',
      'more': 'Altro',
      'settings': 'Impostazioni',
      'changeLanguage': 'Cambia lingua',
      'totalBalance': 'Saldo totale',
      'income': 'Entrate',
      'expenses': 'Spese',
      'quickActions': 'Azioni rapide',
      'recentTransactions': 'Transazioni recenti',
      'addIncome': 'Aggiungi entrata',
      'addExpense': 'Aggiungi spesa',
      'description': 'Descrizione',
      'amount': 'Importo',
      'account': 'Conto',
      'saveIncome': 'Salva entrata',
      'saveExpense': 'Salva spesa',
      'noTransactions': 'Nessuna transazione',
      'accounts': 'Conti',
      'cash': 'Contanti',
      'bank': 'Banca',
      'mpesa': 'M-Pesa',
      'airtelMoney': 'Airtel Money',
      'other': 'Altro',
      'welcome': 'Benvenuto su Divenara',
      'languageSaved': 'Lingua salvata',
      'delete': 'Elimina',
    },
    'German': {
      'home': 'Startseite',
      'transactions': 'Transaktionen',
      'budget': 'Budget',
      'more': 'Mehr',
      'settings': 'Einstellungen',
      'changeLanguage': 'Sprache ändern',
      'totalBalance': 'Gesamtsaldo',
      'income': 'Einnahmen',
      'expenses': 'Ausgaben',
      'quickActions': 'Schnellaktionen',
      'recentTransactions': 'Letzte Transaktionen',
      'addIncome': 'Einnahme hinzufügen',
      'addExpense': 'Ausgabe hinzufügen',
      'description': 'Beschreibung',
      'amount': 'Betrag',
      'account': 'Konto',
      'saveIncome': 'Einnahme speichern',
      'saveExpense': 'Ausgabe speichern',
      'noTransactions': 'Noch keine Transaktionen',
      'accounts': 'Konten',
      'cash': 'Bargeld',
      'bank': 'Bank',
      'mpesa': 'M-Pesa',
      'airtelMoney': 'Airtel Money',
      'other': 'Andere',
      'welcome': 'Willkommen bei Divenara',
      'languageSaved': 'Sprache gespeichert',
      'delete': 'Löschen',
    },
  };

  String t(String key) {
    return translations[language]?[key] ?? translations['English']![key]!;
  }

  @override
  void initState() {
    super.initState();
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString('language');

    if (savedLanguage != null &&
        translations.containsKey(savedLanguage)) {
      setState(() {
        language = savedLanguage;
      });
    }
  }

  Future<void> changeLanguage(String newLanguage) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', newLanguage);

    setState(() {
      language = newLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Divenara',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: HomePage(
        language: language,
        translate: t,
        onLanguageChanged: changeLanguage,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String language;
  final String Function(String) translate;
  final Future<void> Function(String) onLanguageChanged;

  const HomePage({
    super.key,
    required this.language,
    required this.translate,
    required this.onLanguageChanged,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Map<String, dynamic>> transactions = [];

  Map<String, double> accounts = {
    'Cash': 0,
    'Bank': 0,
    'M-Pesa': 0,
    'Airtel Money': 0,
    'Other': 0,
  };

  double get income => transactions
      .where((t) => t['type'] == 'income')
      .fold(
        0.0,
        (sum, t) => sum + (t['amount'] as num).toDouble(),
      );

  double get expenses => transactions
      .where((t) => t['type'] == 'expense')
      .fold(
        0.0,
        (sum, t) => sum + (t['amount'] as num).toDouble(),
      );

  double get balance => accounts.values.fold(
        0.0,
        (sum, amount) => sum + amount,
      );

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final savedTransactions = prefs.getString('transactions');
    final savedAccounts = prefs.getString('accounts');

    if (savedTransactions != null) {
      final decoded = jsonDecode(savedTransactions);

      transactions = List<Map<String, dynamic>>.from(
        decoded.map(
          (item) => Map<String, dynamic>.from(item),
        ),
      );
    }

    if (savedAccounts != null) {
      final decodedAccounts = jsonDecode(savedAccounts);

      accounts = Map<String, double>.from(
        decodedAccounts.map(
          (key, value) => MapEntry(
            key.toString(),
            (value as num).toDouble(),
          ),
        ),
      );
    }

    setState(() {});
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'transactions',
      jsonEncode(transactions),
    );

    await prefs.setString(
      'accounts',
      jsonEncode(accounts),
    );
  }

  String money(double amount) {
    return 'TZS ${amount.toStringAsFixed(0)}';
  }

  Future<void> addTransaction(bool isIncome) async {
    final descriptionController = TextEditingController();
    final amountController = TextEditingController();

    String selectedAccount = 'Cash';

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom:
                    MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isIncome
                          ? widget.translate('addIncome')
                          : widget.translate('addExpense'),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText:
                            widget.translate('description'),
                        border: const OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: amountController,
                      keyboardType:
                          const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: widget.translate('amount'),
                        prefixText: 'TZS ',
                        border: const OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    DropdownButtonFormField<String>(
                      value: selectedAccount,
                      decoration: InputDecoration(
                        labelText: widget.translate('account'),
                        border: const OutlineInputBorder(),
                      ),
                      items: accounts.keys.map((account) {
                        return DropdownMenuItem(
                          value: account,
                          child: Text(account),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          modalSetState(() {
                            selectedAccount = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final description =
                              descriptionController.text.trim();

                          final amount = double.tryParse(
                            amountController.text.trim(),
                          );

                          if (description.isEmpty ||
                              amount == null ||
                              amount <= 0) {
                            return;
                          }

                          if (!isIncome &&
                              accounts[selectedAccount]! < amount) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Insufficient account balance',
                                  ),
                                ),
                              );
                            }
                            return;
                          }

                          setState(() {
                            transactions.insert(0, {
                              'description': description,
                              'amount': amount,
                              'type': isIncome
                                  ? 'income'
                                  : 'expense',
                              'account': selectedAccount,
                              'date': DateTime.now()
                                  .toIso8601String(),
                            });

                            if (isIncome) {
                              accounts[selectedAccount] =
                                  accounts[selectedAccount]! +
                                      amount;
                            } else {
                              accounts[selectedAccount] =
                                  accounts[selectedAccount]! -
                                      amount;
                            }
                          });

                          await saveData();

                          if (sheetContext.mounted) {
                            Navigator.pop(sheetContext);
                          }
                        },
                        child: Text(
                          isIncome
                              ? widget.translate('saveIncome')
                              : widget.translate('saveExpense'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> deleteTransaction(
    Map<String, dynamic> transaction,
  ) async {
    final amount =
        (transaction['amount'] as num).toDouble();

    final account = transaction['account'] as String;

    setState(() {
      transactions.remove(transaction);

      if (transaction['type'] == 'income') {
        accounts[account] =
            accounts[account]! - amount;
      } else {
        accounts[account] =
            accounts[account]! + amount;
      }
    });

    await saveData();
  }

  IconData accountIcon(String account) {
    switch (account) {
      case 'Cash':
        return Icons.payments;
      case 'Bank':
        return Icons.account_balance;
      case 'M-Pesa':
        return Icons.phone_android;
      case 'Airtel Money':
        return Icons.phone_android;
      default:
        return Icons.account_balance_wallet;
    }
  }

  Widget dashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.translate('welcome'),
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.translate('totalBalance'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    money(balance),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          widget.translate('income'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          money(income),
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          widget.translate('expenses'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          money(expenses),
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            widget.translate('accounts'),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ...accounts.entries.map(
            (entry) => Card(
              child: ListTile(
                leading:
                    Icon(accountIcon(entry.key)),
                title: Text(entry.key),
                trailing: Text(
                  money(entry.value),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            widget.translate('quickActions'),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () =>
                      addTransaction(true),
                  icon: const Icon(Icons.add),
                  label: Text(
                    widget.translate('income'),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () =>
                      addTransaction(false),
                  icon: const Icon(Icons.remove),
                  label: Text(
                    widget.translate('expenses'),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Text(
            widget.translate('recentTransactions'),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          if (transactions.isEmpty)
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    widget.translate(
                      'noTransactions',
                    ),
                  ),
                ),
              ),
            ),

          ...transactions.take(5).map(
            (transaction) => Card(
              child: ListTile(
                leading: Icon(
                  transaction['type'] == 'income'
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                ),
                title: Text(
                  transaction['description'],
                ),
                subtitle: Text(
                  transaction['account'] ?? 'Cash',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${transaction['type'] == 'income' ? '+' : '-'} '
                      '${money((transaction['amount'] as num).toDouble())}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                      ),
                      onPressed: () =>
                          deleteTransaction(
                        transaction,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget transactionsPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          widget.translate('transactions'),
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        if (transactions.isEmpty)
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  widget.translate(
                    'noTransactions',
                  ),
                ),
              ),
            ),
          ),

        ...transactions.map(
          (transaction) => Card(
            child: ListTile(
              leading: Icon(
                transaction['type'] == 'income'
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
              ),
              title: Text(
                transaction['description'],
              ),
              subtitle: Text(
                '${transaction['account'] ?? 'Cash'} • '
                '${transaction['date'].toString().substring(0, 10)}',
              ),
              trailing: Text(
                '${transaction['type'] == 'income' ? '+' : '-'} '
                '${money((transaction['amount'] as num).toDouble())}',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget budgetPage() {
    return Center(
      child: Text(
        '${widget.translate('budget')}\nComing soon',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22),
      ),
    );
  }

  Widget settingsPage() {
    final languages = [
      'English',
      'Swahili',
      'French',
      'Italian',
      'German',
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          widget.translate('settings'),
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Card(
          child: ListTile(
            leading: const Icon(Icons.language),
            title: Text(
              widget.translate('changeLanguage'),
            ),
            subtitle: Text(widget.language),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SafeArea(
                    child: ListView(
                      shrinkWrap: true,
                      children: languages.map(
                        (language) {
                          return RadioListTile<String>(
                            title: Text(language),
                            value: language,
                            groupValue:
                                widget.language,
                            onChanged: (value) async {
                              if (value != null) {
                                await widget
                                    .onLanguageChanged(
                                  value,
                                );

                                if (context.mounted) {
                                  Navigator.pop(
                                    context,
                                  );
                                }
                              }
                            },
                          );
                        },
                      ).toList(),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      dashboard(),
      transactionsPage(),
      budgetPage(),
      settingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Divenara'),
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon:
                const Icon(Icons.home),
            label: widget.translate('home'),
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.receipt_long_outlined,
            ),
            selectedIcon: const Icon(
              Icons.receipt_long,
            ),
            label:
                widget.translate('transactions'),
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.account_balance_wallet_outlined,
            ),
            selectedIcon: const Icon(
              Icons.account_balance_wallet,
            ),
            label: widget.translate('budget'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon:
                const Icon(Icons.settings),
            label: widget.translate('settings'),
          ),
        ],
      ),
    );
  }
}
