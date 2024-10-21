import wollok.game.*
import handlers.*
import visuales.*

object juegoDeAutos {

  method iniciar() {
    game.width(9)
    game.height(12)
    game.cellSize(50)
    game.boardGround("freeway.png")
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
      position = game.at(position.x() - 1, position.y())
    }
  }

  method moverDerecha() {
    if (position.x() < game.width() - 1) {
      position = game.at(position.x() + 1, position.y())
    }
  }

}

object gasolina {
  var position = game.at(0.randomUpTo(game.width() - 1), 9)
  method image() = "gasolina.png"

  method position() = position
  method position(newPosition) {
    position = newPosition
  }
  
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
}

class Obstaculo {
  // Posición inicial aleatoria en la fila superior del tablero
  var position = game.at(0.randomUpTo(game.width() - 1), 9)
  method image() = "cono.png"
  
  method position() = position
  method position(newPosition) {
    position = newPosition
  }

  method moverseHaciaAbajo() {
    if (position.y() > 0) {
      position = game.at(position.x(), position.y() - 1)
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
      position = game.at(position.x(), position.y() - 1)
    } else {
      position = game.at(0.randomUpTo(game.width() - 1), game.height() - 1)
    }
  }

  method chocar() {
    game.stop()
  }
}

