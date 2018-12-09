; Main.asm
; Name: Gabriel Wu
; UTEid: gxw58
; Continuously reads from x4600 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.
               .ORIG x4000
; initialize the stack pointer
LD R6, stack

; set up the keyboard interrupt vector table entry
LD R0, interrupt
STI R0, KBIVE

; enable keyboard interrupts
LD R0, KBIEN
STI R0, KBSR


; start of actual program
NEW AND R3, R3, 0
LOOP1 LDI R0, LOC
BRNZ LOOP1
OUT
AND R1, R1, 0	;clears x4600
STI R1, LOC


ADD R3, R3, #-1
BRZ GOTOU
ADD R3, R3, #-1
BRZ GOTOG
ADD R3, R3, #2

CHECKA 
AND R3, R3, 0
LD R1, NEGA		;check A
ADD R1, R1, R0
BRNP NEW
ADD R3, R3, #1
BRNZP LOOP1

GOTOU 
ADD R3, R3, #1		
LD R1, NEGU		;check U
ADD R1, R1, R0
BRNP CHECKA
ADD R3, R3, #1
BRNZP LOOP1

GOTOG
ADD R3, R3, #1		
LD R1, NEGG		;check G
ADD R1, R1, R0
BRZ START
BRNZP CHECKA

START
LD R0, PIPE
OUT			;start sequence complete; print pipe
NEW1 AND R3, R3, 0
LOOP2 LDI R0, LOC
BRNZ LOOP2
OUT
AND R1, R1, 0
STI R1, LOC

ADD R3, R3, #-1
BRZ SECOND
ADD R3, R3, #1

CHECKU 
AND R3, R3, 0
LD R1, NEGU		;check U
ADD R1, R1, R0
BRNP NEW1
ADD R3, R3, #1
BRNZP LOOP2

SECOND 
LD R1, NEGA		;check A
ADD R1, R1, R0
BRNP 2
ADD R3, R3, #1
BRNZP THIRD
LD R1, NEGG		;check G
ADD R1, R1, R0
BRZ THIRD
BRNZP CHECKU

THIRD LDI R0, LOC
BRNZ THIRD
OUT
AND R1, R1, 0
STI R1, LOC

ADD R3, R3, #-1
BRNP 7
LD R1, NEGA		;check A
ADD R1, R1, R0
BRZ STOP
LD R1, NEGG		;check G
ADD R1, R1, R0
BRZ STOP
BRNZP CHECKU
LD R1, NEGA		;check A
ADD R1, R1, R0
BRZ STOP
BRNZP CHECKU
STOP TRAP x25

stack .FILL x4000
interrupt .FILL x2600
KBSR .FILL xFE00
KBDR .FILL xFE02
KBIVE .FILL x0180
KBIEN .FILL x4000
LOC .FILL x4600
NEGA .FILL x-41 
NEGU .FILL x-55
NEGG .FILL x-47
PIPE .FILL x7C
 		.END
