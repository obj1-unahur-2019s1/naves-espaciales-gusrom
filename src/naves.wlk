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
	method escapar()
	method avisar()
	method recibirAmenaza(){self.escapar()
		self.avisar()
	}
	
}

class NaveBaliza inherits NaveEspacial{
	var property color = "Verde"
	method cambiarColorDeBaliza(colorNuevo){color=colorNuevo}
	override method prepararViaje(){
		super()
		self.cambiarColorDeBaliza("Verde")
		self.ponerseParaleloAlSol()
	}
	override method escapar(){self.irHaciaElSol()}
	override method avisar(){self.cambiarColorDeBaliza("Rojo")}
	override method estaTranquila(){return super() && color!="Rojo"}
	
}

class NavePasajeros inherits NaveEspacial{
	const property  pasajeros
	var property racionesComidas=0
	var property racionesBebidas=0
	
	method cargarComidas(raciones){racionesComidas+=raciones}
	method descargarComidas(raciones){racionesComidas-=raciones}
	method cargarBebidas(raciones){racionesBebidas+=raciones}
	method descargarBebidas(raciones){racionesBebidas-=raciones}
	override method prepararViaje(){
		super()
		self.cargarComidas(4*pasajeros)
		self.cargarBebidas(6*pasajeros)
		self.acercarseUnPocoAlSol()
	}
	override method escapar(){self.acelerar(velocidad)}
	override method avisar(){self.descargarBebidas(2*pasajeros)
		self.descargarComidas(1*pasajeros)
	}
	
}

class NaveCombate inherits NaveEspacial{
	var property esVisible=false
	var property misilesDesplegados=false
	var property mensajes=[]
	
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
	method emitioMensaje(mensaje){return mensajes.contains(mensaje)}
	override method prepararViaje(){
		super()
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en mision")
	}
	override method escapar(){self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
	}
	override method avisar(){mensajes.add("Amenaza recibida")}
	
	override method estaTranquila(){return super() && not misilesDesplegados}
}


class NaveHospital inherits NavePasajeros{
	var property quirofanoPreparado=false
	
	override method recibirAmenaza(){
		super()
		quirofanoPreparado=true	
	}
	override method estaTranquila(){return not quirofanoPreparado}
}

class NavecombateSigilosa inherits NaveCombate{
	override method escapar(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
	override method estaTranquila(){return super() && not esVisible}
}
