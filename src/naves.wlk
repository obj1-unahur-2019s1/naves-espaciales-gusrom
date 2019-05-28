class NaveEspacial {
	var velocidad = 0
	var direccion = 0	
	
	method velocidad(cuanto) { velocidad = cuanto }
	method acelerar(cuanto) { velocidad = (velocidad + cuanto).min(100000) }
	method desacelerar(cuanto) { velocidad -= cuanto .max(0)}
	
	method irHaciaElSol() { direccion = 10 }
	method escaparDelSol() { direccion = -10 }
	method ponerseParaleloAlSol() { direccion = 0 }
	
	method acercarseUnPocoAlSol() { direccion += 1 }
	method alejarseUnPocoDelSol() { direccion -= 1 }
}

class NaveBaliza inherits NaveEspacial{
	var color
	method cambiarColorDeBaliza(colorNuevo){color=colorNuevo}
}

class NavePasajeros inherits NaveEspacial{
	const property  pasajeros
	var racionesComidas=0
	var racionesBebidas=0
	
	method cargarComidas(raciones){racionesComidas+=raciones}
	method descargarComidas(raciones){racionesComidas-=raciones}
	method cargarBebidas(raciones){racionesBebidas+=raciones}
	method descargarBebidas(raciones){racionesBebidas-=raciones}
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
	
	
	
	
	
}