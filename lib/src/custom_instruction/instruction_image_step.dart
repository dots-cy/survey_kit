import 'package:flutter_html/flutter_html.dart';
import 'package:survey_kit/src/custom_instruction/instruction_image_result.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter/cupertino.dart';

class InstructionImageStep extends Step {
  final String title;
  final String text;
  final String imagePath;

  InstructionImageStep({
    required this.title,
    required this.text,
    required this.imagePath,
    super.isOptional,
    String super.buttonText,
    super.stepIdentifier,
    super.canGoBack,
    super.showProgress,
    super.showAppBar,
  });

  @override
  Widget createView({@required QuestionResult? questionResult}) {
    return StepView(
      step: this,
      resultFunction: () => InstructionImageResult(
        id: stepIdentifier,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        valueIdentifier: '', //Identification for NavigableTask,
        result: "",
      ),
      title: Html(data: title),
      child: Column(
        children: [
          if (imagePath.isNotEmpty) Image.asset(imagePath),
          if (text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Html(data: text),
            ),
        ],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'stepIdentifier': stepIdentifier.toJson(),
      'isOptional': isOptional,
      'buttonText': buttonText,
      'title': title,
      'text': text,
      'imagePath': imagePath,
      'canGoBack': canGoBack,
      'showProgress': showProgress,
      'showAppBar': showAppBar,
      'type': 'custom',
      // This helps identify the step type during deserialization
    };
  }

  factory InstructionImageStep.fromJson(Map<String, dynamic> json) =>
      InstructionImageStep(
        title: json['title'] as String,
        text: json['text'] as String? ?? "",
        imagePath: json['imagePath'] as String? ?? "",
        isOptional: json['isOptional'] as bool? ?? false,
        buttonText: json['buttonText'] as String? ?? 'Next',
        stepIdentifier: json['stepIdentifier'] != null
            ? StepIdentifier.fromJson(
                json['stepIdentifier'] as Map<String, dynamic>)
            : null,
        canGoBack: json['canGoBack'] as bool? ?? true,
        showProgress: json['showProgress'] as bool? ?? true,
        showAppBar: json['showAppBar'] as bool? ?? true,
      );
}

Step createStepFromJson(Map<String, dynamic> json) {
  final type = json['type'];
  if (type == 'intro') {
    return InstructionStep.fromJson(json);
  } else if (type == 'question') {
    return QuestionStep.fromJson(json);
  } else if (type == 'completion') {
    return CompletionStep.fromJson(json);
  } else if (type == 'custom') {
    return InstructionImageStep.fromJson(json);
  }
  throw StepNotDefinedException();
}
