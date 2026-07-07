import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ));

class TheoryTopic {
  final String title, content, imagePath;
  TheoryTopic(this.title, this.content, this.imagePath);
}

class TestQuestion {
  final String text;
  final List<String> options;
  final int correct;
  TestQuestion(this.text, this.options, this.correct);
}

final List<TheoryTopic> theoryList = [
  TheoryTopic("Нотный стан", "Нотный стан — это пять горизонтальных линеек, на которых живут ноты. Он нужен чтобы мы знали, какую ноту петь или играть.", "stan.png"),
  TheoryTopic("Скрипичный ключ", "Скрипичный ключ — это музыкальный знак, который ставится в начале нотного стана и определяет расположение всех остальных нот на линейках. Значит если мы видим скрипичный ключ в начале и видим ноту на первой линеечке, мы понимаем что это нота Ми.", "kluch.png"),
  TheoryTopic("Ноты", "Ноты — это специальные значки в виде кружков, которые ставятся на линиях или между линиями нотного стана. Всего у нас 7 нот и каждая имеет свое расположение на нотном стане.", "noti.png"),
  TheoryTopic("Длительности", "Длительность ноты — это время звучания ноты. Основные длительности: целая, половинная, четвертная, восьмая и шестнадцатая. Чем больше деталей у значка, тем короче нота.", "dlitelnosti.png"),
  TheoryTopic("Паузы", "Пауза — это знак, который обозначает тишину в музыке. У каждой паузы есть своя длительность, показывающая, сколько времени нужно молчать.", "pauzi.png"),
  TheoryTopic("Ритм", "Ритм — это чередование длинных и коротких звуков и пауз в музыке. Это как пульс или шаги, которые делают мелодию живой.", "pitm.png"),
];

final List<TestQuestion> quizQuestions = [
  TestQuestion('Сколько линеек в нотном стане?', ['3', '4', '5', '6'], 2),
  TestQuestion('Какая нота пишется на 2-й линейке?', ['До', 'Соль', 'Ми', 'Фа'], 1),
  TestQuestion('Что длится дольше всего?', ['Целая', 'Четвертная', 'Восьмая', 'Половинная'], 0),
  TestQuestion('Что обозначает пауза?', ['Звук', 'Молчание', 'Темп', 'Ритм'], 1),
  TestQuestion('Как называется чередование длительностей?', ['Ритм', 'Гамма', 'Пауза', 'Ключ'], 0),
  TestQuestion('Сколько всего основных нот?', ['5', '6', '7', '8'], 2),
  TestQuestion('Как называется ключ в начале нотного стана?', ['Вилончельный', 'Скрипичный', 'Флейтовый', 'Балалайковый'], 1),
  TestQuestion('Какая нота следует за До?', ['Ми', 'Фа', 'Ре', 'Ля'], 2),
];

String globalUserName = "";
String? savedResult;

class StyledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const StyledButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF673AB7),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: onPressed,
            child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
      );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _ctrl = TextEditingController();
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFCE4EC),
        body: Center(
            child: SingleChildScrollView(
                child: Column(children: [
          const CircleAvatar(radius: 60, backgroundColor: Color(0xFF673AB7), child: Icon(Icons.music_note, size: 80, color: Colors.white)),
          const SizedBox(height: 20),
          const Text("Привет! Как тебя зовут?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF673AB7))),
          Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                  controller: _ctrl,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Твое имя",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      errorText: _error))),
          StyledButton(
              text: "Начать обучение",
              onPressed: () {
                if (_ctrl.text.trim().isEmpty) setState(() => _error = "Введите имя!");
                else { globalUserName = _ctrl.text; Navigator.push(context, MaterialPageRoute(builder: (_) => const MainMenu())); }
              }),
        ]))));
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Музыкальное меню"), backgroundColor: const Color(0xFF673AB7)),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          StyledButton(text: "Выбор темы", onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TopicSelection()))),
          StyledButton(text: "Мои результаты", onPressed: () {
            if (savedResult == null) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Результатов еще нет!")));
            else showDialog(context: context, builder: (_) => AlertDialog(title: const Text("Твои успехи"), content: Text(savedResult!)));
          }),
        ]));
  }
}

class TopicSelection extends StatelessWidget {
  const TopicSelection({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Выбор темы"), backgroundColor: const Color(0xFF673AB7)),
        body: Center(child: StyledButton(text: "Базовая теория", onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TheoryScreen())))));
  }
}

class TheoryScreen extends StatefulWidget {
  const TheoryScreen({super.key});
  @override
  State<TheoryScreen> createState() => _TheoryScreenState();
}

class _TheoryScreenState extends State<TheoryScreen> {
  int _idx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(theoryList[_idx].title), backgroundColor: const Color(0xFF673AB7)),
        body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
          Expanded(child: Card(elevation: 5, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), child: Column(children: [
            Expanded(child: ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(30)), child: Image.asset('assets/images/${theoryList[_idx].imagePath}', fit: BoxFit.contain))),
            Padding(padding: const EdgeInsets.all(20), child: Text(theoryList[_idx].content, style: const TextStyle(fontSize: 18), textAlign: TextAlign.center)),
          ]))),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(icon: const Icon(Icons.arrow_back, size: 40), onPressed: _idx > 0 ? () => setState(() => _idx--) : null),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFA726)), onPressed: () => _idx < theoryList.length - 1 ? setState(() => _idx++) : Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen())), child: Text(_idx == theoryList.length - 1 ? "Тест" : "Далее", style: const TextStyle(fontSize: 18))),
            IconButton(icon: const Icon(Icons.arrow_forward, size: 40), onPressed: _idx < theoryList.length - 1 ? () => setState(() => _idx++) : null),
          ])
        ])));
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _qIdx = 0, _score = 0;
  bool _locked = false;
  int? _selectedIdx;

  void _answer(int i) {
    if (_locked) return;
    setState(() { _locked = true; _selectedIdx = i; if (i == quizQuestions[_qIdx].correct) _score++; });
    Future.delayed(const Duration(seconds: 1), () {
      if (_qIdx < quizQuestions.length - 1) setState(() { _qIdx++; _locked = false; _selectedIdx = null; });
      else {
        savedResult = "$globalUserName: $_score из ${quizQuestions.length}";
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResultScreen(score: _score, total: quizQuestions.length)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Вопрос ${_qIdx + 1}"), backgroundColor: const Color(0xFF673AB7)), body: Padding(padding: const EdgeInsets.all(20), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(quizQuestions[_qIdx].text, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
      const SizedBox(height: 30),
      ...List.generate(4, (i) => Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: SizedBox(width: double.infinity, height: 50, child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: _locked ? (i == quizQuestions[_qIdx].correct ? Colors.green : (_selectedIdx == i ? Colors.red : Colors.grey)) : const Color(0xFF64B5F6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        onPressed: () => _answer(i), child: Text(quizQuestions[_qIdx].options[i], style: const TextStyle(fontSize: 16))))))
    ])));
  }
}

class ResultScreen extends StatelessWidget {
  final int score, total;
  const ResultScreen({super.key, required this.score, required this.total});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.star, color: Colors.amber, size: 120),
      Text("Молодец, $globalUserName!", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      Text("Твой результат: $score из $total", style: const TextStyle(fontSize: 20)),
      const SizedBox(height: 30),
      StyledButton(text: "На главную", onPressed: () => Navigator.popUntil(context, (r) => r.isFirst))
    ])));
  }
}


