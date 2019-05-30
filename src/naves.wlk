class NaveEspacial {
	var velocidad = 0
	var direccion = 0	
	var combustible = 0
	
	method velocidad(cuanto) { velocidad = cuanto }
	method acelerar(cuanto) { velocidad = (velocidad + cuanto).min(100000) }
	method desacelerar(cuanto) { velocidad -= cuanto .max(0)}
	
	method irHaciaElSol() { direccion = 10 }
	method escaparDelSol() { direccion = -10 }
	method ponerseParaleloAlSol() { direccion = 0 }
	
	method acercarseUnPocoAlSol() { direccion += 1 }
	method alejarseUnPocoDelSol() { direccion -= 1 }
	
	method cargarCombustible(cantidad){combustible+=cantidad}
	method descargarCombustible(cantidad){combustible-=cantidad}
	
	method prepararViaje(){self.cargarCombustible(30000)
		self.acelerar(5000)
		
	}
	method estaTranquila(){return combustible>=4000 && velocidad <=12000}
	
}

class NaveBaliza inherits NaveEspacial{
	var color
	method cambiarColorDeBaliza(colorNuevo){color=colorNuevo}
	override method prepararViaje(){
		super()
		color="Verde"
		direccion=10
	}
	method escapar(){direccion=10}
	method avisar(){color="Rojo"}
	method recibirAmenaza(){self.escapar()
		self.avisar()
	}
	override method estaTranquila(){return super() && color!="Rojo"}
	
}

class NavePasajeros inherits NaveEspacial{
	const property  pasajeros
	var racionesComidas=0
	var racionesBebidas=0
	
	method cargarComidas(raciones){racionesComidas+=raciones}
	method descargarComidas(raciones){racionesComidas-=raciones}
	method cargarBebidas(raciones){racionesBebidas+=raciones}
	method descargarBebidas(raciones){racionesBebidas-=raciones}
	override method prepararViaje(){
		super()
		racionesComidas=4*pasajeros
		racionesBebidas=6*pasajeros
		self.acercarseUnPocoAlSol()
	}
	method escapar(){velocidad=velocidad*2}
	method avisar(){racionesBebidas-=2*pasajeros
		racionesComidas-=1*pasajeros
	}
	method recibirAmenaza(){self.escapar()
		self.avisar()
	}
}

class NaveCombate inherits NaveEspacial{
	var esVisible
	var misilesDesplegados
	var mensajes=[]
	
	method ponerseVisible(){esVisible=true}
	method ponerseInvisible(){esVisible=false}
	method estaInvisible(){return not esVisible}
	method desplegarMisiles(){misilesDesplegados=true}
	method replegarMisiles(){misilesDesplegados=false}
	method misilesDesplegados(){return misilesDesplegados}
	method emitirMensaje(mensaje){mensajes.add(mensaje)}
	method mensajesEmitidos(){return mensajes}
	method primerMensajeEmitido(){return mensajes.first()}
	method ultimoMensajeEmitido(){return mensajes.last()}
	method esEscueta(){return not mensajes.any{mensaje=>mensaje.size()>30}}
	method emitioMensaje(mensaje){return mensajes.find(mensaje)}
	override method prepararViaje(){
		super()
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en mision")
	}
	method escapar(){self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
	}
	method avisar(){mensajes.add("Amenaza recibida")}
	method recibirAmenaza(){self.escapar()
		self.avisar()
	}
	override method estaTranquila(){return super() && misilesDesplegados}
}


class NaveHospital inherits NavePasajeros{
	var quirofanoPreparado=false
	
	override method recibirAmenaza(){
		super()
		quirofanoPreparado=true	
	}
	
}

class NavecombateSigilosa inherits NaveCombate{
	override method recibirAmenaza(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
}
