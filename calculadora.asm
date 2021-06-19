.data
.eqv len 10
edad: .asciiz "Ingrese su edad: "
sexo: .asciiz "Si es mujer escriba m y si es hombre escriba h: "
estatura: .asciiz "Ingrese su estatura: "
peso: .asciiz "Ingrese su peso en kg: "
newLine: .asciiz "\n"
texto: .space len
.text
.globl main

main:


fin: 
	li $v0, 4
	la $a0, edad
	syscall
	li $v0, 5
	la $a0, texto 
	li $a1, len
	syscall
	li $v0, 4
	la $a0, sexo
	syscall
	li $v0, 8
	la $a0, texto 
	li $a1, len
	syscall
	li $v0, 4
	la $a0, estatura
	syscall
	li $v0, 6
	la $a0, texto 
	li $a1, len
	syscall
	li $v0, 4
	la $a0, peso
	syscall
	li $v0, 6
	la $a0, texto 
	li $a1, len
	syscall