import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:fly_away/consts/consts.dart';
import 'package:fly_away/presentation/component/obstacle.dart';
import 'package:fly_away/presentation/fly_away_game.dart';

// Kelas `ObstacleGroup` mengelola sekumpulan rintangan yang bergerak dalam game, memperbarui posisi dan menangani logika penghapusan saat keluar dari layar.
// Menggunakan `PositionComponent` untuk pengaturan posisi objek dan `HasGameRef<FlyAwayGame>` untuk mengakses referensi game utama.
class ObstacleGroup extends PositionComponent with HasGameRef<FlyAwayGame> {
  // Variabel `_random` untuk menghasilkan angka acak, digunakan untuk menentukan posisi dan jarak rintangan secara dinamis
  final _random = Random();

  // Di sini, posisi horizontal objek ditetapkan ke lebar layar, dan posisi vertikal untuk rintangan ditentukan secara acak.
  @override
  FutureOr<void> onLoad() {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y -
        Consts.groundHeight; // Menghitung tinggi layar tanpa tanah

    // Menghitung jarak antar rintangan secara acak
    final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);

    // Menentukan posisi vertikal tengah rintangan secara acak
    final centerY =
        spacing + _random.nextDouble() * (heightMinusGround - spacing);

    // Menambahkan dua rintangan (atas dan bawah) ke dalam game dengan posisi dan tinggi yang dihitung
    addAll([
      Obstacle(
        obstaclePotition: ObstaclePotition.top,
        height: centerY - spacing / 2,
      ),
      Obstacle(
        obstaclePotition: ObstaclePotition.bottom,
        height: heightMinusGround - (centerY + spacing / 2),
      ),
    ]);
  }

  // Posisi horizontal grup rintangan bergerak ke kiri sesuai dengan kecepatan game.
  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Consts.gameSpeed *
        dt; // Menggerakkan ObstacleGroup ke kiri berdasarkan kecepatan game

    // Menghapus ObstacleGroup jika sudah melewati layar
    if (position.x < -10) {
      removeFromParent(); // Menghapus grup rintangan dari game
      updateScore(); // Memperbarui skor setelah grup rintangan berhasil dilewati
    }

    // Jika game sudah berakhir, menghapus ObstacleGroup
    if (gameRef.isGameOver) {
      removeFromParent();
      gameRef.isGameOver = false;
    }
  }

  // Fungsi updateScore() untuk menambahkan skor pemain setiap kali grup rintangan berhasil dilewati
  void updateScore() {
    gameRef.player.score += 1;
  }
}
