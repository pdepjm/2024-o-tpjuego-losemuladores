import wollok.game.*

//Cómo hacer para moverse más rápido?

object juegoDeAutos {

  method iniciar() {
    game.width(10)
    game.height(9)
    game.boardGround("freeway.png")
    game.addVisualCharacter(auto)
    game.addVisualCharacter(obstaculo)

    keyboard.left().onPressDo({ auto.moverIzquierda() })
    keyboard.right().onPressDo({ auto.moverDerecha() })

    game.onTick(1000, "moverse", {obstaculo.moverseHaciaAbajo()})
  }
}

object auto {
  var nafta = 100
  var position = game.at(5, 4)
  method image() = "policecar.png"
  
  method perderNafta() {
    nafta -= 2
  }

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

  method chocarConObstaculo() {
    nafta -= 10
  }

  method chocarConAutoEnemigo() {
    game.stop()
  }
}

object obstaculo {
  var position = game.at(1.randomUpTo(game.width()), 4)
  method image() = "cono.png"
  /*method aparecer() {
    posicion = game.at(0.randomUpTo(9),0)
  }*/
  method position() = position

  method moverseHaciaAbajo () {
     if (position.y() < game.height() - 1) {
      position = game.at(position.x(), position.y() + 1)
    } else {
      // Si el obstáculo llega al final del tablero, reaparece en la parte superior con nueva posición
      position = game.at(0.randomUpTo(game.width() - 1), 0)
    }
  }
}
//TODO : Implementar la clase obstaculo
//Cómo hacer para moverse más rápido?
//Movimientos con polimorfismo
