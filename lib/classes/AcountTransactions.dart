class AccountTransactions {
  final int AccountId;
  final DateTime dateTime;
  final double AmountIn;
  final double AmountOut;
  final double PreviousBalance;
  AccountTransactions({
    required this.AccountId,
    required this.dateTime,
    required this.AmountIn,
    required this.AmountOut,
    required this.PreviousBalance,
  });
}
