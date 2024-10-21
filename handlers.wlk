import example.*

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

  method agregarNafta(cantidad) {
    nafta = nafta + cantidad
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

object manejadorColisiones {
    method iniciar(){
        game.onTick(300, "moverAutos", { manejadorAutos.paraCadaAuto() })
        game.onTick(300, "moverGasolina", { gasolina.moverseHaciaAbajo() })
        game.onTick(300, "moverObstaculos", { manejadorObstaculos.paraCadaObstaculo() })
        game.onTick(100, "contadores", { contador.aumentarPuntos() })
        game.onTick(1000, "contadores", { contadorNafta.perderNafta() })
        game.onCollideDo(auto, {visual => visual.chocar()})
    }

}

/*object sonidoExplosion{
    method play(){
    game.sound("explosion.wav").play()
  }
}
object cartelFinal{
    var position = game.center()
    method image() = "gameover.png"
    method text () = "GAME OVER"
    method iniciar(){
        game.addVisual(self)
        sonidoExplosion.play()
        game.stop()
    }
}
program soundProgram {

  const rain = game.sound("light-rain.mp3")
  rain.shouldLoop(true)
  game.schedule(500, { rain.play()} )
  game.start()
}
*/