; Authors: Tichakorn(Tweety) Taekratok, Kunal Chopra, Hsun-Yu Kuo
; Course/project ID: CS 271
; Date: 5/16/2023
; Description: This program asks the user for the number of composites to be displayed, and then calculates and displays all the composite numbers up to and including that number.
;              The results are displayed 10 composites per line with at least 3 spaces between the numbers.


INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096			;SS register
ExitProcess proto,dwExitCode:dword

.data				;DS register
	intro1 BYTE "Composite Numbers Programmed by Tichakorn(Tweety) Taekratok, Kunal Chopra, Hsun-Yu Kuo and Euclid",0							;Introduction set1
	intro2 BYTE "Enter the number of composite numbers you would like to see. I will accept orders for up to 400 composites.",0							;Introduction set2
	Ask BYTE "Enter the number of composites to display [1 .. 400]: ",0																					;Ask for input
	endMessage BYTE "Results certified by Euclid. Goodbye.",0																							;end message
	

.code				;CS register

introduction proc
		;Introduction
		mov	EDX, OFFSET intro1				
		call WriteString
		call Crlf
		call Crlf
		mov	EDX, OFFSET intro2				
		call WriteString
		call Crlf

		ret

introduction endp


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