.include "header.s"

.data
encrypted_message:

    .org    0x0100
decrypted_message:

.text
plaintext_message:
.string     "The message key length is 16 bits.  It only contains letters, periods, and spaces.#"
key:
.byte      0xac,0xdf,0x23  
;.byte       0xdf,0xec
;encrypted_rom:
;.byte 0x91,0x85,0xbc,0x89,0xff,0x86,0xb0,0x8e,0xfe,0xcc,0xff,0xb5,0xb0,0x99,0xf8,0x9a,0xba,0xcc,0xac,0x99,0xbc,0x8f,0xba,0x9f,0xac,0x8a,0xaa,0x80,0xb3,0x95,0xff,0x89,0xb1,0x8f,0xad,0x95,0xaf,0x98,0xba,0x88,0xff,0x8d,0xff,0x81,0xba,0x9f,0xac,0x8d,0xb8,0x89,0xff,0x99,0xac,0x85,0xb1,0x8b,0xff,0x8d,0xff,0x9b,0xb0,0x9e,0xbb,0xc1,0xb3,0x89,0xb1,0x8b,0xab,0x84,0xff,0x87,0xba,0x95,0xff,0x8d,0xb1,0x88,0xff,0x8d,0xbc,0x84,0xb6,0x89,0xa9,0x89,0xbb,0xcc,0x9d,0xcc,0x99,0x99,0xb1,0x8f,0xab,0x85,0xb0,0x82,0xbe,0x80,0xb6,0x98,0xa6,0xcd,0xfc
encrypted_rom:
.byte   0xf8,0xb7,0x46,0x8c,0xb2,0x46,0xdf,0xac,0x42,0xcb,0xba,0x03,0xc7,0xba,0x5a,0x8c,0xb3,0x46,0xc2,0xb8,0x57,0xc4,0xff,0x4a,0xdf,0xff,0x12,0x9a,0xff,0x41,0xc5,0xab,0x50,0x82,0xff,0x03,0xe5,0xab,0x03,0xc5,0xac,0x03,0xcd,0xb1,0x03,0xe9,0xb1,0x44,0xc0,0xb6,0x50,0xc4,0xff,0x50,0xc9,0xb1,0x57,0xc9,0xb1,0x40,0xc9,0xf1,0x00

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
    mov.w   #3,r8                               ;key length in bytes

    call    #encrypt_message

    ;load registers
    mov.w   #encrypted_message, r5
    mov.w   #key, r6
    mov.w   #decrypted_message, r7
    mov.w   #3,r8                               ;key length in bytes

    call    #decrypt_message

    ;load registers
    ;mov.w   #encrypted_rom, r5
    ;mov.w   #key, r6
    ;mov.w   #decrypted_message, r7
    ;mov.w   #3,r8                               ;key length in bytes

    ;call    #decrypt_message

forever:
    jmp     forever

;---------------------------------------------------
;Subroutine Name: encrypt_message
;Authoer: Capt Todd Branchflower, USAF
;Function: Takes in the location of an encrypted message  and key
; and uses the xor_bytes subroutine to decrypt it.  It
; stores the results at a passed in memory location.  Stops when
; the ASCII character # is encountered.
;Inputs: 
; - plain text message address in r5 (reference)
; - key address in r6 (reference)
; - encrypted message address in r7 (reference)
; - key length in r8 (value)
;Outputs: none
;Registers destroyed: none
;---------------------------------------------------
encrypt_message:
            ; saving registers
            push.w  r5
            push.w  r7
            push.w  r8
           
            mov.w   r6, r9
            mov.w   r9, r11
            mov.w   r8, r10

encrypt_next_byte:
            mov.b   @r5+, r8                        ; retrieving next byte
            cmp.b   #0x23, r8
            jeq     encryption_done
            call    #xor_byte_with_arbitrary_length_key
            mov.b   r8, 0(r7)                       ; storing encrypted byte
            inc     r7
            jmp     encrypt_next_byte

encryption_done:
            call    #xor_byte_with_arbitrary_length_key
            mov.b   r8, 0(r7)

            ; restoring registers
            pop.w   r8
            pop.w   r7
            pop.w   r5
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
            cmp.b   #0x23, r8
            jeq     decryption_done
            inc     r7
            jmp     decrypt_next_byte

decryption_done:
            ; restoring registers
            pop.w   r8
            pop.w   r7
            pop.w   r5
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
