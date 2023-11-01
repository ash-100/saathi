class DeepBreathingExercises {
  final String name;
  final String desc;
  final List<String> procedure;

  DeepBreathingExercises({
    required this.name,
    required this.desc,
    required this.procedure,
  });
}

List<String> alternateNostrilBreathingProcedure = [
  'Position your right hand by bending your pointer and middle fingers into your palm, leaving your thumb, ring finger, and pinky extended. This is known as Vishnu mudra in yoga.',
  'Close your eyes or softly gaze downward.',
  'Inhale and exhale to begin.',
  'Close off your right nostril with your thumb.',
  'Inhale through your left nostril.',
  'Close off your left nostril with your ring finger.',
  'Open and exhale through your right nostril.',
  'Inhale through your right nostril.',
  'Close off your right nostril with your thumb.',
  'Open and exhale through your left nostril.',
  'Inhale through your left nostril.',
];

List<String> bellyBreathingProcedure = [
  'Place one hand on your upper chest and the other hand on your belly, below the ribcage.',
  'Allow your belly to relax, without forcing it inward by squeezing or clenching your muscles.',
  'Breathe in slowly through your nose. The air should move into your nose and downward so that you feel your stomach rise with your other hand and fall inward (toward your spine).',
  'Exhale slowly through slightly pursed lips. Take note of the hand on your chest, which should remain relatively still.',
];

List<String> boxBreathingProcedure = [
  'Exhale to a count of four.',
  'Hold your lungs empty for a four-count.',
  'Inhale to a count of four.',
  'Hold the air in your lungs for a count of four.',
  'Exhale and begin the pattern anew.'
];

final alternateNostrilBreathingExercise = DeepBreathingExercises(
    name: 'Anulom Vilom / Alternate Nostril Breathing',
    desc:
        'Anulom Vilom should be done on an empty stomach, preferably 4 hours after you’ve eaten.It is best to practice this type of anxiety-relieving breathing in a seated position in order to maintain posture',
    procedure: alternateNostrilBreathingProcedure);

final bellyBreathingExercise = DeepBreathingExercises(
    name: 'Belly Breathing',
    desc: 'Find a quiet, comfortable place to sit or lie down',
    procedure: bellyBreathingProcedure);

final boxBreathingExercise = DeepBreathingExercises(
    name: 'Sama Vritti Pranayama / Box Breathing',
    desc:
        ' Sama Vritti pranayama is a technique to consciously incorporate longer breath retention in our natural breathing process.Try to equalize the duration of each breath movement that we breathe in & out through nostrils.',
    procedure: boxBreathingProcedure);

List<DeepBreathingExercises> deepBreathingExercises = [
  alternateNostrilBreathingExercise,
  bellyBreathingExercise,
  boxBreathingExercise
];
