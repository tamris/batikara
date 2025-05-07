import 'package:get/get.dart';

class Question {
  final String question;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

class QuizController extends GetxController {
  // Daftar pertanyaan
  final questions = <Question>[
    Question(
      question: 'Mana Yang Termasuk Motif Batik Tegalan ?',
      options: ['Mega Mendung', 'Poci', 'Tujug Rupa', 'Gringsing'],
      correctIndex: 1,
    ),
    Question(
      question: 'Apa Ciri Khas Batik Tegalan?',
      options: ['Warna Gelap', 'Motif Bunga', 'Motif Poci & Teko', 'Motif Awan'],
      correctIndex: 2,
    ),
    Question(
      question: 'Dari daerah manakah asal Batik Tegalan?',
      options: ['Solo', 'Tegal', 'Pekalongan', 'Cirebon'],
      correctIndex: 1,
    ),
    // Tambahkan soal lainnya di sini
  ];

  // Index soal saat ini
  var currentQuestionIndex = 0.obs;

  // Jawaban yang dipilih
  var selectedAnswerIndex = (-1).obs;

  // Skor saat ini
  var score = 0.obs;

  // Memilih jawaban
  void selectAnswer(int index) {
    selectedAnswerIndex.value = index;
  }

  // Klik tombol Next
  void next() {
    if (selectedAnswerIndex.value == -1) return; // kalau belum jawab
    if (selectedAnswerIndex.value ==
        questions[currentQuestionIndex.value].correctIndex) {
      score++;
    }
    goToNext();
  }

  // Klik tombol Skip
  void skip() {
    goToNext();
  }

  // Fungsi ke soal berikutnya
  void goToNext() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex++;
      selectedAnswerIndex.value = -1;
    } else {
      showResult();
    }
  }

  // Menampilkan hasil akhir
  void showResult() {
    Get.defaultDialog(
      title: "Selesai!",
      middleText: "Skor kamu: ${score.value} dari ${questions.length}",
      textConfirm: "Ulangi",
      onConfirm: () {
        Get.back(); // Tutup dialog
        resetQuiz();
        Get.back(); // Kembali ke layar awal
      },
    );
  }

  // Reset untuk ulang kuis
  void resetQuiz() {
    currentQuestionIndex.value = 0;
    selectedAnswerIndex.value = -1;
    score.value = 0;
  }
}
