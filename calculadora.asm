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
	mov.s $f2, $f0

	
	li $v0, 2
	mov.s $f12, $f1
	syscall
	
	
imc_p:    
	mul.s $f1, $f1, $f1 #estatura x estatura
	div.s $f3, $f2, $f1	# peso/estatura2	
	
	li $v0, 4
	la $a0, imc
	syscall 
	li $v0, 2
	mov.s $f12, $f3
	la $a0, texto 
	li $a1, len
	syscall 

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	