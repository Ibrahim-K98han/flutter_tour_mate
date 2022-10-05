class ExpenceModel{
  String? expenseId;
  String? tourId;
  String? expenseName;
  int? expenseDate;
  double? expenseAmount;

  ExpenceModel(
      {this.expenseId,
      this.tourId,
      this.expenseName,
      this.expenseDate,
      this.expenseAmount
      });
  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'expenseId' : expenseId,
      'tourId' : tourId,
      'expenseName' : expenseName,
      'expenseDate' : expenseDate,
      'expenseAmount' : expenseAmount,
    };
    return map;
  }

  ExpenceModel.fromMap(Map<String, dynamic> map){
    tourId = map['tourId'];
    expenseId = map['expenseId'];
    expenseName = map['expenseName'];
    expenseDate = map['expenseDate'];
    expenseAmount = map['expenseAmount'];
  }

  @override
  String toString() {
    return 'ExpenceModel{expenseId: $expenseId, tourId: $tourId, expenseName: $expenseName, expenseDate: $expenseDate, expenseAmount: $expenseAmount}';
  }
}