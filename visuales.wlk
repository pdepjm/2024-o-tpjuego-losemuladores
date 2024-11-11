import handlers.*
import example.*
import wollok.game.*

object cargarVisuales {
    method iniciar() {
        game.addVisual(contador)
        game.addVisual(contadorNafta)
        manejadorAutos.sacar()
        manejadorConos.sacar()

        [300, 1200, 2100, 3000].forEach({tiempo => scheduleAutos.iniciar(tiempo)})
        [1500, 3300].forEach({tiempo => scheduleObstaculo.iniciar(tiempo)})
        game.schedule(3600, {gasolina.restaurarUbicacion()
        game.addVisual(gasolina)} )  
    }
}


object scheduleAutos {
    method iniciar(contador){
        game.schedule(contador, {manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()})
    }
}

object scheduleObstaculo {
    method iniciar(contador){
        game.schedule(contador, {manejadorConos.agregarConosFilaSuperior()
        manejadorConos.agregarConosFilaSuperior()})
    }
}

/*
object cartelInicial {
  var property position = game.at(0, 0) 
  
  method image() = "cartelinicial.png"

  method iniciar() {
    game.addVisual(self)    
  }
}*/

object cartelFinal {
  var property position = game.at(0, 0)
  var textoPuntaje = null      
  method image() = "explosion.png"
  
  method iniciar() {
    estadoJuego.pausarJuego() 
    self.limpiarJuego()              

    const puntajeActual = contador.puntos()
    textoPuntaje = new Texto(texto = "PUNTAJE: " + puntajeActual, position = game.at(4, 6))
    
    game.addVisual(self)
    game.addVisual(textoGameOver)
    game.addVisual(textoPuntaje)
    game.addVisual(textoReinicio)
    
    keyboard.r().onPressDo ({
      if (estadoJuego.estaPausado()) {
        self.limpiarJuego()            
        reiniciarJuego.iniciar()   
      }
    })
  }

  method limpiarJuego() {
    game.removeVisual(self)
    game.removeVisual(gasolina)
    game.removeVisual(contadorNafta)
    game.removeVisual(contador)
    game.removeVisual(textoGameOver)
    if (textoPuntaje != null) {   
      game.removeVisual(textoPuntaje)
      textoPuntaje = null          
    }
    game.removeVisual(textoReinicio)
    manejadorAutos.sacar()
    manejadorConos.sacar()

    game.removeTickEvent("moverAutos")
    game.removeTickEvent("moverObstaculos")
    game.removeTickEvent("aumentarPuntos")
    game.removeTickEvent("disminuirNafta")
    game.removeTickEvent("moverGasolina")
  }
}



class Texto {
  const texto
  var property position
  const property negro = "000000e8"

  method textColor() = negro
  method text() = texto
}

const textoGameOver = new Texto ( texto = "GAME OVER", position = game.at(4,7) )
const textoReinicio = new Texto( texto = "PRESIONE R PARA REINICIAR" , position = game.at(4,5) )

