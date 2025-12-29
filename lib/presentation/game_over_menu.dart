import 'package:flutter/material.dart';

import '../consts/assets.dart';
import 'fly_away_game.dart';

/// Tampilan ketika permainan berkhir
class GameOverMenu extends StatelessWidget {
  const GameOverMenu({super.key, required this.game});

  final FlyAwayGame game;
  static const String id = 'gameOverMenu';

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          onRestart();
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.backgroundFullPath),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Restart',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.touch_app,
                  size: 32,
                )
              ],
            ),
          )),
        ),
      ),
    );
  }

  void onRestart() {
    game.player.reset();
    game.overlays.remove(GameOverMenu.id);
    game.resumeEngine();
  }
}
