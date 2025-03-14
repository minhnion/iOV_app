class KpiPerMonth {
  final int actual;
  final int month;
  final int plan;
  final int year;

  KpiPerMonth({required this.actual, required this.month, required this.plan, required this.year});

  factory KpiPerMonth.fromJson(Map<String, dynamic> json){
    return KpiPerMonth(
        actual : json['actual'],
        month: json['month_no'],
        plan: json['plan'],
        year: json['year_no']
    );
  }
}

class KpiData {
  final int actualDaily;
  final int actualMonthly;
  final int planDaily;
  final int planMonthly;
  final List<KpiPerMonth> kpi3Months;

  KpiData(
      {required this.actualDaily,
        required this.actualMonthly,
        required this.planDaily,
        required this.planMonthly,
        required this.kpi3Months});

  factory KpiData.fromJson(Map<String, dynamic> json){
    return KpiData(
        actualDaily: json['data']['daily']['actual'],
        actualMonthly: json['data']['monthly']['actual'],
        planDaily: json['data']['daily']['plan'],
        planMonthly: json['data']['monthly']['plan'],
        kpi3Months: (json['data']['last_3_months'] as List)
            .map((item) => KpiPerMonth.fromJson(item))
            .toList());
  }
}