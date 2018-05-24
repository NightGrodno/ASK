.data
rodzajoper:   .asciiz  "Rodzaj operacji (0 - szyfrowanie, 1 - odszyfrowanie): "
klucztxt: .asciiz "Klucz (nie może być pusty, maks. 8 znaków):  "
slowotxt: .asciiz "\nTekst do zaszyfrowania (szyfrowanie) lub szyfrogram (odszyfrowywanie) - maks. 16 znaków: "
wyn: .asciiz "\nWynik operacji: "
erortext: .asciiz "\nEROR "
koniec: .asciiz "\nKoniec."
kol: .asciiz "\nCzy wykonac kolejną operację (0/1): "
klucz: .space 8
slowo: .space 16
str2: .asciiz "\nTEST: : "
alphabet: .ascii "abcdefghijklmnopqrstuwxyz"
	
.text

	main:
li $t8,26

	startprogram:
li $v0, 4 #Rodzaj operacji
la $a0, rodzajoper
syscall 
li $v0, 5
syscall
add $t4, $zero, $v0
 
li $v0, 4 #wprow slowo
la $a0, slowotxt
syscall 
li $v0, 8
la $a0, slowo  # load byte space into address
    li $a1, 16     # allot the byte space for string
	syscall

li $v0, 4  #wprow klucz
la $a0, klucztxt
syscall 
li $v0, 8
la $a0, klucz  # load byte space into address
    li $a1, 8      # allot the byte space for string
	syscall
	
#indeks	slowa
li $t0,0	 
#indeks klucza
li $t9,0
  
#--------------------------------	
	while:
#wczytywanie do rejestru kolejnego bajtu ze slowa i klucza
lb $t1,slowo($t0)	
lb $t2,klucz($t9)

#jezeli w slowie jest spacja to nie szyfruj idz dla slowa bit dalej a dla klucza stoj w miejscu
beq $t1,32,spacja
	
#jesli koniec slowa to wyjdz jesli koniec klucza to od nowa klucz
beq $t1,10,start		
beq $t2,10,zerujklucz

#jesli 0 to szyfr jesli 1 to odszyfr
beq $t4, 0, szyfrowanie
nop
beq $t4, 1, odszyfrowanie
nop

#jezeli w slowie jest spacja
	spacja:
addi $t0,$t0,1
addi $t9,$t9,0
j while #wroc to pobierania bitow
nop

#zerowanie licznika dla klucza
	zerujklucz:
li $t9,0
beq $t1,32,spacja
j while
nop

#Wyswietlenie zaszyfrowanej litery
	wyswietlenie:
li $v0,11		
add $a0,$zero,$t3
syscall
addi $t0,$t0,1	#indeksy ++
addi $t9,$t9,1
j while
nop	

#----------------------------------------------
	
	szyfrowanie:
#zmiana wartosci liter z ascii do 0,1,2..	
addi $t1,$t1,-97	
addi $t2,$t2,-97
add $t3,$t1,$t2	
blt $t3,26,bezmodulo
#jezeli suma wartosci liter wieksza niz 26 to wez reszte z dzielenia przez 26	 
div $t3,$t8		
mfhi $t3
	bezmodulo:
#jezeli suma wartosci liter mniejsza niz 26 to zmien na ascii i wyswietl		
addi $t3,$t3,97
j wyswietlenie
nop

#----------------------------------------------
	
	odszyfrowanie: 
#deszyfrowanie zmiana z ascii do 0,1,2..
addi $t1,$t1,-97	
addi $t2,$t2,-97
#jesli ma byc ujemna wartosc dodaj 123=97+26
blt $t1,$t2,skok
#jezeli nie to dodaj 97
sub $t3,$t1,$t2
addi,$t3,$t3,97
j wyswietlenie 
nop
	skok:  
sub $t3,$t1,$t2
addi $t3,$t3,123
j wyswietlenie
nop


#----------------------------------------------

start:
j end 
nop
#li $v0, 4 #Czy wykonac kolejną operację
#la $a0, kol
#syscall 
#li $v0, 5 
#syscall
#beq $v0, 0, end
#beq $v0, 1, startprogram


end: 
li $v0, 4 #koniec
la $a0, koniec
syscall
li $v0, 10 #end

	


	
	
	



	
	


