; programm - search string B in string A

format PE console
entry Start
include 'C:\fasmw17327\INCLUDE\win32a.inc'

section '.data' data readable writable

	; string A
	strA db 'wowtest123test', 0
    ; length string A
    lenA dd  $ - strA - 1   ; -1 cuz without /0 symbol  ; $ - lenA https://www.tutorialspoint.com/assembly_programming/assembly_strings.htm

	; string B
	strB db 'wowtest123tes33', 0
    ; length string B
    lenB dd  $ - strB - 1   ; -1 cuz without /0 symbol


	; string to output result
	resStr db 'RES: %d', 0

	; string with space (used for scanf func)
	spaceStr db ' %d', 0

	; result (-1 if not found and index if found)
    res dd -1


section '.code' code readable executable

    Start:

    ; if lenB > lenA we just skip and output -1
    mov eax, [lenA]     ; (we cant just: cmp [lenA], [lenB]) we need mov cuz we cant compare 2 MEM's http://www.av-assembler.ru/instructions/cmp.php
    cmp eax, [lenB]
    jge lenB_longer      ; jg https://mypresentation.ru/documents_6/004cd1fc11992531917331b77a76745b/img63.jpg
        jmp output
    lenB_longer:

    ; compare strings
    ; neg [res]

	; OUTPUT RESULT
    output:
        push [res]
        push resStr
        call [printf]

	; LEAVE PROGRAMM
        ; prevent console from closing
        call [getch]                

        ; leave programm
        push 0
        call [ExitProcess]


section '.idata' import data readable
	library kernel, 'kernel32.dll',\
			msvcrt, 'msvcrt.dll'
	
	import  kernel,\
			ExitProcess, 'ExitProcess'

	import  msvcrt,\
			printf, 'printf',\
			scanf, 'scanf',\
			getch, '_getch'