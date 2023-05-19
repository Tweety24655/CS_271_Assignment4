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
	intro2 BYTE "Enter the number of composite numbers you would like to see. I will accept orders for up to 400 composites.",0					;Introduction set2
	Ask BYTE "Enter the number of composites to display [1 .. 400]: ",0																			;Ask for input
	endMessage BYTE "Results certified by Euclid. Goodbye.",0																					;end message
	errorMessage  BYTE "Out of range.",0																										;error message
	comma BYTE ",",0																															;comma
	numterm DD ?																																;Number of term
	num db ?																																	; Number to check for compositeness
	boolean DD ?																																;Boolean

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
		call Crlf

		ret

introduction endp

Askfortheterm proc
	Questionterm:
		mov	EDX, OFFSET Ask				
		call WriteString
		call ReadInt
		mov numterm, EAX

		call Validate

		mov ECX,1
		cmp ECX,boolean
		je Questionterm

		ret

Askfortheterm endp

Validate proc
	ErrorCheck:
		mov EAX, numterm
		mov EBX, 400
		mov EDX, 1
		cmp EAX, EBX
		jg ErrorRespond
		cmp EAX, EDX
		jl ErrorRespond
		mov ECX, 0
		mov boolean,ECX
		jmp notError

	;there is an error
	ErrorRespond:
		mov	EDX, OFFSET errorMessage				
		call WriteString
		call Crlf
		mov ECX, 1
		mov boolean, ECX

	;no error
	notError:

		ret
Validate endp

showComposites proc
	;Set default value
	mov ESI,0
	
	;Start Macro Loop
	StartLoop:

		;insert code here
		mov EAX, 3
		call WriteDec
		mov EDX, OFFSET comma
		call WriteString

		;mod with 5
		mov	EAX, ESI
		inc EAX
		mov	EBX, 10
		cdq
		div EBX
		cmp EDX,0
		je NewLine
		jne EndMacroLoop

		NewLine:
			call Crlf
		
	EndMacroLoop:
		inc ESI
		mov EDI, numterm
		cmp ESI, EDI
		jne StartLoop

		ret


showComposites endp

main proc

	Start:
		call introduction
		call Askfortheterm
		call showComposites


	ExitSequence:
		call Crlf
		mov	EDX, OFFSET endMessage
		call WriteString
		call Crlf
		invoke ExitProcess,0
		main endp
		end main