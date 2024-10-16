import wollok.game.*

object juegoDeAutos {

  method iniciar() {
    game.width(9)
    game.height(12)
    game.cellSize(50)
    game.boardGround("freeway.png")
    game.addVisualCharacter(auto)
    game.addVisual(contador)
    game.addVisual(contadorNafta)

    keyboard.left().onPressDo({ auto.moverIzquierda() })
    keyboard.right().onPressDo({ auto.moverDerecha() })

    game.schedule(300, {manejadorAutos.agregarAutosFilaSuperior()
    manejadorAutos.agregarAutosFilaSuperior()
    manejadorAutos.agregarAutosFilaSuperior()
    })

    game.schedule(1200, {manejadorAutos.agregarAutosFilaSuperior()
    manejadorAutos.agregarAutosFilaSuperior()
    manejadorAutos.agregarAutosFilaSuperior()
    })

    game.schedule(2100, {manejadorAutos.agregarAutosFilaSuperior()
    manejadorAutos.agregarAutosFilaSuperior()
    manejadorAutos.agregarAutosFilaSuperior()
    })

    game.schedule(3000, {manejadorAutos.agregarAutosFilaSuperior()
    manejadorAutos.agregarAutosFilaSuperior()
    manejadorAutos.agregarAutosFilaSuperior()
    })

    game.schedule(3300, {game.addVisual(gasolina)})

    game.schedule(1500, {manejadorObstaculos.agregarObstaculos()
    manejadorObstaculos.agregarObstaculos()
    })

    game.schedule(3300, {manejadorObstaculos.agregarObstaculos()
    manejadorObstaculos.agregarObstaculos()
    })
    
  }
}

object auto {
  method image() = "porsche.png"

  var position = game.at(1, 2)
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

  method chocarConObstaculo() {}

  method chocarConAutoEnemigo() {
    game.stop()
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
}

object contador {
  var puntos = 0
  const property celeste = "279df5cc"

  method position () = game.at(7, 11)

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

object manejadorAutos  {
   const autos = new List()

  method agregarAutosFilaSuperior() {
    const nuevoAuto = new AutoEnemigo ()
    autos.add(nuevoAuto)
    game.addVisual(nuevoAuto)
  }

  method paraCadaAuto() {
    autos.forEach{autoEnemigo => autoEnemigo.moverseHaciaAbajo()}
  }
}

object manejadorObstaculos  {
   const obstaculos = new List()

  method agregarObstaculos() {
    const nuevoObstaculo = new Obstaculo ()
    obstaculos.add(nuevoObstaculo)
    game.addVisual(nuevoObstaculo)
  }

  method paraCadaObstaculo() {
    obstaculos.forEach{obstaculo => obstaculo.moverseHaciaAbajo()}
  }
}