import wollok.game.*

// Juego de autos con mayor velocidad de movimiento

object juegoDeAutos {

  method iniciar() {
    game.width(9)
    game.height(10)
    game.cellSize(50)
    game.boardGround("carretera.png")
    game.addVisualCharacter(auto)
    game.addVisual(obstaculo)
    game.addVisual(contador)
    game.addVisual(contadorNafta)

    keyboard.left().onPressDo({ auto.moverIzquierda() })
    keyboard.right().onPressDo({ auto.moverDerecha() })

    game.onTick(5000, "moverse", {obstaculo.moverseHaciaAbajo()
      contador.aumentarPuntos()
      contadorNafta.perderNafta()
      if (contadorNafta.nafta <= 0) game.stop()
    })
  }
}

object auto {
  var nafta = 100
  var position = game.at(1, 2)

  method nafta() = nafta

  method image() = "porsche.png"
  
  method perderNafta() {
    nafta = nafta - 2
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
  // Posición inicial aleatoria en la fila superior del tablero
  var position = game.at(0.randomUpTo(game.width() - 1), 9)
  method image() = "policecar.png"
  
  method position() = position
  method position(newPosition) {
    position = newPosition
  }

  method moverseHaciaAbajo () {
    if (position.y() > 0) {
      position = game.at(position.x(), position.y() - 1)
    }  else {
      // Si el obstáculo llega al final del tablero, reaparece en la parte superior con nueva posición
      position = game.at(0.randomUpTo(game.width() - 1), 9)
    }
  }
}

class AutoEnemigo {
  var position
  method image() = "policecar.png"
  
  method position() = position
  method position(newPosition) {
    position = newPosition
  }

  method moverseHaciaAbajo() {
    if (position.y() < game.height() - 1) {
      position = game.at(position.x(), position.y() - 1)
    } else {
      position = game.at(0.randomUpTo(game.width() - 1), 0)
    }
  }
}

object contador {
  var puntos = 0
  const property celeste = "279df5cc"

  method position () = game.at(7, 9)

  method aumentarPuntos() {
    puntos += 10
  }

  method text() = "    Puntos: " + puntos
  method textColor() = celeste
  
}

object contadorNafta {
  var nafta = 100

method perderNafta() {
  if (nafta > 0){
    nafta = nafta - 2
    } else {
      game.stop()
    }

  }

  const property celeste = "279df5cc"

  method position () = game.at(0, 0)

  method text() = "       Nafta: " + nafta
  method textColor() = celeste
  
}
