global _pi_asm

section .data
    four dd 4.0           ; Stała do mnożenia wyniku

section .text
_pi_asm:
    push ebp
    mov ebp, esp

    finit                  ; Inicjalizacja FPU
    fldz                   ; Wynik początkowy = 0

    mov ecx, [ebp + 8]     ; Pobranie liczby iteracji n
    xor eax, eax           ; eax = k = 0 (indeks szeregu)

pi_loop:
    push eax               ; Zapisujemy k na stosie

    ; Obliczanie (-1)^k
    test eax, 1            ; Sprawdzenie parzystości k
    jz pos_term            ; Jeśli parzyste, wynik jest dodatni
    fld1                   ; Załaduj 1
    fchs                   ; Zmień znak na przeciwny
    jmp next_step
pos_term:
    fld1                   ; Załaduj 1 (bez zmiany znaku)

next_step:
    ; Obliczanie 2k + 1
    mov edx, eax           ; edx = k
    shl edx, 1             ; edx = 2k
    add edx, 1             ; edx = 2k + 1
    push edx
    fild dword [esp]       ; Załaduj 2k + 1 jako liczbę zmiennoprzecinkową
    pop edx

    ; Wykonanie 1 / (2k + 1)
    fdivp                  ; (-1)^k / (2k + 1)

    ; Dodanie lub odjęcie wyrazu do wyniku końcowego
    faddp                  ; Dodaj do akumulatora

    pop eax                ; Przywróć k
    inc eax                ; k = k + 1
    loop pi_loop           ; Powtarzaj, aż do końca iteracji

    ; Mnożenie przez 4
    fld dword [four]       ; Załaduj 4
    fmulp                  ; Pomnóż wynik

    leave
    ret