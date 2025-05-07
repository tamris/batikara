import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sibatikgal/app/modules/quiz/bindings/quiz_binding.dart';
import '../controllers/quiz_controller.dart';
import 'quiz_question_view.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFDA7137),
        // foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Quiz\nBatik Tegalan',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 52),
            const Text(
              'Seberapa Kenal Kamu dengan Batik Tegalan?\nJawab pertanyaan dan raih skor tertinggi!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Center(
                child: Lottie.asset(
                  'assets/animations/quiz.json', // Path ke file JSON
                  width: 600,
                  height: 600,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => QuizQuestionView(), binding: QuizBinding());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDA7137),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Mulai Kuis',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 42),
          ],
        ),
      ),
    );
  }
}
