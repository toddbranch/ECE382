.include "header.s"

.data
encrypted_message:
    .org    0x0100
decrypted_message:

.text
plaintext_message:
.string     "Nice job!  You've successfully encrypted a message using a word-length key and achieved B Functionality!#"
key:
.word       0xdfec

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
           
            mov.w   @r6, r6                         ; retrieving key
            swpb    r6                              ; flipping key to make encryption of byte-oriented data work

encrypt_next_word:
            mov.w   @r5+, r8                        ; retrieving next word
            cmp.b   #0x23, r8
            jeq     encryption_done_bottom_half     ; want to encrypt only the bottom half here
            swpb    r8
            cmp.b   #0x23, r8
            jeq     encryption_done_whole_word      ; want to encrypt the whole word here
            swpb    r8                                ; we're good, so swapping back

            call    #xor_words
            mov.w   r8, 0(r7)                       ; storing encrypted byte
            incd    r7
            jmp     encrypt_next_word

encryption_done_bottom_half:
            call    #xor_bytes
            mov.b   r8, 0(r7)
            jmp     done_encryption

encryption_done_whole_word:
            call    #xor_words
            mov.w   r8, 0(r7)

            ; restoring registers
done_encryption:
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
           
            mov.w   @r6, r6                         ; retrieving key
            swpb    r6
decrypt_next_word:
            mov.w   @r5+, r8                        ; retrieving next word
            call    #xor_words
            cmp.b   #0x23, r8
            jeq     decryption_done_half_word
            swpb    r8
            cmp.b   #0x23, r8
            jeq     decryption_done_whole_word
            swpb    r8

            mov.w   r8, 0(r7)                       ; storing decrypted word
            incd    r7
            jmp     decrypt_next_word

decryption_done_half_word:
            mov.b   r8, 0(r7)
            jmp     done_encryption

decryption_done_whole_word:
            mov.w   r8, 0(r7) 

done_decryption:
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
xor_words:
            xor.w   r6, r8

            ret

xor_bytes:
            xor.b   r6, r8

            ret

.section    ".vectors", "a"
.org    0x1e
    .word   main
