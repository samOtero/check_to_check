class TimeLineEntryModel {
  int id;
  String description;
  String date;
  String amount;
  String newTotal;
  bool enabled;
  bool isIncome;

  TimeLineEntryModel(this.id, this.description, this.date, this.amount, this.newTotal, this.enabled, this.isIncome);
}