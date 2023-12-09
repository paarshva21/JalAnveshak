class RetirementAdviceModel {
  final int? investment;
  final String? plan;
  final int? returns;
  final int? time;

  RetirementAdviceModel({
    this.investment,
    this.plan,
    this.returns,
    this.time,
  });

  RetirementAdviceModel.fromJson(Map<String, dynamic> json)
      : investment = json['investment'] as int?,
        plan = json['plan'] as String?,
        returns = json['returns'] as int?,
        time = json['time'] as int?;

  Map<String, dynamic> toJson() => {
    'investment' : investment,
    'plan' : plan,
    'returns' : returns,
    'time' : time
  };
}