class NaveDeCarga {

	var property velocidad = 0
	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	method recibirAmenaza() {
		carga = 0
	}
	
	method enFalta() = self.sobrecargada() and self.excedidaDeVelocidad()
	
	method acercamientoDeControl() {
		if (self.enFalta()) {
			self.recibirAmenaza()
		}
	}

}

class NaveDePasajeros {

	var property velocidad = 0
	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaPermitida() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaPermitida() or alarma

	method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate {
	var property velocidad = 0
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

}

class Nave{
	var property velocidad

	//usar metodo de velocidad maxima y min y max
	method propulsar() {
	  if(velocidad <= 280000){
		velocidad = velocidad + 20000
	  }else{
		velocidad = 300000
	  }
	}
}

class NaveCombate inherits Nave{

}

class NavePasajeros inherits Nave{
	var property cantidadPersonas 
	var alarmaEmergencia = true
	
	method recibirAmenaza(){
		alarmaEmergencia = true
	}


}

class NaveResiduosRadioactivos inherits NaveDeCarga{
	method recibirAmenaza() {
	  velocidad = 0
	}
}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

}
