.include "header.s"

.data
encrypted_message:
    .org    0x0100
decrypted_message:

.text
plaintext_message:
.string     "*****Congratulations!  You decrypted the ECE382 hidden message and achieved required functionality!*****#"
key:
.byte       0xac

.align     2 
main:
    ;disable watchdog timer
    mov     #WDTPW, r10
    xor     #WDTHOLD, r10
    mov     r10, &WDTCTL
    ;initialize stack
    mov     #RAMEND, r1

    ;load registers
    mov.w   #plaintext_message, r5
    mov.w   #key, r6
    mov.w   #encrypted_message, r7

    call    #encrypt_message

    ;load registers
    mov.w   #encrypted_message, r5
    mov.w   #key, r6
    mov.w   #decrypted_message, r7

    call    #decrypt_message

forever:
    jmp     forever

;---------------------------------------------------
;Subroutine Name: encrypt_message
;Authoer: Capt Todd Branchflower, USAF
;Function: Takes in the location of a plaintext message and key
; and uses the xor_bytes subroutine to encrypt it.  It
; stores the results at a passed in memory location.  Stops when
; the ASCII character # is encountered.
;Inputs: plaintext message address in r5, key in r6, encrypted
; message address in r7
;Outputs: none
;Registers destroyed: none
;---------------------------------------------------
encrypt_message:
            ; saving registers
            push.w  r5
            push.w  r6
            push.w  r7
            push.w  r8
           
            mov.b   @r6, r6                         ; retrieving key
encrypt_next_byte:
            mov.b   @r5+, r8                        ; retrieving next byte
            cmp.b   #0x23, r8
            jeq     encryption_done
            call    #xor_bytes
            mov.b   r8, 0(r7)                       ; storing encrypted byte
            inc     r7
            jmp     encrypt_next_byte

encryption_done:
            call    #xor_bytes
            mov.b   r8, 0(r7)

            ; restoring registers
            pop.w   r8
            pop.w   r7
            pop.w   r6
            pop.w   r5
            ret

;---------------------------------------------------
;Subroutine Name: decrypt_message
;Authoer: Capt Todd Branchflower, USAF
;Function: Takes in the location of an encrypted message  and key
; and uses the xor_bytes subroutine to decrypt it.  It
; stores the results at a passed in memory location.  Stops when
; the ASCII character # is encountered.
;Inputs: encrypted message address in r5, key in r6, decrypted
; message address in r7
;Outputs: none
;Registers destroyed: none
;---------------------------------------------------
decrypt_message:
            ; saving registers
            push.w  r5
            push.w  r6
            push.w  r7
            push.w  r8
           
            mov.b   @r6, r6                         ; retrieving key
decrypt_next_byte:
            mov.b   @r5+, r8                        ; retrieving next byte
            call    #xor_bytes
            mov.b   r8, 0(r7)                       ; storing decrypted byte
            cmp.b   #0x23, r8
            jeq     decryption_done
            inc     r7
            jmp     decrypt_next_byte

decryption_done:
            ; restoring registers
            pop.w   r8
            pop.w   r7
            pop.w   r6
            pop.w   r5
            ret

;---------------------------------------------------
;Subroutine Name: xor_bytes
;Authoer: Capt Todd Branchflower, USAF
;Function: Takes in two bytes, XORs them, returns the result.
;Inputs: Byte 1 in r6, byte 2 in r8
;Outputs: Result in r8
;Registers destroyed: r8
;---------------------------------------------------
xor_bytes:
            xor.b   r6, r8

            ret

.section    ".vectors", "a"
.org    0x1e
    .word   main
