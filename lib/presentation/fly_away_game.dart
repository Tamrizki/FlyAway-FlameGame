import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flame/game.dart';
import 'package:fly_away/consts/consts.dart';
import 'package:fly_away/presentation/component/background.dart';
import 'package:fly_away/presentation/component/obstacle_group.dart';
import 'package:fly_away/presentation/component/player.dart';
import 'package:fly_away/presentation/component/ground.dart';

// Kelas `FlyAwayGame` meng-extend `FlameGame` untuk menangani siklus hidup game dan pengelolaan objek.
// Dengan mixin `TapDetector`, game dapat mendeteksi input tap untuk aksi seperti membuat pemain terbang.
// Mixin `HasCollisionDetection` memungkinkan deteksi tabrakan antar objek, seperti pemain dan rintangan.
// Gabungan ketiga komponen ini memungkinkan game interaktif yang merespons input dan mengelola tabrakan antar objek.
class FlyAwayGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Player player;
  late TextComponent score;

  // Membuat interval timer untuk menambahkan rintangan (obstacle) secara berkala
  Timer interval = Timer(
    Consts.obstacleInterval, // Interval waktu antar rintangan
    repeat: true, // Menentukan agar interval ini diulang terus-menerus
  );

  // Variabel untuk menentukan apakah permainan sudah berakhir atau belum
  bool isGameOver = false;

  // Fungsi onLoad() dipanggil saat game dimulai
  @override
  FutureOr<void> onLoad() {
    addAll([
      Background(), // Menambahkan background game
      Ground(), // Menambahkan tanah atau lantai
      player = Player(), // Menambahkan pemain ke dalam game
      score = buildScore(), // Menambahkan komponen skor
    ]);

    // Menetapkan fungsi yang dipanggil setiap interval timer berakhir
    interval.onTick = () => add(ObstacleGroup());
  }

  TextComponent buildScore() {
    return TextComponent(
      text: 'Score: 0', // Menampilkan teks skor awal
      position: Vector2(
        size.x / 2.5, // Menempatkan teks pada posisi tengah secara horizontal
        size.y / 2 * 0.2, // layar secara vertikalnya
      ),
    );
  }

  // Fungsi update() dipanggil setiap frame untuk memperbarui status game
  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt); // Memperbarui interval timer

    // Memperbarui teks skor setiap frame berdasarkan skor pemain
    score.text = 'Score: ${player.score}';
  }

  // Fungsi onTap() dipanggil ketika pengguna men-tap layar
  @override
  void onTap() {
    super.onTap();
    player.fly();
  }
}
