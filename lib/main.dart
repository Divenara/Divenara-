import 'package:flutter/material.dart';

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
        scaffoldBackgroundColor: Colors.white,
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

  double balance = 1250000;
  double income = 1800000;
  double expenses = 550000;

  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Salary',
      'category': 'Income',
      'amount': 1800000.0,
      'income': true,
    },
    {
      'title': 'Food',
      'category': 'Food',
      'amount': 120000.0,
      'income': false,
    },
    {
      'title': 'Transport',
      'category': 'Transport',
      'amount': 80000.0,
      'income': false,
    },
    {
      'title': 'Electricity',
      'category': 'Bills',
      'amount': 150000.0,
      'income': false,
    },
    {
      'title': 'Shopping',
      'category': 'Shopping',
      'amount': 200000.0,
      'income': false,
    },
  ];

  String money(double amount) {
    return 'TZS ${amount.toStringAsFixed(0)}';
  }

  void addTransaction(bool isIncome) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();

    showModalBottomSheet(
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
                controller: titleController,
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
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    final amount =
                        double.tryParse(amountController.text) ?? 0;

                    if (titleController.text.trim().isEmpty || amount <= 0) {
                      return;
                    }

                    setState(() {
                      transactions.insert(0, {
                        'title': titleController.text.trim(),
                        'category': isIncome ? 'Income' : 'Expense',
                        'amount': amount,
                        'income': isIncome,
                      });

                      if (isIncome) {
                        income += amount;
                        balance += amount;
                      } else {
                        expenses += amount;
                        balance -= amount;
                      }
                    });

                    Navigator.pop(context);
                  },
                  child: const Text('Save Transaction'),
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
      padding: const EdgeInsets.all(20),
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
          const SizedBox(height: 5),
          const Text(
            'Smarter Money. Brighter Future.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Balance',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  money(balance),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _summaryCard(
                  'Income',
                  income,
                  Icons.arrow_downward,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _summaryCard(
                  'Expenses',
                  expenses,
                  Icons.arrow_upward,
                  Colors.red,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

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
                child: OutlinedButton.icon(
                  onPressed: () => addTransaction(true),
                  icon: const Icon(Icons.add),
                  label: const Text('Income'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => addTransaction(false),
                  icon: const Icon(Icons.remove),
                  label: const Text('Expense'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          const Text(
            'Recent Transactions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ...transactions.take(5).map(
                (transaction) => _transactionTile(transaction),
              ),
        ],
      ),
    );
  }

  Widget _summaryCard(
    String title,
    double amount,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(title),
          const SizedBox(height: 4),
          Text(
            money(amount),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionTile(Map<String, dynamic> transaction) {
    final bool isIncome = transaction['income'];

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor:
            isIncome ? Colors.green.shade100 : Colors.red.shade100,
        child: Icon(
          isIncome ? Icons.arrow_downward : Icons.arrow_upward,
          color: isIncome ? Colors.green : Colors.red,
        ),
      ),
      title: Text(transaction['title']),
      subtitle: Text(transaction['category']),
      trailing: Text(
        '${isIncome ? '+' : '-'}${money(transaction['amount'])}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isIncome ? Colors.green : Colors.red,
        ),
      ),
    );
  }

  Widget transactionsPage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Transactions',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        ...transactions.map(_transactionTile),
      ],
    );
  }

  Widget budgetPage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Budget',
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
                const Text(
                  'Monthly Budget',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const LinearProgressIndicator(value: 0.55),
                const SizedBox(height: 10),
                Text('${money(expenses)} used'),
                const Text('Budget: TZS 1,000,000'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        Card(
          child: ListTile(
            leading: const Icon(Icons.savings),
            title: const Text('Savings Goal'),
            subtitle: const Text('Emergency Fund'),
            trailing: const Text('45%'),
          ),
        ),
      ],
    );
  }

  Widget morePage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'More',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        _moreTile(Icons.account_balance, 'Accounts'),
        _moreTile(Icons.receipt_long, 'Bills'),
        _moreTile(Icons.credit_card, 'Loans & Debt'),
        _moreTile(Icons.trending_up, 'Investments'),
        _moreTile(Icons.family_restroom, 'Family Finance'),
        _moreTile(Icons.groups, 'Chama / VICOBA'),
        _moreTile(Icons.settings, 'Settings'),
      ],
    );
  }

  Widget _moreTile(IconData icon, String title) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.green.shade700),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      dashboard(),
      transactionsPage(),
      budgetPage(),
      morePage(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[selectedIndex]),
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
