Class {
	#name : #GWBasicTest,
	#superclass : #TestCase,
	#instVars : [
		'm'
	],
	#category : #GWBasicVisualization
}

{ #category : #running }
GWBasicTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	m := GWBModel new
]

{ #category : #accessing }
GWBasicTest >> sourceCode [

	^ 
'; [ This translation created 10-Feb-83 by Version 4.3 ]

	.RADIX  8		; To be safe

CSEG	SEGMENT PUBLIC ''CODESG'' 
	ASSUME  CS:CSEG

INCLUDE	OEM.H

	TITLE   CALL86  8086 CALL Statement
	.SALL
	.RADIX	8


	EXTRN	VMOVFM:NEAR,FRQINT:NEAR,PTRGET:NEAR,GETSTK:NEAR
	EXTRN	CHRGTR:NEAR,SYNCHR:NEAR,CHRGT2:NEAR,FCERR:NEAR
DSEG	SEGMENT PUBLIC ''DATASG''
	ASSUME DS:DSEG
	EXTRN	SUBFLG:WORD,SARYFL:WORD,TEMP:WORD,TEMPA:WORD,SAVSEG:WORD
	EXTRN	ARYTAB:WORD
DSEG	ENDS

; This is the CALL <simple var>[(<simple var>[,<simple var>]..)]
; Stragegy:
;
; 1.) Make sure suboutine name is simple var, get value & save it
;
; 2.) Evaluate params & stuff pointers on stack
;
; 3.) CALL suboutine with return address on stack
;
; The CALLS statement is the same as CALL, except for each parameter
; it pushes Segment and Offset, not just Offset.

	PUBLIC	CALLS,CALLSL

CALLSL:	CLC			;Clear-carry, (PUSH Segment adr of parms)
	JMP	SHORT CALLS1
CALLS:	STC			;Set-carry, (don''t PUSH Segment adr of parms)
CALLS1:	PUSHF	
	EXTRN	PRODIR:NEAR	;Don''t allow CALL as direct statement in
	CALL	PRODIR		;protected environment
	MOV	BYTE PTR SUBFLG,LOW 200O	;say we want to scan only a simple
	CALL	PTRGET		;scan var and search symbol table
	MOV	BYTE PTR SARYFL,LOW 0	;clear Scanned-Array-Element-Flag
	PUSH	BX		;save text pointer
	MOV	BX,DX		;get pointer to var in BX
	CALL	VMOVFM		;load variable into FAC
	CALL	FRQINT		;make it an integer
	MOV	WORD PTR TEMPA,BX	;save text pointer
	MOV	CL,LOW 32D	;get max # of parameters
	CALL	GETSTK		;see if there is that much stack space
	POP	BX		;get back text pointer
	CALL	CHRGT2		;eat character after var name
	JZ	CALLST		;end of statement, no parameter list
	CALL	SYNCHR		;check for open paren
	DB	50O		; (
GETPAR:	PUSH	WORD PTR ARYTAB	;save pointer to start of array var data
	CALL	PTRGET		;scan parameter variable
	POP	CX		;[CX]=old value of ARYTAB
	CMP	CX,WORD PTR ARYTAB	;if = old, no undefined simples were referenced
	JE	NONEWS		;Branch if New Simple Var not encountered
	CMP	BYTE PTR SARYFL,LOW 0	;Z-FLAG if no Array elements have been parsed
				; by PTRGET
	JZ	NONEWS
	JMP	FCERR		;Undefined scalers can''t be passed after array
				;elements since the addr of the array element
				;changes when the new scaler is added.
NONEWS:	POPF			;restore Carry=CALL/CALLS flag
	JB	SHTPRM		;Branch if CALL (not CALLS)
	PUSH	DS		;save Segment of Parameter on stack
SHTPRM:	PUSH	DX		;save Offset of parameter on stack
	PUSHF			;re-save CALL/CALLS flag
	MOV	AL,BYTE PTR 0[BX]	;get terminator
	CMP	AL,LOW ","	;comma?
	JNZ	ENDPAR		;no, must be end of the param list
	CALL	CHRGTR		;scan next char
	JMP	SHORT GETPAR	;scan next parm
ENDPAR:	CALL	SYNCHR		;check for terminating right paren
	DB	51O		; )
CALLST:	MOV	WORD PTR TEMP,BX	;save text pointer
	POPF			;discard CALL/CALLS flag
	PUSH	CS		;save BASIC code segment
	MOV	AX,OFFSET CALLRT	;where to return to
	PUSH	AX
	PUSH	WORD PTR SAVSEG	;save subroutine segment
	PUSH	WORD PTR TEMPA	;save subroutine address
	DB	313O		; Do a long return to call the subroutine
;
CALLRT:	MOV	BX,WORD PTR TEMP	;get back text pointer
	RET			;return to newstt
;
CSEG	ENDS
	END
'
]

{ #category : #tests }
GWBasicTest >> testEmpty [
	self assert: m numberOfFunctions equals: 0
]

{ #category : #tests }
GWBasicTest >> testParseExample [

	| f |
	m importFileAsText: self sourceCode.
	self assert: m numberOfFunctions equals: 9.

	f := m files first.
	self assert: f numberOfFunctions equals: 9.
	self assert: f functions third name equals: 'CALLS1'.
	self assert: f functions third calledFunctionNames asArray equals: #( 'PRODIR' 'PTRGET' 'VMOVFM' 'FRQINT' 'GETSTK' 'CHRGT2' 'CALLST' 'SYNCHR' )

]

{ #category : #tests }
GWBasicTest >> testParseExampleAndResolve [

	m importFileAsText: self sourceCode.
	m resolve.

]

{ #category : #tests }
GWBasicTest >> testParsing [

	self deny: m inAFunction
]

{ #category : #tests }
GWBasicTest >> testParsing2 [

	m importFileAsText: self sourceCode.
	self assert: (m allFunctions collect: #file as: Set) size equals: 1.
	self assert: m allFunctions first file equals: m files first.
	
	m importFileAsText: self sourceCode.
	self assert: (m allFunctions collect: #file as: Set) size equals: 2.
	self assert: m allFunctions first file equals: m files first.
	self assert: m allFunctions last file equals: m files second.
]
