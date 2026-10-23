class Nave {
	var property velocidad
	var property maximoVelocidad = 300000
	
	method propulsar() {
		if (self.velocidad() <= (maximoVelocidad - 20000)) {
			velocidad += 20000
		} else {
			velocidad = maximoVelocidad
		}
	}
	
	method prepararParaViajar() {
		if (self.velocidad() <= (maximoVelocidad - 15000)) {
			velocidad += 15000
		} else {
			velocidad = maximoVelocidad
		}
	}
}

class NaveDeResiduosRadioactivos inherits NaveDeCarga {
	var property selladaAlVacio = false
	
	override method recibirAmenaza() {
		velocidad = 0
	}
	
	override method prepararParaViajar() {
		if (self.velocidad() <= (maximoVelocidad - 15000)) {
			velocidad += 15000
		} else {
			velocidad = maximoVelocidad
		}
		
		selladaAlVacio = true
	}
}

class NaveDeCarga inherits Nave {
	var property carga = 0
	
	method sobrecargada() = carga > 100000
	
	method excedidaDeVelocidad() = velocidad > 100000
	
	method recibirAmenaza() {
		carga = 0
	}
	
	method enFalta() = self.sobrecargada() and self.excedidaDeVelocidad()
	
	method acercamientoDeControl() {
		if (self.enFalta()) self.recibirAmenaza()
	}
}

class NaveDePasajeros inherits Nave {
	var property alarma = false
	const cantidadDePasajeros = 0
	
	method tripulacion() = cantidadDePasajeros + 4
	
	method velocidadMaximaPermitida() = (300000 / self.tripulacion()) - if (cantidadDePasajeros > 100)
	                                                                    	200
	                                                                    else 0
	
	method estaEnPeligro() = (velocidad > self.velocidadMaximaPermitida()) or alarma
	
	method recibirAmenaza() {
		alarma = true
	}
}

class NaveDeCombate inherits Nave {
	var property modo = reposo
	const property mensajesEmitidos = []
	
	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()
	
	method estaInvisible() = (velocidad < 10000) and modo.invisible()
	
	method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}
	
	override method prepararParaViajar() {
		if (self.velocidad() <= (maximoVelocidad - 15000)) {
			velocidad += 15000
		} else {
			velocidad = maximoVelocidad
		}
		
		self.emitirMensajeDeViaje()
	}
	
	method emitirMensajeDeViaje() {
		if (modo == ataque) self.emitirMensaje("Volviendo a la base")
		else self.emitirMensaje("Saliendo en misión")
	}
}

object reposo {
	method invisible() = false
	
	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}
}

object ataque {
	method invisible() = true
	
	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}
}