import wollok.game.*
import handlers.*
import visuales.*
import example.*

object musicaDeFondo {
  method iniciarFondo() {
    const musica = game.sound("fondo.mp3")
    game.schedule(0, {musica.play() musica.pause() musica.resume()})
  }
}

object sonidoColision {
    method iniciarColision() {
        //const sonido = game.sound("explosion.mp3")
    }
}