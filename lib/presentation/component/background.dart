import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:fly_away/consts/assets.dart';

class Background extends SpriteComponent with HasGameRef {
  Background();

  @override
  FutureOr<void> onLoad() async {
    final background = await Flame.images.load(Assets.background);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
