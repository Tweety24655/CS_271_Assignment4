; Authors: Tichakorn(Tweety) Taekratok, Kunal Chopra, Hsun-Yu Kuo 
; Course/project ID: CS 271
; Date: 05/09/2023
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
	intro BYTE "Distance & Temperature Unit Conversion Programmed by Tichakorn(Tweety) Taekratok, Kunal Chopra, Hsun-Yu Kuo and Leonardo Pisano",0		;Introduction set 1
	askName BYTE	"What is your name?: ",0																											;Ask for name 
	askDistance BYTE "Enter the distance in miles that you want to convert to kilometers:",0															;Ask for distance in km.
	askTemp BYTE "Now enter the temperature in Fahrenheit that you want to convert to Celsius:",0														;Ask for temperature in celsius.
	hiName BYTE "Hi ",0																																	;hi+name
	byeName BYTE "Bye ",0																																;bye+name
	uName BYTE	15 DUP(0)																																;Name
	kmConverter REAL10 1.60934																															;Constant for km. conversion
	celsiusSubtractionConverter REAL10 32.0																												;Constant for celsius subtraction
	celsiusDivisionConverter REAL10 1.8																													;Constant for celsius division
	displayMiles1 BYTE "The conversion of ",0																											;Display Miles1
	displayMiles2 BYTE " miles in kilometers is: ",0																									;Display Miles2				
	displayCelsius1 BYTE "The conversion of ",0																											;Display Celsius1
	displayCelsius2 BYTE " degrees Fahrenheit in Celsius is: ",0																						;Display Celsius2
	var1 REAL10 ?																																		;Variable1
	var2 REAL10 ?																																		;Variable2
	resultDistance REAL10 ?																																;Result Distance
	resultTemperature REAL10 ?																															;Result Temperature
	endMessage BYTE "Results certified by Leonardo Pisano.",0																							;end message
	

.code				;CS register
main proc

	Start:
		FINIT
		;Introduction
		mov	EDX, OFFSET intro				
		call WriteString
		call Crlf

	QuestionName: 
		mov	EDX, OFFSET askName
		call WriteString

	ReceiveName:
		mov EDX, OFFSET uName
		mov ECX, 15
		call ReadString

	;Hi+name
	Greetings:
		mov	EDX, OFFSET hiName
		call WriteString

		mov	EDX, OFFSET uName
		call WriteString
		call Crlf

	;Ask for Distance
		mov	EDX, OFFSET askDistance
		call WriteString

	;Receive Distance
		call ReadFloat
		fstp var1

	;Ask for Temperature
		mov	EDX, OFFSET askTemp
		call WriteString

	;Receive Temperature
		call ReadFloat
		FSTP var2

	;Calculate kilometer
		FLD var1
		FLD kmConverter
		FMUL
		FSTP resultDistance

	;Calculate Celsius
		FLD var2
		FLD celsiusSubtractionConverter
		FSUB
		FLD celsiusDivisionConverter
		FDIV
		FSTP resultTemperature

	;Display Miles
		mov	EDX, OFFSET displayMiles1
		call WriteString
		FLD	var1
		call WriteFLoat
		FSTP var1
		mov	EDX, OFFSET displayMiles2
		call WriteString
		FLD resultDistance
		call WriteFloat
		call Crlf

	;Display Temperture
		mov	EDX, OFFSET displayCelsius1
		call WriteString
		FLD	var2
		call WriteFLoat
		FSTP var1
		mov	EDX, OFFSET displayCelsius2
		call WriteString
		FLD resultTemperature
		call WriteFloat

	ExitSequence:
		call Crlf
		mov	EDX, OFFSET endMessage
		call WriteString
		call Crlf
		mov	EDX, OFFSET byeName
		call WriteString
		mov	EDX, OFFSET uName
		call WriteString
		call Crlf
		invoke ExitProcess,0
		main endp
		end main