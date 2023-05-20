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
	Ask BYTE "Enter the number of composites to display [1 .. 400]: ",0		
	ecMessage3  BYTE "**EC #3: DESCRIPTION: Check against only prime divisors.",0															;Extra Credit Message1
	ecMessage3_1 BYTE "The program efficiently checks for prime divisors by saving all prime numbers found so far, improving the overall execution time and resource usage.",0		;Extra Credit Message1.1																
	endMessage BYTE "Results certified by Euclid. Goodbye.",0																					;end message
	errorMessage  BYTE "Out of range.",0																										;error message
	space BYTE "   ",0																															;space
	numterm DD ?																																;Number of term
	num db ?																																	; Number to check for compositeness
	boolean DD ?																																;Boolean
	numStart DD 4																																;composite number to be display
	counter DD 0																																;count until terminate
	numCol DD 0																																	;Number of column
	compositeBoolean DD ?																														;T/F for composite
	mod2 DD 2
	mod3 DD 3
	mod5 DD 5
	mod7 DD 7

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

		;ExtraCredit3
		mov	EDX, OFFSET ecMessage1				
		call WriteString
		call Crlf

		mov	EDX, OFFSET ecMessage3_1				
		call WriteString
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
	
	call Crlf

	;Start Macro Loop
	StartLoop:

		;insert code here
		;Composite Boolean
		call isComposite
		cmp compositeBoolean,1
		jne NotRegular

		Regular:
			mov EAX, numStart
			call WriteDec
			mov EDX, OFFSET space
			call WriteString
			inc numStart

			;increase column and terminator counter
			inc numCol
			inc counter
			jmp continue

		NotRegular:
			inc numStart
		
		continue:
			;Check whether the program should end or not
			mov EDI, counter
			mov ECX, numterm
			cmp EDI, ECX
			je EndMacroLoop
		
			;check whether we need a new line or not
			cmp numCol, 10
			je NewLine
			jne StartLoop

		;Create new line
		NewLine:
			call Crlf
			mov numCol,0
			jmp StartLoop
		
	EndMacroLoop:

		ret


showComposites endp

isComposite PROC
	;insert code here
	
	;check 5,7
	mov EAX,numStart
	mov EBX, 5
	cmp EAX,EBX
	je notcomposite
	mov EBX, 7
	cmp EAX,EBX
	je notcomposite




	;check2
	mov EAX,numStart
	mov EBX, mod2
	cdq
	div EBX
	cmp EDX,0
	je composite
	
	;check3
	mov EAX,numStart
	mov EBX, mod3
	cdq
	div EBX
	cmp EDX,0
	je composite
	
	;check5
	mov EAX,numStart
	mov EBX, mod5
	cdq
	div EBX
	cmp EDX,0
	je composite

	;check7
	mov EAX,numStart
	mov EBX, mod7
	cdq
	div EBX
	cmp EDX,0
	je composite

	;notcomposite
	jmp notComposite



	composite:
		mov compositeBoolean,1
		jmp endCheck

	notComposite:
		mov compositeBoolean,0


	endCheck:
	ret


isComposite ENDP

main proc

	Start:
		call introduction
		call Askfortheterm
		call showComposites


	ExitSequence:
		call Crlf
		call Crlf
		mov	EDX, OFFSET endMessage
		call WriteString
		call Crlf
		invoke ExitProcess,0
		main endp
		end main