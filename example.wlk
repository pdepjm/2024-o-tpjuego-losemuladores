import wollok.game.*
import handlers.*
import visuales.*

object juegoDeAutos {

  method iniciar() {
    game.width(9)
    game.height(12)
    game.cellSize(50)
    game.boardGround("freeway.png")
    game.addVisualCharacter(auto)
    game.onCollideDo(auto, {visual => visual.chocar()})
  }

  method configurarTeclado() {
    keyboard.left().onPressDo({ auto.moverIzquierda() })
    keyboard.right().onPressDo({ auto.moverDerecha() })
  }
}


object auto {
  var position = game.at(1, 2)
  method image() = "porsche.png"
  method position() = position

  method moverIzquierda() {
    if (position.x() > 0) {
      position = position.left(1)
    }
  }

  method moverDerecha() {
    if (position.x() < game.width() - 1) {
      position = position.right(1)
    }
  }

}

object gasolina {
  var property position = game.at(0.randomUpTo(game.width() - 1), 9)
  method image() = "gasolina.png"
  
  method moverseHaciaAbajo() {
    if (position.y() > 0) {
      position = game.at(position.x(), position.y() - 1)
    } else {
      position = game.at(0.randomUpTo(game.width() - 1), game.height() - 1)
    }
  }

  method chocar() {
    contadorNafta.agregarNafta(10)
  }

  method restaurarUbicacion() {
    position = game.at(0.randomUpTo(game.width() - 1), 9)
  }
}

class Obstaculo {
  var position = game.at(0.randomUpTo(game.width() - 1), 12)
  method image() = "cono.png"
  
  method position() = position
  method position(newPosition) {
    position = newPosition
  }

  method moverseHaciaAbajo() {
    if (position.y() > 0) {
      position = position.down(1)
    } else {
      position = game.at(0.randomUpTo(game.width() - 1), game.height() - 1)
    }
  }

  method chocar() {
    contadorNafta.agregarNafta(-10)
  }

}

class AutoEnemigo {
  var position = game.at(0.randomUpTo(game.width() - 1), game.height() - 1)
  method image() = "policecar.png"
  
  method position() = position
  method position(newPosition) {
    position = newPosition
  }

  method moverseHaciaAbajo() {
    if (position.y() > 0) {
      position = position.down(1)
    } else {
      position = game.at(0.randomUpTo(game.width() - 1), game.height() - 1)
    }
  }

  method chocar() {
    sonido.explosion()
    cartelFinal.iniciar()
  }
}

object sonido {
  const sonidoFondo = game.sound("fondo.mp3")
  
  method iniciarFondo() {
    sonidoFondo.shouldLoop(true)
    game.schedule(0, {sonidoFondo.play()})
  }

  method explosion() {
    game.sound("explosion.wav").play()
  }

}