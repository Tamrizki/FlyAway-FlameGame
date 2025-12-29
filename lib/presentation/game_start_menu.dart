import 'package:flutter/material.dart';
import 'package:fly_away/consts/assets.dart';
import 'package:fly_away/presentation/fly_away_game.dart';

/// Tampilan ketika permainan akan dimulai
class GameStartMenu extends StatelessWidget {
  const GameStartMenu({super.key, required this.game});

  final FlyAwayGame game;
  static const String id = 'menu';

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          game.overlays.remove(GameStartMenu.id);
          game.resumeEngine();
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
                  'TAP Untuk Main',
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
}
