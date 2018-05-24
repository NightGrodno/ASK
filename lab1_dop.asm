.data
ps:   .asciiz  "Pierwszy skladnik: "
dzialanie: .asciiz "Dzialanie(0: dodawanie; 1: odejmowanie; 2: dzielenie; 3: mnozenie):  "
ds: .asciiz "Drugi skladnik: "
wyn: .asciiz "\nWynik operacji: "
kol: .asciiz "\nCzy wykonac kolejną operację (0/1): "
erortext: .asciiz "\nEROR "
koniec: .asciiz "\nKoniec."
reszta: .asciiz "Reszta: "
	
.text

main:
mtc1 $zero, $f5
startprogram:
li $v0, 4 #Pierwszy skladnik
la $a0, ps
syscall 
li $v0, 6
syscall
add.s   $f1, $f5, $f0
 
li $v0, 4 #Drugi skladnik
la $a0, ds
syscall 
li $v0, 6
syscall
add.s $f2, $f5, $f0

plus:
	add.s   $f3, $f1, $f2
	j wynik
	nop

wynik:
li $v0, 4
la $a0, wyn
syscall 	
li $v0, 2
add.s $f12, $f5, $f3
syscall 

j start
nop

start:
li $v0, 4 #Czy wykonac kolejną operację
la $a0, kol
syscall 
li $v0, 5 
syscall
beq $v0, 0, end
beq $v0, 1, startprogram

end: 
li $v0, 4 #koniec
la $a0, koniec
syscall
	


	
	
	



	
	


