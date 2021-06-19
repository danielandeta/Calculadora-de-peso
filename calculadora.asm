.data
edad: .asciiz "Ingrese su edad: "
sexo: .asciiz "Si es mujer escriba m y si es hombre escriba h: "
newLine: .asciiz "\n"

.text
.globl main

main:


fin: 
	li $v0, 10
	syscall