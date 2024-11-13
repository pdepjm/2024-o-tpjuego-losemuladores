import wollok.game.*
import handlers.*
import visuales.*
import example.*

object musicaDeFondo {
  const musica = game.sound("fondo.mp3")
  method iniciarFondo() {
    game.schedule(2, {musica.play() musica.pause() musica.resume()})
  }
}

/*object sonidoColision {
  const sonido = game.sound("explosion.mp3")
    method iniciarColision() {
      sonido.play()
    }
}*/