import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fly_away/presentation/fly_away_game.dart';
import 'package:fly_away/presentation/game_start_menu.dart';

import 'presentation/game_over_menu.dart';

void main() {
  // Membuat objek game dengan tipe FlyAwayGame.
  final game = FlyAwayGame();

  // Menjalankan aplikasi menggunakan GameWidget dari Flame
  runApp(GameWidget(
    // Menetapkan game yang akan dijalankan di dalam GameWidget.
    game: game,

    // Menetapkan overlay awal yang aktif, dalam hal ini GameStartMenu.
    initialActiveOverlays: const [GameStartMenu.id],

    // Menentukan overlay-builder yang akan digunakan untuk setiap overlay yang ada.
    overlayBuilderMap: {
      // Menyediakan fungsi untuk membangun overlay GameStartMenu.
      GameStartMenu.id: (context, _) => GameStartMenu(game: game),

      // Menyediakan fungsi untuk membangun overlay GameOverMenu.
      GameOverMenu.id: (context, _) => GameOverMenu(game: game),
    },
  ));
}
