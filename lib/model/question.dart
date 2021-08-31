class Question {
  String _questionItself;

  String get questionItself => _questionItself;
  bool _answer;
  Question.make(this._questionItself, this._answer);

  bool get answer => _answer;
}