import example.*
import wollok.game.*
import handlers.*

object cargarVisuales {
    method iniciar() {
        game.addVisualCharacter(auto)
        game.addVisual(contador)
        game.addVisual(contadorNafta)

        game.schedule(300, {manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()
        })

        game.schedule(1200, {manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()
        })

        game.schedule(2100, {manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()
        })

        game.schedule(3000, {manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()
        manejadorAutos.agregarAutosFilaSuperior()
        })

        game.schedule(3300, {game.addVisual(gasolina)})

        game.schedule(1500, {manejadorObstaculos.agregarObstaculos()
        manejadorObstaculos.agregarObstaculos()
        })

        game.schedule(3300, {manejadorObstaculos.agregarObstaculos()
        manejadorObstaculos.agregarObstaculos()
        })
    }
}