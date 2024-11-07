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
        game.addVisual(gasolina)})
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

object cartelFinal {
  var property position = game.at(0, 0)
  var textoPuntaje = null      
  method image() = "explosion.png"
  
  method iniciar() {
    estadoJuego.pausarJuego() 
    self.limpiarJuego()              

    // Capturar el puntaje y mostrarlo inmediatamente
    const puntajeActual = contador.puntos()
    textoPuntaje = new Texto(texto = "PUNTAJE: " + puntajeActual, position = game.at(4, 6))
    
    // Agregar visuales para el estado de fin del juego
    game.addVisual(self)
    game.addVisual(textoGameOver)
    game.addVisual(textoPuntaje)
    game.addVisual(textoReinicio)
    
    keyboard.r().onPressDo ({
      if (estadoJuego.estaPausado()) {
        self.limpiarJuego()             // Limpiar visuales y eventos de nuevo antes de reiniciar
        reiniciarJuego.iniciar()   // Reiniciar el juego
      }
    })
  }

  // Método para limpiar visuales y eventos
  method limpiarJuego() {
    game.removeVisual(self)
    game.removeVisual(gasolina)
    game.removeVisual(contadorNafta)
    game.removeVisual(contador)
    game.removeVisual(textoGameOver)
    if (textoPuntaje != null) {   // Remover textoPuntaje si existe
      game.removeVisual(textoPuntaje)
      textoPuntaje = null          // Restablecer textoPuntaje a null
    }
    game.removeVisual(textoReinicio)
    manejadorAutos.sacar()
    manejadorConos.sacar()

    // Remover cualquier evento de tick o programado
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

