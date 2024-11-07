import audio.*
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
      sonidoColision.iniciarColision()
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

object reiniciarJuego{
  method iniciar() {
    contadorNafta.reiniciarNafta()
    manejadorAutos.sacar()
    manejadorConos.sacar()
    contador.puntos(0)
    cargarVisuales.iniciar()
    manejadorColisiones.iniciar()
    estadoJuego.reanudarJuego()

  }
}

object estadoJuego {
  var property enPausa = false  

  method pausarJuego() {
    enPausa = true
  }

  method reanudarJuego() {
    enPausa = false
  }

  method estaPausado() = enPausa
}