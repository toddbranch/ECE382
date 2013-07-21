.include "header.s"

.data
key_guess:

    .org    0x0100
decrypted_message:

.text
encrypted_rom:
.byte   0x35,0xdf,0x00,0xca,0x5d,0x9e,0x3d,0xdb,0x12,0xca,0x5d,0x9e,0x32,0xc8,0x16,0xcc,0x12,0xd9,0x16,0x90,0x53,0xf8,0x01,0xd7,0x16,0xd0,0x17,0xd2,0x0a,0x90,0x53,0xf9,0x1c,0xd1,0x17,0x90,0x53,0xf9,0x1c,0xd1,0x17,0x90,0x50

.align     2 
main:
    ;disable watchdog timer
    mov     #WDTPW, r10
    xor     #WDTHOLD, r10
    mov     r10, &WDTCTL
    ;initialize stack
    mov     #RAMEND, r1

    ;load initial key guss
    mov.w   #0,&key_guess

    ;load registers
    mov.w   #encrypted_rom, r5
    mov.w   #key_guess, r6
    mov.w   #decrypted_message, r7
    mov.w   #2,r8                               ;key length in bytes
    mov.w   #43,r4

    call    #crack_message

forever:
    jmp     forever

crack_message:
    push.w  r15

repeat:
    mov.w   #0,r15 
    mov.w   #0,r14

    call    #decrypt_message
    tst     r15
    jeq     test_crack_done 
    inc     0(r6)
    jmp     repeat

test_crack_done:
    cmp.w   r4,r14
    jeq     crack_done
    inc     0(r6)
    jmp     repeat

crack_done:
    pop.w   r15
    ret

;---------------------------------------------------
;Subroutine Name: decrypt_message
;Authoer: Capt Todd Branchflower, USAF
;Function: Takes in the location of an encrypted message  and key
; and uses the xor_bytes subroutine to decrypt it.  It
; stores the results at a passed in memory location.  Stops when
; the ASCII character # is encountered.
;Inputs: 
; - encrypted message address in r5 (reference)
; - key address in r6 (reference)
; - decrypted message address in r7 (reference)
; - key length in r8 (value)
;Outputs: none
;Registers destroyed: none
;---------------------------------------------------
decrypt_message:
            ; saving registers
            push.w  r5
            push.w  r7
            push.w  r8
           
            mov.w   r6, r9
            mov.w   r9, r11
            mov.w   r8, r10

decrypt_next_byte:
            mov.b   @r5+, r8                        ; retrieving next byte
            call    #xor_byte_with_arbitrary_length_key
            mov.b   r8, 0(r7)                       ; storing decrypted byte
            inc     r14
            cmp.b   #0x23, r8
            jeq     decryption_done
            call    #test_if_english_char
            ; if r15 is not 0, then return
            tst     r15
            jne     decryption_done
            ; otherwise, continue
            inc     r7
            jmp     decrypt_next_byte

decryption_done:
            ; restoring registers
            pop.w   r8
            pop.w   r7
            pop.w   r5
            ret

test_if_english_char:
            push.w  r5
            push.w  r6

            ;eliminates values below 1f, above 7b
            mov.b   #0x1f, r5
            mov.b   #0x7b, r6   
            call    #is_between
            tst     r5
            jeq     check_nums
            inc     r15
            jmp     test_done

            ;eliminates values between 24 and 2d
check_nums:
            mov.b   #0x24, r5
            mov.b   #0x2d, r6   
            call    #is_between
            tst     r5
            jne     check_punc
            inc     r15
            jmp     test_done

            ;eliminates values between 5b and 60
check_punc:
            mov.b   #0x5b, r5
            mov.b   #0x60, r6   
            call    #is_between
            tst     r5
            jne     test_done
            inc     r15
            jmp     test_done
test_done:
            pop.w   r6
            pop.w   r5
            ret


; takes in lower bound in r5, upper bound in r6, value in r8
; returns 0 in r5 if in range, 1 if out of range
is_between:
            cmp.b    r5, r8
            mov.w    #0, r5
            jc       check_too_big
            mov.w    #1, r5       
            jmp      between_found
check_too_big:
            cmp.b    r6, r8
            jnc      between_found    
            mov.w    #1, r5

between_found:
            ret

;---------------------------------------------------
;Subroutine Name: xor_byte_with_arbitrary_length_key
;Authoer: Capt Todd Branchflower, USAF
;Function: 
; Takes in the base location of a key, its length, 
; and current position.  It uses this information to
; find the next byte of the key and XOR it with a byte
; passed in.  It returns the result and updated key
; position.
;Inputs: 
; - byte to be XORed with the key in r8 
; - key base location in r9 (reference)
; - key length in r10 (value)
; - current key position in r11 (reference)
;Outputs: 
; - result in r8 (value)
; - new key position in r11 (reference)
;Registers destroyed: r8, r11
;---------------------------------------------------

xor_byte_with_arbitrary_length_key:
            push.w  r9
            push.w  r10

            add.w   r10, r9
            cmp     r11, r9
            jeq     end_of_key 

            xor.b   @r11+, r8
            jmp     xor_finished

end_of_key:
           sub.w    r10, r9
           mov.w    r9, r11
           xor.b   @r11+, r8
            
xor_finished:
            pop.w   r10
            pop.w   r9
            ret

.section    ".vectors", "a"
.org    0x1e
    .word   main
