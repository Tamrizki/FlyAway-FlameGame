import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:fly_away/consts/assets.dart';
import 'package:fly_away/consts/consts.dart';
import 'package:fly_away/presentation/fly_away_game.dart';

// Kelas `Obstacle` merepresentasikan rintangan dalam game dengan posisi dan ukuran yang ditentukan.
// Menggunakan `SpriteComponent` untuk memuat gambar sprite rintangan dan `HasGameRef<FlyAwayGame>` untuk mengakses referensi game utama.
class Obstacle extends SpriteComponent with HasGameRef<FlyAwayGame> {
  @override
  final double height;

  // Variabel `obstaclePotition` untuk menentukan posisi rintangan, apakah di atas atau di bawah layar
  final ObstaclePotition obstaclePotition;

  Obstacle({
    required this.height,
    required this.obstaclePotition,
  });

  // Di sini, sprite untuk rintangan (gambar Monas) dimuat, dan ukuran serta posisi rintangan ditentukan berdasarkan posisi yang dipilih.
  @override
  FutureOr<void> onLoad() async {
    // Memuat gambar sprite untuk rintangan dan gambar rotasi
    final obstacle = await Flame.images.load(Assets.monas);
    final obstacleRotate = await Flame.images.load(Assets.monasRotate);

    // Menetapkan ukuran rintangan berdasarkan tinggi yang diberikan
    size = Vector2(50, height);

    // Menentukan posisi dan sprite berdasarkan jenis posisi rintangan (atas atau bawah)
    switch (obstaclePotition) {
      case ObstaclePotition.top:
        position.y =
            0; // Menetapkan posisi vertikal rintangan di bagian atas layar
        sprite = Sprite(
            obstacleRotate); // Menggunakan gambar rotasi untuk posisi atas
        break;
      case ObstaclePotition.bottom:
        position.y = gameRef.size.y -
            size.y -
            Consts
                .groundHeight; // Menetapkan posisi vertikal rintangan di bagian bawah layar
        sprite =
            Sprite(obstacle); // Menggunakan gambar normal untuk posisi bawah
        break;
    }

    // Menambahkan hitbox untuk mendeteksi tabrakan
    add(RectangleHitbox());
  }
}
