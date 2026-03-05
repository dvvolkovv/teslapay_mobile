class CardModel {
  const CardModel({
    required this.id,
    required this.last4,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.holderName,
    required this.type,
    required this.isFrozen,
    required this.balance,
    required this.currency,
  });

  final String id;
  final String last4;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String holderName;
  /// 'virtual' | 'physical'
  final String type;
  final bool isFrozen;
  final double balance;
  /// 'EUR' | 'USD'
  final String currency;
}
