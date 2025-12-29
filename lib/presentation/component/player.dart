import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';
import 'package:fly_away/consts/assets.dart';
import 'package:fly_away/consts/consts.dart';
import 'package:fly_away/presentation/fly_away_game.dart';
import 'package:fly_away/presentation/game_over_menu.dart';

// Kelas `Player` merepresentasikan pemain dalam game dengan animasi berdasarkan status gerakan (up, middle, down).
// Menggunakan mixin `HasGameRef<FlyAwayGame>` untuk mengakses referensi game utama dan `CollisionCallbacks` untuk menangani deteksi tabrakan.
class Player extends SpriteGroupComponent<Movement>
    with HasGameRef<FlyAwayGame>, CollisionCallbacks {
  int score = 0;

  // Fungsi onLoad() dipanggil saat objek player pertama kali dimuat.
  // Di sini, sprite karakter untuk gerakan naik, tengah, dan turun dimuat, ukuran dan posisi karakter ditentukan,
  // dan hitbox ditambahkan untuk mendeteksi tabrakan.
  @override
  FutureOr<void> onLoad() async {
    final charUp = await gameRef.loadSprite(Assets.jokowiUp);
    final charMiddle = await gameRef.loadSprite(Assets.jokowiMid);
    final charDown = await gameRef.loadSprite(Assets.jokowiDown);

    sprites = {
      Movement.up: charUp,
      Movement.middle: charMiddle,
      Movement.down: charDown,
    };

    size = Vector2(40, 40); // Menetapkan ukuran sprite player
    position = Vector2(
        30,
        gameRef.size.y / 2 -
            size.y /
                2); // Menetapkan posisi player di tengah layar secara vertikal
    current = Movement
        .middle; // Menetapkan status gerakan awal player ke posisi tengah

    add(RectangleHitbox()); // Menambahkan hitbox untuk deteksi tabrakan
  }

  // Fungsi fly() dipanggil saat pemain melakukan aksi terbang,
  // menggunakan efek gerakan untuk mengubah posisi vertikal pemain dengan durasi tertentu dan memberikan transisi gerakan.
  void fly() {
    add(
      MoveByEffect(
        Vector2(
            0, Consts.gravity), // Menggunakan gravitasi untuk gerakan vertikal
        EffectController(
            duration: 0.2,
            curve: Curves.decelerate), // Durasi efek dan kurva gerakan
        onComplete: () => current = Movement
            .down, // Mengubah status gerakan menjadi turun setelah efek selesai
      ),
    );

    current = Movement.up; // Mengubah status gerakan menjadi naik
  }

  // Fungsi onCollisionStart() dipanggil ketika terjadi tabrakan antara player dan objek lain,
  // yang kemudian memicu fungsi gameOver() untuk mengakhiri permainan.
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver(); // Memanggil fungsi gameOver untuk menghentikan permainan
  }

  // Fungsi update() dipanggil setiap frame untuk memperbarui posisi pemain.
  // Di sini, posisi pemain diperbarui berdasarkan kecepatan pemain yang dipengaruhi oleh waktu (dt).
  @override
  void update(double dt) {
    super.update(dt);
    position.y +=
        Consts.playerVelocity * dt; // Memperbarui posisi vertikal pemain
  }

  // Fungsi gameOver() menghentikan permainan, menampilkan overlay GameOverMenu, dan menghentikan mesin permainan.
  void gameOver() {
    gameRef.isGameOver = true; // Menandakan bahwa permainan telah berakhir
    gameRef.overlays.add(GameOverMenu.id); // Menampilkan overlay game over
    gameRef.pauseEngine(); // Menghentikan mesin permainan
  }

  // Fungsi reset() digunakan untuk mengatur ulang posisi pemain dan skor saat permainan dimulai ulang.
  // Mengatur ulang posisi pemain ke tengah layar & skor pemain
  void reset() {
    position = Vector2(30, gameRef.size.y / 2 - size.y / 2);
    score = 0;
  }
}
