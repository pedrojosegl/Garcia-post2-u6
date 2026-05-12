; lab6_modos.asm - Demostracion de modos de direccionamiento x86
; Compilar: nasm -f bin lab6_modos.asm -o lab6_modos.com
; Estudiante: Garcia

org 100h

; ── Datos ────────────────────────────────────────────────────────────────
jmp inicio

; Array de 5 enteros de 16 bits
array   dw 10, 20, 30, 40, 50

; Registro de estudiante
nota1   dw 85
nota2   dw 73
promedio dw 0

; Variable simple para direccionamiento directo
var_x   dw 0FFFFh

; Tabla de bytes para XLAT
tabla_hex db 30h,31h,32h,33h,34h,35h,36h,37h
          db 38h,39h,41h,42h,43h,44h,45h,46h

; ── Codigo ───────────────────────────────────────────────────────────────
inicio:

; ── MODO 1: INMEDIATO ────────────────────────────────────────────────────
; El operando es una constante dentro de la instruccion
    MOV ax, 100         ; AX = 100 inmediato decimal
    MOV bx, 0A5h        ; BX = 0xA5 inmediato hex
    ADD cx, 55          ; CX += 55 inmediato aritmetico
    AND dx, 00FFh       ; DX AND mascara inmediata

; ── MODO 2: DIRECTO ──────────────────────────────────────────────────────
; La direccion del operando esta fija en la instruccion
    MOV ax, [var_x]         ; AX = 0FFFFh
    MOV bx, [array]         ; BX = 10 (primer elemento)
    MOV cx, [nota1]         ; CX = 85
    MOV [var_x], word 0     ; escribe 0 en memoria

; ── MODO 3: INDIRECTO POR REGISTRO ───────────────────────────────────────
; El registro contiene la direccion del operando
    MOV si, nota1       ; SI = direccion de nota1
    MOV ax, [si]        ; AX = mem[SI] = 85
    MOV si, nota2       ; SI = direccion de nota2
    MOV bx, [si]        ; BX = mem[SI] = 73
    ADD ax, bx          ; AX = 85 + 73 = 158
    SHR ax, 1           ; AX = 79 (promedio)
    MOV si, promedio    ; SI = direccion de promedio
    MOV [si], ax        ; guarda 79 en promedio

; ── MODO 4: INDEXADO (BASE + INDICE + DESPLAZAMIENTO) ────────────────────
; Direccion efectiva = Base + Indice + Desplazamiento
    MOV bx, array       ; BX = direccion base del array
    MOV si, 4           ; SI = indice 2 * 2 = 4
    MOV ax, [bx + si]   ; AX = array[2] = 30

    ; Suma acumulada del array
    XOR ax, ax          ; AX = 0
    MOV bx, array       ; BX = base
    MOV cx, 5           ; CX = contador
    XOR si, si          ; SI = 0
.bucle_array:
    ADD ax, [bx + si]   ; AX += array[si/2]
    ADD si, 2           ; avanzar 2 bytes
    LOOP .bucle_array
    ; AX = 10+20+30+40+50 = 150

    ; Acceso a struct con desplazamiento fijo
    MOV bx, nota1       ; BX = base del struct
    MOV ax, [bx]        ; AX = nota1 = 85
    MOV cx, [bx + 2]    ; CX = nota2 = 73
    MOV dx, [bx + 4]    ; DX = promedio = 79

    INT 20h             ; retornar a DOS