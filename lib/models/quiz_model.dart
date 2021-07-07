class Quiz{
  String question;
  String answer;
  String choice1;
  String choice2;
  String choice3;
  String choice4;

  Quiz({this.question, this.answer, this.choice1, this.choice2, this.choice3, this.choice4});

  factory Quiz.fromJson(Map<String, dynamic> json){
    return Quiz(
      question: json['question'] as String,
      answer: json['answer'] as String,
      choice1: json['choice1'] as String,
      choice2: json['choice2'] as String,
      choice3: json['choice3'] as String,
      choice4: json['choice4'] as String,
    );
  }
}