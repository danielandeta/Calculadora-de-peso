.data
.eqv len 10
edad: .asciiz "Ingrese su edad: "
sexo: .asciiz "Si es mujer escriba m y si es hombre escriba h: "
estatura: .asciiz "Ingrese su estatura en m: "
peso: .asciiz "Ingrese su peso en kg: "
pi: .asciiz "Su peso ideal (PI) es: "
ppi: .asciiz "Su porcentaje de peso ideal (PPI) es: "
imc: .asciiz "Su índice de masa corporal (IMC) es: "
asc: .asciiz "Su (ASM) es: "
mcm: .asciiz "Su (MCM) es: "
act: .asciiz "Su (ACT) es: "
cal: .asciiz "Necesita "
newLine: .asciiz "\n"
texto: .space len
.text
.globl main

main:
	li $v0, 4  #llamado de edad
	la $a0, edad
	syscall
	li $v0, 5
	la $a0, texto 
	li $a1, len
	syscall
	move $s0, $v0
	
	li $v0, 4 #llamado de sexo
	la $a0, sexo
	syscall
	li $v0, 8
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
	move $s3, $v0

	
	li $v0, 2
	mov.s $f12, $f1
	syscall
	
	
imc_p:    
	cvt.s.w $f0, $f0 #uso s ya que estoy trabajando con float
	mul.s $f1, $f0, $f0 #estatura x estatura
	li $v0, 2
	mov.s $f7, $f1
	syscall
	mtc1 $s3, $f2 #convierte el entero a float 
	cvt.s.w $f2, $f2 #uso s ya que estoy trabajando con float
	div.s $f5, $f3, $f1	# peso/estatura2	
	#mflo $f4
	li $v0, 2
	mov.s $f12, $f5 
	syscall 
	li $v0, 4
	la $a0, imc
	syscall 
	#move $a0, $t1 #resta de aleatorio mayor menos el input
	#li $v0, 2
	#syscall 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	