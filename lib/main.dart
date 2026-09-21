import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const DivenaraApp());
}

class DivenaraApp extends StatelessWidget {
  const DivenaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Divenara',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Map<String, dynamic>> transactions = [];

  double get income => transactions
      .where((t) => t['type'] == 'income')
      .fold(0.0, (sum, t) => sum + (t['amount'] as num).toDouble());

  double get expenses => transactions
      .where((t) => t['type'] == 'expense')
      .fold(0.0, (sum, t) => sum + (t['amount'] as num).toDouble());

  double get balance => income - expenses;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('transactions');

    if (saved != null) {
      final decoded = jsonDecode(saved);

      setState(() {
        transactions = List<Map<String, dynamic>>.from(
          decoded.map((item) => Map<String, dynamic>.from(item)),
        );
      });
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('transactions', jsonEncode(transactions));
  }

  String money(double amount) {
    return 'TZS ${amount.toStringAsFixed(0)}';
  }

  Future<void> addTransaction(bool isIncome) async {
    final descriptionController = TextEditingController();
    final amountController = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isIncome ? 'Add Income' : 'Add Expense',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: 'TZS ',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final description =
                        descriptionController.text.trim();
                    final amount =
                        double.tryParse(amountController.text.trim());

                    if (description.isEmpty ||
                        amount == null ||
                        amount <= 0) {
                      return;
                    }

                    setState(() {
                      transactions.insert(0, {
                        'description': description,
                        'amount': amount,
                        'type': isIncome ? 'income' : 'expense',
                        'date': DateTime.now().toIso8601String(),
                      });
                    });

                    await saveData();

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(isIncome ? 'Save Income' : 'Save Expense'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget dashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to Divenara',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Balance'),
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text('Income'),
                        const SizedBox(height: 8),
                        Text(
                          money(income),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text('Expenses'),
                        const SizedBox(height: 8),
                        Text(
                          money(expenses),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
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

          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => addTransaction(true),
                  icon: const Icon(Icons.add),
                  label: const Text('Income'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => addTransaction(false),
                  icon: const Icon(Icons.remove),
                  label: const Text('Expense'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          const Text(
            'Recent Transactions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          if (transactions.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text('No transactions yet'),
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
                    title: Text(transaction['description']),
                    trailing: Text(
                      '${transaction['type'] == 'income' ? '+' : '-'} '
                      '${money((transaction['amount'] as num).toDouble())}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget placeholder(String title) {
    return Center(
      child: Text(
        '$title\nComing soon',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      dashboard(),
      placeholder('Transactions'),
      placeholder('Budget'),
      placeholder('More'),
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
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Budget',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz),
            selectedIcon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
