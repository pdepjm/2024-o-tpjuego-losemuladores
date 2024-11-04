import example.*
import wollok.game.*
import handlers.*

object cargarVisuales {
    method iniciar() {
        game.removeVisual(contadorNafta)
        game.removeVisual(contador)
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