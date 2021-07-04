.data
.eqv len 10

bienvenida: .asciiz "Bienvenidos a la calculadora antropométrica, ingrese los sigueintes datos por favor."
agradecimiento: .asciiz "Gracias por usar nuestra calculadora, te esperamos pronto"
pregunta: .asciiz "Si deseo realizar otro cálculo escriba 1 y si no escriba 0: "
error: .asciiz "Se ha producido un error"
edad: .asciiz "Ingrese su Edad: "
sexo: .asciiz "Si es mujer escriba 0 y si es hombre escriba 1: "
estatura: .asciiz "Ingrese su estatura en m: "
peso: .asciiz "Ingrese su peso en kg: "
pi: .asciiz "Su peso ideal(PI) es: "
ppi: .asciiz "Su porcentaje de peso ideal(PPI) es: "
imc: .asciiz "Su índice de masa corporal(IMC) es: "
asc: .asciiz "Su área de superficie corporal(ASM) es: "
mcm: .asciiz "Su masa corporal magra(MCM) es: "
act: .asciiz "Su agua corporal total(ACT) es: "
tmb: .asciiz "Su tasa metabólica basal(TMB) es: "
dentro: .asciiz "Estás en el rango del peso ideal, su consumo óptimo de calorías al día debe ser de: "
fuera_up: .asciiz "Estás por encima del rango del peso ideal, su consumo óptimo de calorías al día debe ser de: "
fuera_dowm: .asciiz "Estás por debajo del rango del peso ideal, su consumo óptimo de calorías al día debe ser de: "
mantener: .float 1.2
adelgazar: .float 1.02
subir: .float 1.375
diez: .float 10
cien: .float 100
c_tmb: .float 6.25
c_tmb_2: .float 5
c_tmb_3: .float 161
c_mcm_v: .float 1.07
c_mcm_m: .float 1.1
c_mcm_mm: .float 128
c_mcm_vv: .float 148
diezmil: .float 10000
c_act_1: .float 2.447
c_act_2: .float 0.09156
c_act_3: .float 0.1074
c_act_4: .float 0.3362
u_imc: .asciiz " kg/m**2"
lt: .asciiz " litros"
kg: .asciiz " kg"
cal: .asciiz " calorías"
porcentaje: .asciiz " %"
newLine: .asciiz "\n"
texto: .space len
.text
.globl main

#A continuación solicitamos al usuario ingresar los datos que el programa necesita para poder 
#realizar su función, la información que se solicita es la siguiente:

main:
	
	bienvenido:
	la $a0, bienvenida #imprimimos un mensaje de bienvenida antes de empezar.
	li $v0, 4
	syscall	
	li $v0, 4
	la $a0, newLine
	syscall	

	li $v0, 4  #llamado de edad
	la $a0, edad
	syscall
	li $v0, 6
	la $a0, texto 
	li $a1, len
	syscall
	#move $s0, $v0
	mov.s $f18, $f0
	
	li $v0, 4 #llamado de sexo
	la $a0, sexo
	syscall
	li $v0, 5
	la $a0, texto 
	li $a1, len
	syscall
	move $s1, $v0
	
	li $v0, 4 #llamado de estatura
	la $a0, estatura
	syscall
	li $v0, 6
	la $a0, texto 
	li $a1, len
	syscall
	mov.s $f1, $f0
	
	li $v0, 4 #llamado de peso
	la $a0, peso
	syscall
	li $v0, 6
	la $a0, texto 
	li $a1, len
	syscall
	mov.s $f2, $f0
	
	#calculo peso ideal
	li $v0, 4 #Hacemos uso de la pseudoinstrucción li para cargar el número de servicio en el registro $v0
	la $a0, pi
	syscall 
	jal pi_t #Se usa jal para saltar a la función pi_t y traer el valor que esta función retorna
	
	mov.s $f12, $f0 #Con el mov.s movemos un float a un registro.
	
	#Las siguientes líneas son para imprimir los resultados usando las variables 
	#de texto presentadas anteriormente.
	li $v0, 2
	la $a0, texto 
	li $a1, len
	syscall 
	mov.s $f19, $f12 #Con el mov.s movemos un float a un registro.
	li $v0, 4
	la $a0, kg
	syscall
	li $v0, 4
	la $a0, newLine
	syscall
	
	#calculo porcentaje peso ideal
	li $v0, 4 ##Hacemos uso de la pseudoinstrucción li para cargar el número de servicio en el registro $v0
	la $a0, ppi
	syscall 
	jal ppi_t
	mov.s $f12, $f0
	li $v0, 2
	la $a0, texto 
	li $a1, len
	syscall 
	li $v0, 4
	la $a0, porcentaje
	syscall
	li $v0, 4
	la $a0, newLine
	syscall
	
	
	#imprime calculo imc
	li $v0, 4
	la $a0, imc
	syscall 
	
	jal imc_p
	mov.s $f12, $f0
	li $v0, 2
	#s.s $f0, $f12
	#mov.s $f12, $f0
	la $a0, texto 
	li $a1, len
	syscall 
	li $v0, 4
	la $a0, u_imc
	syscall
	li $v0, 4
	la $a0, newLine
	syscall
	
	#calculo mcm 
	li $v0, 4
	la $a0, mcm
	syscall 
	
	jal mcm_t
	mov.s $f12, $f0
	li $v0, 2
	la $a0, texto 
	li $a1, len
	syscall 
	li $v0, 4
	la $a0, kg
	syscall
	li $v0, 4
	la $a0, newLine
	syscall
	
	#calculo act
	li $v0, 4
	la $a0, act
	syscall 
	jal act_t
	li $v0, 2
	mov.s $f12, $f0
	la $a0, texto 
	li $a1, len
	syscall 
	li $v0, 4
	la $a0, lt
	syscall
	li $v0, 4
	la $a0, newLine
	syscall
	
	#calculo tmb
	li $v0, 4
	la $a0, tmb
	syscall 
	jal tmb_t
	li $v0, 2
	mov.s $f12, $f0
	la $a0, texto 
	li $a1, len
	syscall 
	li $v0, 4
	la $a0, newLine
	syscall
	
	#calorias
	 
	jal calorias
	mov.s $f12, $f0
	li $v0, 2
	mov.s $f12, $f0
	la $a0, texto 
	li $a1, len
	syscall 
	li $v0, 4
	la $a0, cal
	syscall
	li $v0, 4
	la $a0, newLine
	syscall
	
	#Aradecimiento por usar el programa.
	la $a0, agradecimiento #imprimimos un mensaje de agradecimienti al finalizar.
	li $v0, 4
	syscall	
	li $v0, 4
	la $a0, newLine
	syscall	
	
	#Aqui implementamos un lazo while donde podremos validar si el usuario quiere o no
	#seguir realizando otro calculo, entra al lazo si el usuario dice si, si dice no, sale del lazo
	
	#pregunta
	li $v0, 4
	la $a0, pregunta
	syscall 
	
	li $v0, 5
	la $a0, texto 
	li $a1, len
	syscall
	move $s2, $v0
	bne $s2, $zero, loop #validamos si la respuesta del usuario no es sero, para seguir dentro del lazo
	#salida
	j exit
	
loop: 
	jal main
pi_t: #imprime calculo peso ideal dependiendo si es hombre o mujer
	addi $sp,$sp,-4 	#hacemos uso del puntero de pila $sp, y con sw almacenamos en memoria los datos, 
	sw $ra,($sp)		#desde el registro de origen $ra y el registro de destino $sp.
   	   	
	beq $s1, $zero, pi_mujer 	#la instrucción comparativa beq que compara $s1 (lo que el usuario ingresa por 
					#consola 1 ó 0) y lo compara con $zero
	#pi hombre
	
	#En las siguientes líneas de código asignamos (100, 150 y 4) a las temporales ($t0, $t1,$t2) respectivamente
	addi $t0, $t0, 100
	addi $t1, $t1, 150
	addi $t2, $t2, 4
	#Luego con mtc1 copiamos ($t0, $t1, $t2) en ($f5,$f8,$f9) respectivamente. 
	#Con cvt.s.w convertimos ($f5,$f8,$f9) de entero a flotante de simple precisión
	mtc1 $t0, $f5
	mtc1 $t1, $f8
	mtc1 $t2, $f9
	cvt.s.w $f5, $f5
	cvt.s.w $f8, $f8
	cvt.s.w $f9, $f9
	
	#operaciones matemáticas de multiplicación (mul.s), resta(sub.s), (div.s)
	mul.s $f6, $f1, $f5
	sub.s $f7, $f6, $f5

	sub.s $f10, $f6, $f8
	div.s $f11, $f10, $f9
	sub.s $f10, $f7, $f11
	
	#copiamos el valor del registro $f10 al registro $f0. Después accedemos al 
	#elemento de la pila con lw y luego lo eliminamos de la pila con addi.

	mov.s $f0, $f10
	
	lw $ra, ($sp)
	addi $sp,$sp,4
	#--------
	jr $ra
	
pi_mujer: #el codigo es similar al pi del hombre, comentado en las lineas anteriores, para referencia.
	addi $t0, $t0, 100
	addi $t1, $t1, 150
	addi $t2, $t2, 2
	mtc1 $t0, $f5
	mtc1 $t1, $f8
	mtc1 $t2, $f9
	cvt.s.w $f5, $f5
	cvt.s.w $f8, $f8
	cvt.s.w $f9, $f9
	mul.s $f6, $f1, $f5
	sub.s $f7, $f6, $f5

	sub.s $f10, $f6, $f8
	div.s $f11, $f10, $f9
	sub.s $f10, $f7, $f11
	mov.s $f0, $f10
	jr $ra
		
ppi_t:
	addi $sp,$sp,-4 	#puntero de pila $sp, y con sw almacenamos en memoria 
				#los datos, desde el registro de origen $ra y el registro de destino $sp
   	sw $ra,($sp)
   	l.s $f5, cien #con l.s cargamos en $f5 el flotante cien
	beq $s1, $zero, ppi_mujer 	#usamos beq para saber qué cálculo realizar dependiendo de lo que 
					#el usuario ingrese por consola, al igual que hicimos con el peso ideal
	
	#operaciones matematicas
	div.s $f13, $f2, $f12
	mul.s $f13, $f13, $f5
	mov.s $f0, $f13
	lw $ra, ($sp)
	addi $sp,$sp,4
	#--------
	jr $ra

ppi_mujer:#referencia en el codigo anterior, ppi_hombre
	
	div.s $f13, $f2, $f12
	mul.s $f13, $f13, $f5	
	mov.s $f0, $f13
	jr $ra
	
imc_p:    
	#puntero de pila $sp, y con sw almacenamos en memoria los datos, 
	#desde el registro de origen $ra y el registro de destino $sp.
	addi $sp,$sp,-4
   	sw $ra,($sp)
 
   	#---------
	mul.s $f3, $f1, $f1 #estatura x estatura
	div.s $f4, $f2, $f3	# peso/estatura2	
	mov.s $f0, $f4 #movemos el resultado al registro $f0
	
	#accedemos al elemento de la pila con lw y luego lo eliminamos de la pila con addi
	lw $ra, ($sp)
	addi $sp,$sp,4
	#--------
	jr $ra

				
mcm_t:
	#Varon:MCM= PT(kg) x 1.1 - 128 x [PT(kg)/altura(cm)]^2
	#Mujer:MCM PT (kg) x 1.07 - 148 x [PT(kg)/altura(cm)]^2
	
	#puntero de pila $sp, y con sw almacenamos en memoria los datos, desde el 
	#registro de origen $ra y el registro de destino $sp
	addi $sp,$sp,-4
   	sw $ra,($sp)
 
	beq $s1, $zero, mcm_mujer #instrucción comparativa beq que compara $s1 (lo que el usuario ingresa por consola
	
	l.s $f14, c_mcm_v
	#mtc1 $t1, $f14
	#instrucción l.s para cargar en el registro las variables c_mcm_v y c_mcm_mm dependiendo el caso
	l.s $f15, c_mcm_vv
	l.s $f17, diezmil
	#operaciones matematicas
	mul.s $f16, $f4, $f2	#kg2/m2
	mul.s $f14, $f2, $f14  #kg*1.07
	mul.s $f16, $f16, $f15	#148*kg2/m2
	div.s $f17, $f16, $f17 	#148*kg2/cm2
	sub.s $f17, $f14, $f17   #resta
	mov.s $f0, $f17 #guardamos el resultado en $f0
	lw $ra, ($sp)
	addi $sp,$sp,4
	#--------
	jr $ra

mcm_mujer: #codigo anterior como referencia, el codigo es similar
	l.s $f14, c_mcm_m
	#mtc1 $t1, $f14
	l.s $f15, c_mcm_mm
	l.s $f17, diezmil
	mul.s $f16, $f4, $f2	#kg2/m2
	mul.s $f14, $f2, $f14  #kg*1.07
	mul.s $f16, $f16, $f15	#148*kg2/m2
	div.s $f17, $f16, $f17 	#148*kg2/cm2
	sub.s $f17, $f14, $f17   #resta
	mov.s $f0, $f17
	jr $ra	
	
act_t: 
	#2.447 - (0.09156 * Edad) + (0.1074 * Estatura) + (0.3362 * Peso)
	addi $sp,$sp,-4
   	sw $ra,($sp)
   	#con la instrucción l.s cargamos los valores de (c_act1, c_act2, c_act3, c_act4, cien) en 
   	#los registros ($f4,$f5,$f6,$f7,$f9) respectivamente
	l.s $f4, c_act_1
	l.s $f5, c_act_2
	l.s $f6, c_act_3
	l.s $f7, c_act_4
	l.s $f9, cien
	#operaciones matematicas
	mul.s $f8, $f18, $f5
	sub.s $f4, $f4, $f8
	mul.s $f6, $f6, $f1
	mul.s $f6, $f6, $f9
	mul.s $f7, $f7, $f2
	add.s $f7, $f6, $f7
	add.s $f7, $f7, $f4
	mov.s $f0, $f7 #guardamos el resultado en $f0
	#accedemos al elemento de la pila con lw y luego lo eliminamos de la pila con addi.
	lw $ra, ($sp)
	addi $sp,$sp,4
	#--------
	jr $ra
	
tmb_t:
	addi $sp,$sp,-4
   	sw $ra,($sp)
 
	beq $s1, $zero, tmb_mujer #instrucción comparativa beq que compara $s1 (lo que el usuario ingresa por consola
	#cargamos los valores de (diez, c_tmb, c_tmb_2, cien, c_tmb_3) en los registros ($f4,$f5,$f6,$f7,$f9) respectivamente
	l.s $f4, diez
	l.s $f5, c_tmb
	l.s $f6, c_tmb_2
	l.s $f7, cien
	l.s $f9, c_tmb_3
	#operaciones matematicas
	mul.s $f4, $f4, $f2 #10*peso
	mul.s $f5, $f5, $f1 #6.25*estatura
	mul.s $f5, $f5, $f7
	#mul.s $f7, $f5, $f7 #6.25*cm
	mul.s $f8, $f18, $f6 #5*edad
	add.s $f5, $f5, $f4 #6.25*estatura + 10*peso
	#add.s $f8, $f6, $f8 #5+5*edad
	sub.s $f5, $f5, $f8 
	sub.s $f5, $f5, $f9
	mov.s $f0, $f5 #guardamos el resultado en $f0
	#accedemos al elemento de la pila con lw y luego lo eliminamos de la pila con addi.
	lw $ra, ($sp)
	addi $sp,$sp,4
	#--------
	jr $ra
	
tmb_mujer: #codigo de arriba sirve de referencia para este codigo
	l.s $f4, diez
	l.s $f5, c_tmb
	l.s $f6, c_tmb_2
	l.s $f7, cien
	mul.s $f4, $f4, $f2 #10*peso
	mul.s $f5, $f5, $f1 #6.25*estatura
	mul.s $f5, $f5, $f7 #6.25*cm
	mul.s $f8, $f18, $f6 #5*edad
	add.s $f5, $f5, $f4 #6.25*estatura + 10*peso
	#add.s $f8, $f6, $f8 #5+5*edad
	sub.s $f5, $f5, $f8 
	add.s $f5, $f5, $f6
	mov.s $f0, $f5
	jr $ra
	
exit: 
	li $v0, 10
	syscall

calorias:
	addi $sp,$sp,-4
   	sw $ra,($sp)
   	#cargamos los valores de (c_tmb_2, mantener) en los registros ($f3,$f6) respectivamente
   	l.s $f3, c_tmb_2
   	l.s $f6, mantener
 	add.s $f4, $f19, $f3 #peso ideal +5
 	sub.s $f5, $f19, $f3 #peso ideal -5
 	c.lt.s $f4, $f2 #peso< peso ideal+5
	bc1t else_if
	c.lt.s $f2, $f5 #peso >peso ideal-5
	bc1t else_if
	mul.s $f9, $f12, $f6
	li $v0, 4
	la $a0, dentro #indicamos que el peso es el recomendado
	syscall
	mov.s $f0, $f9
	jr $ra

else_if:#codigo de arriba como referencia para este codigo 
	
	l.s $f3, c_tmb_2
	l.s $f7, adelgazar
   	l.s $f8, subir
	add.s $f4, $f19, $f3 #peso ideal +5
 	c.lt.s $f2, $f4 #peso ideal+5 < peso
 	bc1t subir_if
 	mul.s $f9, $f12, $f7
 	li $v0, 4
	la $a0, fuera_up #indicamos que hay sobrepeso
	syscall
	mov.s $f0, $f9
	jr $ra
subir_if: 
	l.s $f3, c_tmb_2
   	l.s $f8, subir
 	sub.s $f5, $f19, $f3 #peso ideal -5
 	c.lt.s $f5, $f2 #peso < peso ideal -5
 	bc1t errorf
 	mul.s $f9, $f12, $f8
 	li $v0, 4
	la $a0, fuera_dowm #indicamos que esta falto de peso
	syscall
	mov.s $f0, $f9
	jr $ra	
	

errorf:
	li $v0, 4
	la $a0, error #imprimimos un error en caso de existir
	syscall	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
