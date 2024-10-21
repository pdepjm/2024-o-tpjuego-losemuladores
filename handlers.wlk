import example.*

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
  var property nafta = 100

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

  /*
  method sacarAutos(){
    autos.forEach{autoEnemigo => game.removeVisual(autoEnemigo)}
  }
  */
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

  /*
  method sacarObstaculos(){
    obstaculos.forEach{obstaculo => game.removeVisual(obstaculo)}
  }
  */
}

object manejadorColisiones {
    method iniciar(){
        game.onTick(300, "moverAutos", { manejadorAutos.paraCadaAuto() })
        game.onTick(300, "moverGasolina", { gasolina.moverseHaciaAbajo() })
        game.onTick(300, "moverObstaculos", { manejadorObstaculos.paraCadaObstaculo() })
        game.onTick(100, "aumentarPuntos", { contador.aumentarPuntos() })
        game.onTick(1000, "disminuirNafta", { contadorNafta.agregarNafta(-2) })
        game.onCollideDo(auto, {visual => visual.chocar()})
    }

}

/*object sonidoExplosion{
    method play(){
    game.sound("explosion.wav").play()
  }
}
*/
object cartelFinal{
    var property position = game.origin()

    method image() = "gameover.png"
    method text () = "GAME OVER"
    method iniciar(){
        game.addVisual(self)
        //sonidoExplosion.play()
        game.schedule(300, {game.stop()})
    }
}
/*
program soundProgram {

  const rain = game.sound("light-rain.mp3")
  rain.shouldLoop(true)
  game.schedule(500, { rain.play()} )
  game.start()
}


object reiniciarJuego{
  method iniciar() {
    game.start()
    game.clear()
    game.removeVisual(cartelFinal)
    contadorNafta.nafta(100)
    contador.puntos(0)
    manejadorAutos.sacarAutos()
    manejadorObstaculos.sacarObstaculos()
    gasolina.restaurarUbicacion()
  }
}
*/