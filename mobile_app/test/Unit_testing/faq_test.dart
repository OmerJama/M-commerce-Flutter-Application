import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/faq_model.dart';


void main() {
  test("Making sure FAQ added correctly to model", () {
    const question = "How does this work?";
    const answer = "This is the answer";

    final faq = FaqModel(question: question, answer: answer);

    expect(faq.question, question);
    expect(faq.answer, answer);
  });
}