import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';

class InstructionImageResult extends QuestionResult<String> {
  InstructionImageResult({
    required Identifier super.id,
    required super.startDate,
    required super.endDate,
    required String super.valueIdentifier,
    required String super.result,
  });

  @override
  List<Object?> get props => [
        id,
        startDate,
        endDate,
        valueIdentifier,
        result,
      ];
}
