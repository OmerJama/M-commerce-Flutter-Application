class FaqModel {
  final String question;
  final String answer;

  FaqModel({
    required this.question,
    required this.answer,
  });

   Map<String, dynamic> toMap(String optionalId){
    return{
      'question' : question,
      'answer' : answer,
    };
  }

  FaqModel.fromMap(Map<String,dynamic> map)
  : question = map['question'] ?? "",
    answer = map['answer'] ?? "";
}
