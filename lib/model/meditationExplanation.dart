import 'package:flutter/cupertino.dart';

class MeditationExplanation {
  final String name;
  final String desc;

  MeditationExplanation({
    required this.name,
    required this.desc,
  });
}

List<MeditationExplanation> mediationExerciseExplanations = [
  MeditationExplanation(
      name: 'Take a seat',
      desc: "Find place to sit that feels calm and quiet to you."),
  MeditationExplanation(
      name: 'Set a time limit',
      desc:
          'If you’re just beginning, it can help to choose a short time, such as five or 10 minutes.'),
  MeditationExplanation(
      name: 'Notice your body',
      desc:
          'You can sit in a chair with your feet on the floor, you can sit loosely cross-legged, you can kneel—all are fine. Just make sure you are stable and in a position you can stay in for a while.'),
  MeditationExplanation(
      name: 'Feel your breath',
      desc:
          'Follow the sensation of your breath as it goes in and as it goes out.'),
  MeditationExplanation(
      name: 'Notice when your mind has wandered',
      desc:
          'Inevitably, your attention will leave the breath and wander to other places. When you get around to noticing that your mind has wandered—in a few seconds, a minute, five minutes—simply return your attention to the breath.'),
  MeditationExplanation(
      name: 'Be kind to your wandering mind',
      desc:
          'Don’t judge yourself or obsess over the content of the thoughts you find yourself lost in. Just come back.'),
  MeditationExplanation(
      name: 'Close with kindness',
      desc:
          'When you’re ready, gently lift your gaze (if your eyes are closed, open them). Take a moment and notice any sounds in the environment. Notice how your body feels right now. Notice your thoughts and emotions.'),
];
