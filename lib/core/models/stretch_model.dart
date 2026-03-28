import 'package:flutter/material.dart';

enum BodyPart {
  neck('Neck & Head', Icons.face_outlined),
  shoulders('Shoulders & Arms', Icons.accessibility_new_outlined),
  back('Back & Spine', Icons.airline_seat_recline_normal_outlined),
  wrists('Wrists & Hands', Icons.back_hand_outlined),
  legs('Legs & Hips', Icons.directions_walk_outlined),
  fullBody('Full Body', Icons.self_improvement_outlined);

  final String label;
  final IconData icon;
  const BodyPart(this.label, this.icon);
}

enum Difficulty {
  easy('Easy'),
  medium('Medium'),
  hard('Hard');

  final String label;
  const Difficulty(this.label);
}

class StretchExercise {
  final String id;
  final String name;
  final String description;
  final BodyPart bodyPart;
  final int durationSeconds;
  final Difficulty difficulty;

  const StretchExercise({
    required this.id,
    required this.name,
    required this.description,
    required this.bodyPart,
    required this.durationSeconds,
    required this.difficulty,
  });

  static const List<StretchExercise> catalog = [
    // Neck & Head
    StretchExercise(
      id: 'neck_roll',
      name: 'Neck Roll',
      description:
          'Slowly roll your head in a full circle, first clockwise then counter-clockwise. Keep movements smooth and gentle.',
      bodyPart: BodyPart.neck,
      durationSeconds: 30,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'chin_tuck',
      name: 'Chin Tuck',
      description:
          'Pull your chin straight back, creating a double chin. Hold for 5 seconds and release. Repeat several times.',
      bodyPart: BodyPart.neck,
      durationSeconds: 30,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'side_neck_stretch',
      name: 'Side Neck Stretch',
      description:
          'Gently tilt your ear toward your shoulder. Hold each side for 15 seconds, feeling the stretch along the opposite side of your neck.',
      bodyPart: BodyPart.neck,
      durationSeconds: 45,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'head_turn',
      name: 'Head Turn',
      description:
          'Slowly turn your head to look over one shoulder, hold for 10 seconds, then turn to the other side. Keep your shoulders relaxed.',
      bodyPart: BodyPart.neck,
      durationSeconds: 30,
      difficulty: Difficulty.easy,
    ),

    // Shoulders & Arms
    StretchExercise(
      id: 'shoulder_roll',
      name: 'Shoulder Roll',
      description:
          'Roll your shoulders forward in large circles 10 times, then backward 10 times. Keep your arms relaxed at your sides.',
      bodyPart: BodyPart.shoulders,
      durationSeconds: 30,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'cross_body_pull',
      name: 'Cross-Body Arm Pull',
      description:
          'Extend one arm across your chest and gently pull it closer with your other hand. Hold for 15 seconds each side.',
      bodyPart: BodyPart.shoulders,
      durationSeconds: 45,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'overhead_tricep',
      name: 'Overhead Tricep Stretch',
      description:
          'Raise one arm overhead and bend the elbow to reach behind your head. Gently push the elbow with the other hand. Hold 15s each side.',
      bodyPart: BodyPart.shoulders,
      durationSeconds: 45,
      difficulty: Difficulty.medium,
    ),
    StretchExercise(
      id: 'chest_opener',
      name: 'Chest Opener',
      description:
          'Clasp your hands behind your back, straighten your arms, and lift them slightly while opening your chest. Hold for 20 seconds.',
      bodyPart: BodyPart.shoulders,
      durationSeconds: 30,
      difficulty: Difficulty.easy,
    ),

    // Back & Spine
    StretchExercise(
      id: 'cat_cow',
      name: 'Cat-Cow Stretch',
      description:
          'On hands and knees, alternate between arching your back up (cat) and dipping it down (cow). Move slowly with your breath.',
      bodyPart: BodyPart.back,
      durationSeconds: 45,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'seated_twist',
      name: 'Seated Spinal Twist',
      description:
          'Sit tall, cross one leg over the other, and twist your torso toward the top knee. Use your arm against your knee for leverage. Hold 20s each side.',
      bodyPart: BodyPart.back,
      durationSeconds: 60,
      difficulty: Difficulty.medium,
    ),
    StretchExercise(
      id: 'side_bend',
      name: 'Standing Side Bend',
      description:
          'Stand with feet hip-width apart. Raise one arm overhead and lean to the opposite side. Feel the stretch along your side. Hold 15s each side.',
      bodyPart: BodyPart.back,
      durationSeconds: 45,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'forward_fold',
      name: 'Forward Fold',
      description:
          'Stand and slowly fold forward from your hips, letting your arms hang toward the floor. Bend your knees slightly if needed. Hold for 30 seconds.',
      bodyPart: BodyPart.back,
      durationSeconds: 45,
      difficulty: Difficulty.medium,
    ),

    // Wrists & Hands
    StretchExercise(
      id: 'wrist_circles',
      name: 'Wrist Circles',
      description:
          'Extend your arms and slowly rotate your wrists in circles. Do 10 circles each direction to relieve typing tension.',
      bodyPart: BodyPart.wrists,
      durationSeconds: 30,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'prayer_stretch',
      name: 'Prayer Stretch',
      description:
          'Press your palms together in front of your chest, then slowly lower your hands while keeping palms pressed. Hold when you feel a stretch.',
      bodyPart: BodyPart.wrists,
      durationSeconds: 30,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'finger_spread',
      name: 'Finger Spread',
      description:
          'Extend all fingers wide apart, hold for 5 seconds, then make a tight fist. Repeat 10 times to improve hand circulation.',
      bodyPart: BodyPart.wrists,
      durationSeconds: 30,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'wrist_flexor',
      name: 'Wrist Flexor Stretch',
      description:
          'Extend one arm with palm up, use the other hand to gently pull fingers back toward you. Hold 15 seconds each wrist.',
      bodyPart: BodyPart.wrists,
      durationSeconds: 45,
      difficulty: Difficulty.easy,
    ),

    // Legs & Hips
    StretchExercise(
      id: 'quad_stretch',
      name: 'Standing Quad Stretch',
      description:
          'Stand on one leg, pull your other foot toward your glute. Keep knees close together and hold for 20 seconds each leg.',
      bodyPart: BodyPart.legs,
      durationSeconds: 45,
      difficulty: Difficulty.medium,
    ),
    StretchExercise(
      id: 'calf_raises',
      name: 'Calf Raises',
      description:
          'Rise up on your toes, hold for 2 seconds at the top, then slowly lower. Repeat 15 times to wake up your lower legs.',
      bodyPart: BodyPart.legs,
      durationSeconds: 45,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'hip_circles',
      name: 'Hip Circles',
      description:
          'Stand with hands on hips and rotate your hips in large circles. Do 10 circles each direction to loosen up the hip joints.',
      bodyPart: BodyPart.legs,
      durationSeconds: 30,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'figure_four',
      name: 'Seated Figure Four',
      description:
          'Sit tall and cross one ankle over the opposite knee. Gently press the raised knee down. Hold 20 seconds each side.',
      bodyPart: BodyPart.legs,
      durationSeconds: 60,
      difficulty: Difficulty.medium,
    ),

    // Full Body
    StretchExercise(
      id: 'standing_reach',
      name: 'Standing Reach',
      description:
          'Stand tall and reach both arms as high as possible. Rise onto your toes and stretch from fingertips to toes. Hold for 15 seconds.',
      bodyPart: BodyPart.fullBody,
      durationSeconds: 30,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'full_body_shake',
      name: 'Full Body Shake',
      description:
          'Shake out your hands, arms, legs, and whole body vigorously for 30 seconds. Great for releasing tension and boosting energy.',
      bodyPart: BodyPart.fullBody,
      durationSeconds: 30,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'deep_breathing',
      name: 'Deep Breathing Stretch',
      description:
          'Inhale deeply while reaching arms overhead. Exhale and fold forward. Repeat 5 times, synchronizing movement with breath.',
      bodyPart: BodyPart.fullBody,
      durationSeconds: 45,
      difficulty: Difficulty.easy,
    ),
    StretchExercise(
      id: 'wall_pushup',
      name: 'Wall Push-Up Stretch',
      description:
          'Place hands on a wall at shoulder height. Step back and do slow push-ups against the wall. Do 10 reps to engage chest, arms, and core.',
      bodyPart: BodyPart.fullBody,
      durationSeconds: 45,
      difficulty: Difficulty.medium,
    ),
  ];

  static StretchExercise? findById(String id) {
    try {
      return catalog.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<StretchExercise> getByBodyPart(BodyPart part) {
    return catalog.where((s) => s.bodyPart == part).toList();
  }
}
