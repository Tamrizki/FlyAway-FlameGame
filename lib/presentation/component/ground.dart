import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:fly_away/consts/assets.dart';
import 'package:fly_away/consts/consts.dart';
import 'package:fly_away/presentation/fly_away_game.dart';

// Kelas `Ground` mengelola latar belakang tanah dalam game menggunakan efek parallax untuk menciptakan ilusi pergerakan latar belakang.
// Menggunakan `ParallaxComponent<FlyAwayGame>` untuk menangani efek parallax dan `HasGameRef<FlyAwayGame>` untuk mengakses referensi game utama.
class Ground extends ParallaxComponent<FlyAwayGame>
    with HasGameRef<FlyAwayGame> {
  Ground();

  // Di sini, gambar untuk latar belakang tanah dimuat, dan efek parallax diterapkan untuk menciptakan pergerakan latar belakang.
  @override
  FutureOr<void> onLoad() async {
    // Memuat gambar untuk latar belakang tanah (road)
    final ground = await Flame.images.load(Assets.road);

    // Membuat efek parallax untuk latar belakang tanah dengan satu lapisan
    parallax = Parallax(
      [
        ParallaxLayer(
          ParallaxImage(ground,
              fill: LayerFill
                  .width), // Mengatur pengisian lapisan dengan lebar layar
        ),
      ],
    );

    // Menambahkan hitbox untuk tanah agar bisa mendeteksi tabrakan dengan objek lain
    add(RectangleHitbox(
      position: Vector2(
        0,
        gameRef.size.y - Consts.groundHeight,
      ),
      size: Vector2(gameRef.size.x, Consts.groundHeight),
    ));
  }

  // Di sini, kecepatan dasar parallax diubah agar latar belakang tanah bergerak ke kiri dengan kecepatan game.
  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = Consts.gameSpeed;
  }
}
