import example.*
import visuales.*

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

  method agregarNafta(cantidad) {
  if (nafta > 0){
    nafta = 100.min(nafta + cantidad)
    } else {
      cartelFinal.iniciar()
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

  method sacarAutos(){
    autos.forEach{autoEnemigo => game.removeVisual(autoEnemigo)}
    autos.clear()
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
  
  method sacarObstaculos(){
    obstaculos.forEach{obstaculo => game.removeVisual(obstaculo)}
    obstaculos.clear()
  }
}

object manejadorColisiones {
    method iniciar(){
        game.onTick(300, "moverAutos", { manejadorAutos.paraCadaAuto() })
        game.onTick(300, "moverGasolina", { gasolina.moverseHaciaAbajo() })
        game.onTick(300, "moverObstaculos", { manejadorObstaculos.paraCadaObstaculo() })
        game.onTick(100, "aumentarPuntos", { contador.aumentarPuntos() })
        game.onTick(1000, "disminuirNafta", { contadorNafta.agregarNafta(-2) })
    }

}

object cartelFinal{
    var property position = game.origin()
    method image() = "gameover.png"
    method iniciar(){
      game.removeVisual(gasolina)
        game.removeTickEvent("moverAutos")
        game.removeTickEvent("moverGasolina")
        game.removeTickEvent("moverObstaculos")
        game.removeTickEvent("aumentarPuntos")
        game.removeTickEvent("disminuirNafta")
        manejadorAutos.sacarAutos()
        manejadorObstaculos.sacarObstaculos()
        game.removeVisual(contadorNafta)
        game.removeVisual(contador)
        game.addVisual(self)
        game.addVisual(textoGameOver)
        game.addVisual(textoPuntaje)
        game.addVisual(textoReinicio)
    }
}

object textoGameOver {
  const property negro = "000000e8"
  method textColor() = negro
  method text () = "GAME OVER" 
  method position() = game.at(4, 7)
}

object textoPuntaje {
  const property negro = "000000e8"
  method textColor() = negro
  method text () = "PUNTAJE: " + contador.puntos() 
  method position() = game.at(4, 6)
}

object textoReinicio {
  const property negro = "000000e8"
  method textColor() = negro
  method text () = "PRESIONE R PARA REINICIAR"
  method position() = game.at(4, 5)
}

object reiniciarJuego{
  method iniciar() {
    game.removeVisual(cartelFinal)
    game.removeVisual(textoGameOver)
    game.removeVisual(textoPuntaje)
    game.removeVisual(textoReinicio)
    contadorNafta.agregarNafta(100)
    contador.puntos(0)
    gasolina.restaurarUbicacion()
    game.schedule(300, {
      cargarVisuales.iniciar()
      manejadorColisiones.iniciar()
    })
  }
}