import audio.*
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
    //sonido.iniciarFondo()
  }

  method configurarTeclado() {
    keyboard.left().onPressDo({ auto.moverIzquierda() })
    keyboard.right().onPressDo({ auto.moverDerecha() })
  }
}

object auto {
  var posicionActual = game.at(1, 2)
  method image() = "porsche.png"
  method position() = posicionActual

  method moverIzquierda() {
    if (posicionActual.x() > 0) {
      posicionActual = posicionActual.left(1)
    }
  }

  method moverDerecha() {
    if (posicionActual.x() < game.width() - 1) {
      posicionActual = posicionActual.right(1)
    }
  }

}

class Objeto {
  var property position = game.at(0.randomUpTo(game.width() - 1), 12)

  method moverseHaciaAbajo() {
    if (position.y() > 0) {
      position = game.at(position.x(), position.y() - 1)
    } else {
      position = game.at(0.randomUpTo(game.width() - 1), game.height() - 1)
    }
  }

  method chocar()
  
  //method reposicionar(nuevoAuto) { 
   // position = game.at(0.randomUpTo(game.width() - 1), 12)}
}

class Gasolina inherits Objeto {
  
  method image() = "gasolina.png"

  override method chocar() {
    contadorNafta.agregarNafta(10)
  }

  method restaurarUbicacion() {
    position = game.at(0.randomUpTo(game.width() - 1), 12)
  }
}

const gasolina = new Gasolina()

class Cono inherits Objeto {
  method image() = "cono.png"

  override method chocar() {
    contadorNafta.agregarNafta(-10)
  }

}

class AutoEnemigo inherits Objeto {

  method image() = "policecar.png"
  
  override method chocar() {
    sonidoColision.iniciarColision()
    cartelFinal.iniciar()
  }
}
