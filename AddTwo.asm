; Authors: Tichakorn(Tweety) Taekratok, Kunal Chopra, Hsun-Yu Kuo 
; Course/project ID: CS 271
; Date: 05/16/2023
; Description: This program converts miles to kilometers and Fahrenheit to Celsius. It will first ask for the users name and then greet the user.
;After that the program will propmt the user to enter the distance in miles that they want to convert adn then prompt them to enter 
;the temperature that they want to convert in Fahrenheit. Then the program will display the converted values. Finally there is a closing
;message and the program ends. 


INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096			;SS register
ExitProcess proto,dwExitCode:dword

.data				;DS register
	intro1 BYTE "Composite Numbers Programmed by Euclid by Tichakorn(Tweety) Taekratok, Kunal Chopra, Hsun-Yu Kuo and Euclid",0							;Introduction set1
	intro2 BYTE "Enter the number of composite numbers you would like to see. I will accept orders for up to 400 composites.",0							;Introduction set2
	Ask BYTE "Enter the number of composites to display [1 .. 400]: ",0																					;Ask for input
	endMessage BYTE "Results certified by Euclid. Goodbye.",0																							;end message
	

.code				;CS register
main proc

	Start:
		call introduction


	ExitSequence:
		call Crlf
		mov	EDX, OFFSET endMessage
		call WriteString
		call Crlf
		invoke ExitProcess,0
		main endp
		end main

introduction proc
		;Introduction
		mov	EDX, OFFSET intro1				
		call WriteString
		call Crlf
		call Crlf
		mov	EDX, OFFSET intro2				
		call WriteString
		call Crlf
introduction endp