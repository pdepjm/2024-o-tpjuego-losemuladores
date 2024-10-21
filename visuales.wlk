import example.*
import wollok.game.*
import handlers.*

object cargarVisuales {
    const tiemposAuto = [300, 1200, 2100, 3000]
    const tiemposObstaculo = [1500, 3300]

    method iniciar() {
        game.addVisual(contador)
        game.addVisual(contadorNafta)   

        tiemposAuto.forEach({tiempo => scheduleAutos.iniciar(tiempo)})
        tiemposObstaculo.forEach({tiempo => scheduleObstaculo.iniciar(tiempo)})
        game.schedule(3300, {game.addVisual(gasolina)})
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
        game.schedule(contador, {manejadorObstaculos.agregarObstaculos()
        manejadorObstaculos.agregarObstaculos()})
    }
}