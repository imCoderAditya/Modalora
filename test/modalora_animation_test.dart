import 'package:flutter_test/flutter_test.dart';
import 'package:modalora/modalora.dart';

void main() {
  group('ModaloraAnimation', () {
    test('constructs fadeScale animation with default values', () {
      final anim = ModaloraAnimation.fadeScale();
      expect(anim.type, ModaloraAnimationType.fadeScale);
      expect(anim.duration, const Duration(milliseconds: 300));
      expect(anim.scaleBegin, 0.92);
    });

    test('constructs spring animation with physics curve', () {
      final anim = ModaloraAnimation.spring();
      expect(anim.type, ModaloraAnimationType.spring);
      expect(anim.curve, isA<ModaloraSpringCurve>());
    });

    test('spring curve simulates realistic bounce value', () {
      const curve = ModaloraSpringCurve.gentle;
      expect(curve.transform(0.0), 0.0);
      expect(curve.transform(1.0), 1.0);
      final intermediate = curve.transform(0.5);
      expect(intermediate, greaterThan(0.0));
    });
  });
}
