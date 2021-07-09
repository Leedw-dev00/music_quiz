class Rank{
  String user_id;
  String point;

  Rank({this.user_id, this.point});

  factory Rank.fromJson(Map<String, dynamic> json){
    return Rank(
      user_id: json['user_id'] as String,
      point: json['point'] as String,
    );
  }
}