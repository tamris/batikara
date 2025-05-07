import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quiz_controller.dart';

class QuizQuestionView extends StatelessWidget {
  final QuizController controller = Get.find();

  QuizQuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDA7137),
      body: SafeArea(
        child: Obx(() {
          final question =
              controller.questions[controller.currentQuestionIndex.value];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              children: [
                // Header (Back, Judul, Progress)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Jawablah Quiz Tersebut Dengan Benar !',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Soal nomor ${controller.currentQuestionIndex.value + 1} dari ${controller.questions.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 15),
                LinearProgressIndicator(
                  value: (controller.currentQuestionIndex.value + 1) /
                      controller.questions.length,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                // Kotak putih di tengah (gunakan Expanded + Center)
                Expanded(
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Pertanyaan
                          Text(
                            question.question,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Pilihan Jawaban
                          ...List.generate(question.options.length, (index) {
                            final isSelected =
                                controller.selectedAnswerIndex.value == index;
                            return GestureDetector(
                              onTap: () => controller.selectAnswer(index),
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFFDA7137)
                                        : Colors.grey.shade400,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: isSelected
                                      ? const Color(0xFFDA7137).withOpacity(0.1)
                                      : Colors.white,
                                ),
                                child: Text(
                                  "${String.fromCharCode(65 + index)}. ${question.options[index]}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            );
                          }),

                          const SizedBox(height: 50),

                          // Tombol Skip & Next
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: controller.skip,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFDA7137),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                  ),
                                  child: const Text(
                                    'Skip',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: controller.next,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFDA7137),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                  ),
                                  child: const Text(
                                    'Next',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
