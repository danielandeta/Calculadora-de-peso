.data
.eqv len 10
error: .asciiz "Se ha producido un error"
edad: .asciiz "Ingrese su edad: "
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

main:
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
	li $v0, 4
	la $a0, pi
	syscall 
	jal pi_t
	
	mov.s $f12, $f0
	li $v0, 2
	la $a0, texto 
	li $a1, len
	syscall 
	mov.s $f19, $f12
	li $v0, 4
	la $a0, kg
	syscall
	li $v0, 4
	la $a0, newLine
	syscall
	
	#calculo porcentaje peso ideal
	li $v0, 4
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
	
	#salida
	j exit
pi_t: #imprime calculo peso ideal dependiendo si es hombre o mujer
	addi $sp,$sp,-4
   	sw $ra,($sp)
   	
	beq $s1, $zero, pi_mujer
	#pi hombre
	addi $t0, $t0, 100
	addi $t1, $t1, 150
	addi $t2, $t2, 4
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
	
	lw $ra, ($sp)
	addi $sp,$sp,4
	#--------
	jr $ra
	
pi_mujer:
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
	addi $sp,$sp,-4
   	sw $ra,($sp)
   	l.s $f5, cien
	beq $s1, $zero, ppi_mujer
	
	div.s $f13, $f2, $f12
	mul.s $f13, $f13, $f5
	mov.s $f0, $f13
	lw $ra, ($sp)
	addi $sp,$sp,4
	#--------
	jr $ra

ppi_mujer:
	
	div.s $f13, $f2, $f12
	mul.s $f13, $f13, $f5	
	mov.s $f0, $f13
	jr $ra
	
imc_p:    
	addi $sp,$sp,-4
   	sw $ra,($sp)
 
   	#---------
	mul.s $f3, $f1, $f1 #estatura x estatura
	div.s $f4, $f2, $f3	# peso/estatura2	
	mov.s $f0, $f4
	
	lw $ra, ($sp)
	addi $sp,$sp,4
	#--------
	jr $ra

				
mcm_t:
	#Varon:MCM= PT(kg) x 1.1 - 128 x [PT(kg)/altura(cm)]^2
	#Mujer:MCM PT (kg) x 1.07 - 148 x [PT(kg)/altura(cm)]^2
	addi $sp,$sp,-4
   	sw $ra,($sp)
 
	beq $s1, $zero, mcm_mujer
	
	l.s $f14, c_mcm_v
	#mtc1 $t1, $f14
	l.s $f15, c_mcm_vv
	l.s $f17, diezmil
	mul.s $f16, $f4, $f2	#kg2/m2
	mul.s $f14, $f2, $f14  #kg*1.07
	mul.s $f16, $f16, $f15	#148*kg2/m2
	div.s $f17, $f16, $f17 	#148*kg2/cm2
	sub.s $f17, $f14, $f17   #resta
	mov.s $f0, $f17
	lw $ra, ($sp)
	addi $sp,$sp,4
	#--------
	jr $ra

mcm_mujer:
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
	l.s $f4, c_act_1
	l.s $f5, c_act_2
	l.s $f6, c_act_3
	l.s $f7, c_act_4
	l.s $f9, cien
	mul.s $f8, $f18, $f5
	sub.s $f4, $f4, $f8
	mul.s $f6, $f6, $f1
	mul.s $f6, $f6, $f9
	mul.s $f7, $f7, $f2
	add.s $f7, $f6, $f7
	add.s $f7, $f7, $f4
	mov.s $f0, $f7
	lw $ra, ($sp)
	addi $sp,$sp,4
	#--------
	jr $ra
	
tmb_t:
	addi $sp,$sp,-4
   	sw $ra,($sp)
 
	beq $s1, $zero, tmb_mujer
	
	l.s $f4, diez
	l.s $f5, c_tmb
	l.s $f6, c_tmb_2
	l.s $f7, cien
	l.s $f9, c_tmb_3
	mul.s $f4, $f4, $f2 #10*peso
	mul.s $f5, $f5, $f1 #6.25*estatura
	mul.s $f5, $f5, $f7
	#mul.s $f7, $f5, $f7 #6.25*cm
	mul.s $f8, $f18, $f6 #5*edad
	add.s $f5, $f5, $f4 #6.25*estatura + 10*peso
	#add.s $f8, $f6, $f8 #5+5*edad
	sub.s $f5, $f5, $f8 
	sub.s $f5, $f5, $f9
	mov.s $f0, $f5
	lw $ra, ($sp)
	addi $sp,$sp,4
	#--------
	jr $ra
	
tmb_mujer:
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
	la $a0, dentro
	syscall
	mov.s $f0, $f9
	jr $ra

else_if: 
	l.s $f3, c_tmb_2
	l.s $f7, adelgazar
   	l.s $f8, subir
	add.s $f4, $f19, $f3 #peso ideal +5
 	c.lt.s $f2, $f4 #peso ideal+5 < peso
 	bc1t subir_if
 	mul.s $f9, $f12, $f7
 	li $v0, 4
	la $a0, fuera_up
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
	la $a0, fuera_dowm
	syscall
	mov.s $f0, $f9
	jr $ra	
	
errorf:
	li $v0, 4
	la $a0, error
	syscall	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
