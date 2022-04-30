/*==================================================
project:       Herramientas de programación para el análisis de datos
Dependencies:  Universidad de los Andes
----------------------------------------------------

==================================================*/

/*==================================================
              0: Program set up
==================================================*/
	
	version 16
	drop _all
	clear all
	macro drop _all
	
	*Directory Paths
	
	*Fayber
	if "`c(username)'"=="VEW0102"{
		global dir C:\Users\VEW0102\Universidad de los Andes\Alfredo Eleazar Orozco Quesada - Curso Programación para datos EdContinua\Clases\Implementación\Clase 13 - Taller
	}
	else if "`c(username)'"=="magse" {  
	    global dir C:\Users\magse\Universidad de los Andes\Alfredo Eleazar Orozco Quesada - Curso Programación para datos EdContinua\Clases\Implementación\Clase 13 - Taller
	}
	
/*==================================================
				1: Consolidar datos
==================================================*/

*----------1.1: Unir datos de personas y hogares de zonas urbanas y rurales

	foreach base in U R {
		use "${dir}/`base'personas", clear
		merge m:1 llave_n16 using "${dir}/`base'hogar", nogen keep(3)
		save "${dir}/`base'", replace
	}

*----------1.2: Unir las dos bases
	append using "${dir}/U"

*----------1.3: Dejar las variables importantes
	rename sexo	mujer
	global vars hoy_fuma come_paquete come_fritos hospital_veces ehace_deporte 	///
		zona edad mujer hijos_vivos sp_estrato t_personas tercil2016 ha_fumado 	///
		hijos_vivos dias_noasistio afiliacion
	keep $vars
	
/*==================================================
              2: Editar variables
==================================================*/

*----------2.1: Reemplazar valores faltantes
	replace zona=0 if zona==.

	label define zona 0 "Rural" 1 "Urbano", modify
	label values zona zona
			
*----------2.2: Variables de sí y no
	local vars ha_fumado come_paquete come_fritos hijos_vivos
	
	recode `vars' (2=0)
		
		label define no_si 0 "No" 1 "Sí", modify
		label values `vars' no_si

*----------2.3: Variable mujer
	recode mujer (1=0) (2=1)

	label define mujer 0 "Hombre" 1 "Mujer", modify
	label values mujer mujer
	
/*==================================================
              3: Estadísticas descriptivas 
==================================================*/

*----------3.1: Tablas
	sum $vars
	
	*Tabla de frecuencias
	tab hoy_fuma

*----------3.2: Gráficos	

	graph bar edad, over(hoy_fuma) graphregion(colo(white)) ytitle("Promedio edad") name(edad_hoy_fuma, replace)
	
	graph bar dias_noasistio, over(hoy_fuma) graphregion(colo(white)) ytitle("Promedio días") name(dias_noasistiohoy_fuma, replace)
	
	graph box t_personas
	
	
/*==================================================
				4: Regresión
==================================================*/

*----------4.1: Correlación
	pwcorr dias_noasistio ha_fumado tercil2016 edad mujer t_personas, star(.05)

*----------4.2: Regresión
	reg dias_noasistio ha_fumado i.tercil2016 edad mujer t_personas 

	