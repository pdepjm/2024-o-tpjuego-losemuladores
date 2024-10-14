import wollok.game.*

//Cómo hacer para moverse más rápido?

object juegoDeAutos {

  method iniciar() {
    game.width(10)
    game.height(9)
    game.boardGround("freeway.png")
    game.addVisualCharacter(auto)
    keyboard.left().onPressDo({ auto.moverIzquierda() })
    keyboard.right().onPressDo({ auto.moverDerecha() })
  }
}

object auto {
  var nafta = 100
  var posicion = game.at(5, 4)
  const property image = "policecar.png"
  
  method perderNafta() {
    nafta -= 2
  }

  method position() = posicion

  method moverIzquierda() {
    if (posicion.x() > 0) {
      posicion = game.at(posicion.x() - 1, posicion.y())
    }
  }

  method moverDerecha() {
    if (posicion.x() < game.width() - 1) {
      posicion = game.at(posicion.x() + 1, posicion.y())
    }
  }

  method chocarConObstaculo() {
    nafta -= 10
  }

  method chocarConAutoEnemigo() {
    game.stop()
  }
}
 /*
  method position() = position

  method position(newPosition) {
    position = newPosition
  }

  method mover(direccion){
    const nuevaPosicion = direccion.siguiente(self.position())
    if (nuevaPosicion.x() >= 0 && nuevaPosicion.x() < game.width())
		self.position(nuevaPosicion)
  }
*/
/*
object izquierda { 
	method siguiente(position) = position.left(1) 
}

object derecha { 
	method siguiente(position) = position.right(1) 
}

*/
//TODO : Implementar la clase obstaculo
//Cómo hacer para moverse más rápido?
//Movimientos con polimorfismo
