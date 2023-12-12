include irvine32.inc
include macros.inc
BUFFER_SIZE =500

.data

; ------- VARIABLES FOR FILING --------
buffer BYTE BUFFER_SIZE DUP(?)
filename BYTE "C:\Users\Hamza\Desktop\Project32_VS2022\project.txt",0
fileHandle HANDLE ?
fileHandle2 HANDLE ?
stringLength DWORD ?
bytesRead DWORD ?
_CRLF BYTE 0dh, 0ah, 0  ; Newline character sequence
Prompt byte "Enter Username: ",0
BYTE "[Enter]: ",0dh,0ah,0
PizzaPoint      BYTE "Pizza ",0
BurgerPoint     BYTE "Burger ",0
BBQPoint        BYTE "BBQ ",0
Quantity        BYTE "Quantity",0
bill            BYTE "TOTAL BILL",0
bool byte ?
convertedString byte ?
username byte 30 dup (0)
password byte 60 dup (0)
Prompt1 byte "Enter Password: ",0
Prompt2 byte "Invalid Login",0
Prompt3 byte "Only 3 Attempts Are Alowwed",0
Prompt4 byte " Try Again",0
Prompt5 byte "LogIn Successful",0
name1 BYTE " 22K-4591 | Ayesha Abdul Rahman ",0
name2 BYTE " 17k-3811 | Zainab",0
loading_success  BYTE "CONTENT LOADED SUCCESSFULLY",0
load BYTE "PLEASE WAIT WHILE LOADING: ",0
un byte  "Project",0
pw byte  "Fast1234",0
; ------- VARIABLES FOR DISPLAY --------
    project BYTE "WELCOME TO RESTAURANT MANAGEMENT SYSTEM",0dh,0ah,0
    project2 BYTE "------------------RESTAURANT MANAGEMENT SYSTEM-----------------------",0dh,0ah,0
     row byte ?
     col byte ?
    name byte 30 dup (0)
    userbill byte 20 dup (0)

     
; ------- VARIABLES FOR PRICES --------
pzSmall         DWORD 500
pzReg           DWORD 800
pzLarge         DWORD 1000

coke            DWORD  30
orange_j        DWORD 80
ice_cream_shake DWORD 150
bbqTikka        DWORD  200
MalaiBoti       DWORD  300
bbqBoti         DWORD  400

Choice DWORD ?

bgSmall Dword 500
bgReg Dword   300
bgLarge Dword 800

totalBill DWORD 0


; ------- VARIABLES FOR PRINTING MESSAGES --------
msgQty BYTE "ENTER QUANTITY : ", 0
msgBill BYTE "TOTAL BILL = PKR ",0
msgError BYTE "WRONG INPUT !", 0
msgFeedback BYTE "KINDLY GIVE YOUR VALUABLE FEEDBACK", 0

count BYTE 0

.code
main proc
	mov eax, red + (yellow * 16)
	call settextcolor
    call clrscr
   call DisplayCall
	


mainBack:
    call clrscr
    call crlf
    call crlf 
    call crlf
mov edx,offset project2
call WriteString
    call crlf
    call crlf 
    call crlf
mwrite "CHOOSE CATEGORY"

call crlf
mwrite "1-PIZZA "
call crlf
mwrite "2-BURGER "
call crlf
mwrite "3-BARBEQUE "
call crlf
mwrite "4-Read Feed Back"
call crlf
mwrite "5-Exit"
call crlf
call crlf
mwrite "Enter your Choice : "
call readdec
call crlf

.if eax==1
    call pizza_max
    jmp mainBack
.elseif eax ==2
    call burger_point
    jmp mainBack
.elseif eax==3
    call barbeque_point
    jmp mainBack
.elseif eax==4
    call _ReadFile
    jmp mainBack

.elseif eax==5
    mov eax, 0
    call crlf
    mov edx, offset msgBill
    call writestring
    mov eax, totalBill
    call writedec
    call Crlf
    ;call SaveBillToFile
    call feedback
    exit
.else
    mov edx, offset msgError
    call writestring
    call crlf
    jmp mainBack
    exit
.endif

main endp

displayCall proc
    .if count==0
        inc count

         call loading
	     call clrscr

        call display
        call clrscr
        call ISloggedIN
    cmp al,"f"
    je exitt
        ret
    .else
        ret
    .endif
    exitt:
     exit
    ret
displayCall ENDP

pizza_max proc
    pizzaSize:
    call crlf
    mwrite "ENTER THE SIZE OF PIZZA"
    call crlf
    mwrite "1-SMALL    =500"
    call crlf
    mwrite "2-REGULAR  =800"
    call crlf
    mwrite "3-LARGE    =1000"
    call crlf
    mwrite "4-BACK TO MAIN MENU "
    call crlf
    call crlf
    mwrite "Enter Your Choice : "
    call readdec

    .if eax==1
    call crlf
    mwrite "Enter quantity : "
        call readdec
        mul pzSmall
        add totalBill, eax
        
        orderMore:
        call crlf
    mwrite "Do you want to order more?"
    call crlf
    mwrite "1- YES"
    call crlf
    mwrite "2- NO"
    call crlf
    call readdec
    
        .if eax == 1
            call pizzaSize
        .elseif eax==2
        call crlf
            mwrite "total bill : "
            ;call crlf
            mov eax, totalbill
            call writedec
            call crlf
            call feedback
            exit
        .else                
            mov edx, offset msgError
            call writestring
            call crlf
            jmp orderMore
        .endif

   .elseif eax==2
   call crlf
    mwrite "Enter quantity : "
        call readdec
        mul pzReg
        add totalBill, eax

        orderMore2:
        call crlf
    mwrite "Do you want to order more?"
    call crlf
    mwrite "1- YES"
    call crlf
    mwrite "2- NO"
    call crlf
    call readdec
    
        .if eax == 1
            call pizzaSize
        .elseif eax==2
        call crlf
            mwrite "Total bill : "
            call crlf
            mov eax, totalBill
            call writedec
            call crlf
            call feedback
            ;call printBill
            exit 
        .else                
            mov edx, offset msgError
            call writestring
            call crlf
            jmp orderMore2

        .endif
    
    
   .elseif eax==3
   call crlf
    mwrite "Enter quantity : "
        call readdec
        mul pzLarge
        add totalBill, eax

        orderMore3:
        call crlf
    mwrite "Do you want to order more?"
    call crlf
    mwrite "1- YES"
    call crlf
    mwrite "2- NO"
    call crlf
    call readdec
    
        .if eax == 1
            call pizzaSize
        .elseif eax==2
        call crlf
            mwrite "Total bill : "
            call crlf
            mov eax, totalBill
            call writedec
            call feedback
            ;call printBill
            exit
        .else   
            mov edx, offset msgError
            call writestring
            call crlf
            jmp orderMore3
    	.endif
    
    .elseif eax==4
        call main

    .else                           ; pizza Size else
        mov edx, offset msgError
            call writestring
            call crlf
            jmp pizzaSize
    .endif
pizza_max endp

    
burger_point proc
    burger:
    call crlf
    mwrite "ENTER THE TYPE OF BURGER"
    call crlf
    mwrite "1-ZINGER    =500"
    call crlf
    mwrite "2-CHICKEN   =300"
    call crlf
    mwrite "3-BEEF      =400"
    call crlf
    mwrite "4-BACK TO MAIN MENU "
    call crlf
    mwrite " Enter your Choice : "
    call readdec
    .if eax==1
    call crlf
    mwrite "Enter quantity : "
        call readdec
        mul bgSmall
        add totalBill, eax
        ;mov eax, totalBill
        ;call writedec

        orderMore:
        call crlf
    mwrite "Do you want to order more?"
    call crlf
    mwrite "1- YES"
    call crlf
    mwrite "2- NO"
    call crlf
    call readdec
    
        .if eax == 1
            call burger
        .elseif eax==2
        call crlf
            mwrite "total bill : "
            mov eax , totalbill
            call writedec
            call crlf
            call feedback
            exit
        .else                           
            mov edx, offset msgError
            call writestring
            call crlf
            jmp orderMore
        .endif

   .elseif eax==2
   call crlf
    mwrite "Enter quantity : "
        call readdec
        mul bgReg
        add totalBill, eax

        orderMore2:
        call crlf
    mwrite "Do you want to order more?"
    call crlf
    mwrite "1- YES"
    call crlf
    mwrite "2- NO"
    call crlf
    call readdec
    
        .if eax == 1
            call burger
        .elseif eax==2
        call crlf
            mwrite "Total bill : "
            call crlf
            mov eax, totalBill
            call writedec
            call crlf
            
            call feedback
            exit 
        .else                          
            mov edx, offset msgError
            call writestring
            call crlf
            jmp orderMore2

        .endif
    
    
   .elseif eax==3
   call crlf
    mwrite "Enter quantity : "
        call readdec
        mul bgLarge
        add totalBill, eax

        orderMore3:
        call crlf
    mwrite "Do you want to order more?"
    call crlf
    mwrite "1- YES"
    call crlf
    mwrite "2- NO"
    call crlf
    call readdec
    
        .if eax == 1
            call burger
        .elseif eax==2
        call crlf
            mwrite "Total bill : "
            call crlf
            mov eax, totalBill
            call writedec
            call crlf
            
            call feedback
            exit
        .else                       
            mov edx, offset msgError
            call writestring
            call crlf
            jmp orderMore3
	    .endif

        .elseif eax==4
            call main
    .else                           ; BURGER TYPE else
        mov edx, offset msgError
            call writestring
            call crlf
            jmp burger
    .endif
    
burger_point endp

;//////////////
barbeque_point proc

        bbqMain:
        call crlf
    mwrite "CHOOSE WHAT YOU WANT"
    call crlf
    mwrite "1-DRINKS "
    call crlf
    mwrite "2-BARBEQUE"
    call crlf
    mwrite "3-BACK TO MAIN MENU"
    call crlf
    call readdec
    .if eax == 1              
        call drinks    
    .elseif eax==2
        call bbqItems
    .elseif eax==3
        call main
    .else
    mov edx, offset msgError
            call writestring
            call crlf
            jmp bbqMain
    .endif
    
barbeque_point endp



drinks PROC

    drinksMain:
    call crlf
mwrite "CHOOSE TYPE OF DRINK?"
    call crlf
    mwrite "1.COCA COLA = 30 PKR"
    call crlf
    mwrite "2.ORANGE JUICE = 80 PKR"
    call crlf
    mwrite "3.ICECREAM SHAKE = 150 PKR"
    call crlf
    mwrite "4.MAIN MENU"
    call crlf
    mwrite "Enter your Choice: "
    call readdec
    call crlf

    .if eax == 1
    call crlf
        mwrite "Enter quantity : "
        call readdec
        mul coke
        add totalBill, eax

        orderMore1:
        call crlf
    mwrite "Do you want to order more?"
    call crlf
    mwrite "1- YES"
    call crlf
    mwrite "2- NO"
    call crlf
    call readdec
    
        .if eax == 1
            call drinksMain
        .elseif eax==2
        call crlf
            mwrite "Total bill : "
            call crlf
            mov eax, totalBill
            call writedec
            call crlf
            call feedback
            exit 
        .else                 
            mov edx, offset msgError
            call writestring
            call crlf
            jmp orderMore1
    	.endif

    .elseif eax == 2
        mwrite "Enter quantity : "
        call readdec
        mul orange_j
        add totalBill, eax

        orderMore2:
        call crlf
    mwrite "Do you want to order more?"
    call crlf
    mwrite "1- YES"
    call crlf
    mwrite "2- NO"
    call crlf
    call readdec
    
        .if eax == 1
            call drinksMain
        .elseif eax==2
        call crlf
            mwrite "Total bill : "
            call crlf
            mov eax, totalBill
            call writedec
            call crlf
            call feedback
            exit
        .else                          
            mov edx, offset msgError
            call writestring
            call crlf
            jmp orderMore2
	    .endif
    .elseif eax == 3
    call crlf
        mwrite "Enter quantity : "
        call readdec
        mul ice_cream_shake
        add totalBill, eax

        orderMore3:
        call crlf
    mwrite "Do you want to order more?"
    call crlf
    mwrite "1- YES"
    call crlf
    mwrite "2- NO"
    call crlf
    call readdec
    
        .if eax == 1
            call drinksMain
        .elseif eax==2
        call crlf
            mwrite "Total bill : "
            call crlf
            mov eax, totalBill
            call writedec
            call feedback
            exit
        .else                          
            mov edx, offset msgError
            call writestring
            call crlf
            jmp orderMore3
	    .endif

    .elseif eax==4
        call main
    
    .else
        mov edx, offset msgError
        call writestring
        call crlf
        jmp drinksMain
        
    .endif
        ret
drinks ENDP

bbqItems PROC

    bbqItemsMain:
    call crlf
mwrite "CHOOSE FROM GIVEN MENU?"
    call crlf
    mwrite "1.BBQ TIKKA = 200 PKR"
    call crlf
    mwrite "2.MALAI BOTI = 300 PKR"
    call crlf
    mwrite "3.BBQ BOTI = 400 PKR"
    call crlf
    mwrite "4.MAIN MENU"
    call crlf
    mwrite "Enter Your Choice: "
    call readdec
    call crlf

    .if eax == 1
    call crlf
        mwrite "Enter quantity : "
        call readdec
        mul bbqTikka
        add totalBill, eax

        orderMore1:
        call crlf
    mwrite "Do you want to order more?"
    call crlf
    mwrite "1- YES"
    call crlf
    mwrite "2- NO"
    call crlf
    call readdec
    
        .if eax == 1
            call bbqItemsMain
        .elseif eax==2
        call crlf
            mwrite "Total bill : "
            call crlf
            mov eax, totalBill
            call writedec
            call crlf
            call feedback
            ;call printBill
            exit 
        .else                 
            mov edx, offset msgError
            call writestring
            call crlf
            jmp orderMore1
    	.endif

    .elseif eax == 2
    call crlf
        mwrite "Enter quantity : "
        call readdec
        mul MalaiBoti
        add totalBill, eax

        orderMore2:
        call crlf
    mwrite "Do you want to order more?"
    call crlf
    mwrite "1- YES"
    call crlf
    mwrite "2- NO"
    call crlf
    call readdec
    
        .if eax == 1
            call bbqItemsMain
        .elseif eax==2
        call crlf
            mwrite "Total bill : "
            call crlf
            mov eax, totalBill
            call writedec
            call crlf
            call feedback
            ;call printBill
            exit
        .else                          
            mov edx, offset msgError
            call writestring
            call crlf
            jmp orderMore2
	    .endif
    .elseif eax == 3
    call crlf
        mwrite "Enter quantity : "
        call readdec
        mul bbqBoti
        add totalBill, eax

        orderMore3:
        call crlf
    mwrite "Do you want to order more?"
    call crlf
    mwrite "1- YES"
    call crlf
    mwrite "2- NO"
    call crlf
    call readdec
    
        .if eax == 1
            call bbqItemsMain
        .elseif eax==2
        call crlf
            mwrite "Total bill : "
            call crlf
            mov eax, totalBill
            call writedec
            call crlf
            call feedback
            exit
        .else                       
            mov edx, offset msgError
            call writestring
            call crlf
            jmp orderMore3
	    .endif

    .elseif eax==4
        call main
    
    .else
        mov edx, offset msgError
        call writestring
        call crlf
        jmp bbqItemsMain
        
    .endif
        ret
bbqItems ENDP

_ReadFile PROC
    ; Open the file for reading
    invoke CreateFile, ADDR filename, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
    mov fileHandle2, eax ; Store the file handle

    ; Check if the file was opened successfully
    cmp eax, INVALID_HANDLE_VALUE
    je fileError2

    invoke ReadFile, fileHandle2, ADDR buffer, BUFFER_SIZE, ADDR bytesRead, NULL

    mov edx, OFFSET buffer
    mov ecx, bytesRead  ; Use the actual bytes read instead of BUFFER_SIZE
    call WriteString
    call Crlf
    mwrite "Press Any Key To Continue...      "
    call ReadInt
    ; Close the file handle
    invoke CloseHandle, fileHandle2
    ret

fileError2:
    mov edx, OFFSET msgError
    call WriteString
    ret
_ReadFile ENDP



OpenOutputFileAppend PROC
    ; Open the file in append mode
    invoke CreateFile, ADDR filename, \
           FILE_APPEND_DATA, \
           FILE_SHARE_WRITE, NULL, \
           OPEN_ALWAYS, \
           FILE_ATTRIBUTE_NORMAL, \
           NULL

    mov fileHandle, eax ; Store the file handle

    ret
OpenOutputFileAppend ENDP


SetFilePointerToEnd PROC
                                                         ; Moving the file pointer to the end of the file
    invoke SetFilePointer, fileHandle, 0, 0, FILE_END

    ret
SetFilePointerToEnd ENDP


feedback PROC
    ; Open the existing file in append mode to add feedback at the end.
    call OpenOutputFileAppend
    mov fileHandle, eax

    ; Check if the file was opened successfully
    cmp eax, INVALID_HANDLE_VALUE
    je fileError

    ; Move the file pointer to the end to append feedback
    call SetFilePointerToEnd

    ; Ask the user to input a string.
    mov edx, OFFSET msgFeedback
    call WriteString
    call crlf
    mov ecx, BUFFER_SIZE
    mov edx, OFFSET buffer
    call ReadString
    mov stringLength, eax

    ; Write the buffer to the end of the output file.
    invoke WriteFile, fileHandle, OFFSET buffer, stringLength, ADDR stringLength, NULL

    ; Append a newline character to move to the next line for the next feedback.
    mov edx, OFFSET _CRLF
    mov ecx, SIZEOF _CRLF - 1
    invoke WriteFile, fileHandle, edx, ecx, ADDR stringLength, NULL

    ; Close the file handle.
    invoke CloseHandle, fileHandle

    ; Display a thank you message to the user.
    call crlf
    mwrite "THANK YOU SO MUCH for being our VALUED CUSTOMER !"
    ret

fileError:
    ; Display an error message if file opening failed.
    mov edx, OFFSET msgError
    call WriteString
    ret
feedback ENDP

Display PROC
    mov dh, 12
    mov dl, 66
    call Gotoxy

    mov ecx, LENGTHOF project
    mov esi, OFFSET project

    pn:
        mov al, [esi]
        call WriteChar
        mov eax, 50
        call Delay
        add esi, 1
    loop pn

    mov dh, 16
    mov dl, 77
    call Gotoxy

    mov dh,18
    mov dl,56
    call gotoxy

    mov dh,0
    mov dl,0
    call gotoxy
    mov edx,0
    mov eax,0
    mov row,150
    mov col,30

    mov al,'-'
    movzx ecx,row

    L1:
        call WriteChar
        mov edx,10
        call delay

    loop L1

    mov dh,0
    mov dl,150

    movzx ecx,col
    L2:
        mov al,'-'
        call gotoxy
        call WriteChar
        mov eax,10
        call delay
        inc dh
    loop L2

    mov dh,29
    mov dl,150
    add row,1

    movzx ecx,row
    L3:
        mov al,'-'
        call gotoxy
        call WriteChar
        mov eax,10
        call delay
        dec dl
    loop L3

    mov dh,0
    mov dl,0

   movzx ecx,col
    L4:
        mov al,'-'
        call gotoxy
        call WriteChar
        mov eax,10
        call delay
        inc dh
    loop L4

    ret
Display ENDP
loading proc
	call clrscr
	mov ecx,50
	mov dh, 10
	mov dl, 43
	call gotoxy
	mov edx,offset load
	call writestring
	mov dh, 12
	mov dl, 30
	l1:
		call gotoxy
		mov eax, 25
		call delay
		mov eax, 219
		call writechar
		inc dl
	loop l1
	mov dh, 15
	mov dl, 42
	call gotoxy
	mov edx,offset loading_success
	call writestring
	call crlf
	mov eax, 2000
	call delay
	call clrscr

	mov dh, 7
	mov dl, 44
	call gotoxy
	mov edx,offset project2
	call writestring
	mov eax,500

	mov eax,1200
	mov dh, 11
	mov dl, 42
	call gotoxy
	mov edx,offset name1
	call writestring

	call delay
	mov dh, 13
	mov dl, 42
	call gotoxy
	mov edx,offset name2
	call writestring

	mov eax,3000
	call delay
	ret
loading endp

ISloggedIN proc
    push eax
    push edx
    push esi
    push edi
    push ecx
    
    mov eax, 1

start:
    mov edx, offset Prompt
    call writestring
    call Crlf
    mov edx, offset username
    mov ecx, 30
    call ReadString

    mov edx, offset Prompt1
    call writestring
    call Crlf
    mov edx, offset password
    mov ecx, 60
    call ReadString

    cld

    ; Compare entered username with predefined username
    mov esi, offset un
    mov edi, offset username
    mov ecx, lengthof un
    repe cmpsb
    jne errr

    ; Compare entered password with predefined password
    cld
    mov esi, offset pw
    mov edi, offset password
    mov ecx, lengthof pw
    repe cmpsb
    jne errr

    ; Successful login
    jmp succ

errr:
    inc eax  
    mov dl, "f"
    mov bool, dl
    
    cmp eax, 3  
    je attempt_limit
    
   
    mov edx, offset Prompt2
    call writestring
    call Crlf
    jmp start  

attempt_limit:
    mov edx, offset Prompt3
    call writestring
    call Crlf
    jmp rett  

succ:
    mov edx, offset Prompt5
    call writestring
    call Crlf
    mov dl, "t"
    mov bool, dl

rett:
    pop ecx
    pop edi
    pop esi
    pop edx
    pop eax
    
    ret
ISloggedIN endp
end main