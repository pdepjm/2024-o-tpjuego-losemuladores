//Cómo hacer para moverse más rápido?
object juegoDeAutos {
  method iniciar() {
    game.width(10)
    game.height(7)
    game.cellSize(50)
    game.title("Juego")
    game.boardGround("fondo.jpg")
    
    game.addVisualCharacter(auto)
  }
}

object auto {
  var nafta = 100
  var position = game.center()
  
  method image() = "policecar.png"
  
  method position() = position
  
  method perderNafta() {
    nafta -= 1
  }
  
  method startGame() {
    game.onTick(1000, "movimiento", { self.perderNafta() })
  }
  
  method cambiarPosicion(nuevaPosicion) {
    position = nuevaPosicion
  }
} 

//TODO : Implementar la clase obstaculo
//Cómo hacer para moverse más rápido?
//Movimientos con polimorfismo
