class Transaction {
  const Transaction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.currency,
    required this.date,
    required this.type,
    required this.status,
  });

  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final String currency;
  final DateTime date;
  /// 'send' | 'receive'
  final String type;
  /// 'completed' | 'pending' | 'failed'
  final String status;
}
