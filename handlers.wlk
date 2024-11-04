import example.*
import visuales.*
import wollok.game.*

object contador {
  var property puntos = 0
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
  var enGameOver = false

  method agregarNafta(cantidad) {
  if (nafta > 0){
    nafta = 100.min(nafta + cantidad)
    } else if (!enGameOver){
      enGameOver = true
      cartelFinal.iniciar()
    }

  }

  method reiniciarNafta() {
    nafta = 100
    enGameOver = false
  }

  const property celeste = "279df5cc"

  method position () = game.at(0, 0)

  method text() = "       Nafta: " + nafta
  method textColor() = celeste
  
}

class Manejador {
  
  const lista = new List()

  method obtenerLista() = lista
  
  method movimiento() {
    lista.forEach{objeto => objeto.moverseHaciaAbajo()}
  }

  method sacar(){
    lista.forEach{objeto => game.removeVisual(objeto)}
    lista.clear()
  }

}

class ManejadorAutos inherits Manejador {
  method agregarAutosFilaSuperior() {
    const nuevoAuto = new AutoEnemigo ()
    lista.add(nuevoAuto)
    game.addVisual(nuevoAuto)
  }
}

class ManejadorConos inherits Manejador {
  method agregarConosFilaSuperior() {
    const nuevoCono = new Cono ()
    lista.add(nuevoCono)
    game.addVisual(nuevoCono)
  }
}

const manejadorAutos = new ManejadorAutos()
const manejadorConos = new ManejadorConos()

object manejadorColisiones {
    method iniciar(){
        game.onTick(300, "moverAutos", { manejadorAutos.movimiento() })
        game.onTick(300, "moverObstaculos", { manejadorConos.movimiento() })
        game.onTick(100, "aumentarPuntos", { contador.aumentarPuntos() })
        game.onTick(500, "disminuirNafta", { contadorNafta.agregarNafta(-1) })
        game.onTick(300, "moverGasolina", { gasolina.moverseHaciaAbajo() })
    }
}

object cartelFinal{
  var property position = game.at(0,0)
  method image() = "explosion.png"
  method iniciar(){
    game.removeTickEvent("moverAutos")
    game.removeTickEvent("moverObstaculos")
    game.removeTickEvent("aumentarPuntos")
    game.removeTickEvent("disminuirNafta")
    game.removeTickEvent("moverGasolina")
    game.removeVisual(gasolina)
    game.removeVisual(contadorNafta)
    game.removeVisual(contador)
    manejadorAutos.sacar()
    manejadorConos.sacar()
    game.addVisual(self)
    const textoPuntaje = new Texto ( texto = "PUNTAJE: " + contador.puntos(), position = game.at(4,6) )
    game.addVisual(textoGameOver)
    game.addVisual(textoPuntaje)
    game.addVisual(textoReinicio)
    keyboard.r().onPressDo({game.removeVisual(textoPuntaje)
    game.removeVisual(textoGameOver)
    game.removeVisual(textoReinicio)
    game.removeVisual(self)
    reiniciarJuego.iniciar()})
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


object reiniciarJuego{
  method iniciar() {
    contadorNafta.reiniciarNafta()
    manejadorAutos.sacar()
    manejadorConos.sacar()
    contador.puntos(0)
    cargarVisuales.iniciar()
    manejadorColisiones.iniciar()
  }
}