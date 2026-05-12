\# Garcia-post2-u6

\## Laboratorio: Demostración de Modos de Direccionamiento x86



\## Tabla de Modos de Direccionamiento



| Modo | Fórmula dirección efectiva | Instrucción NASM | Valor en DEBUG |

|------|---------------------------|------------------|----------------|

| Inmediato | El valor está en el opcode | `MOV AX, 100` | AX = 0064h |

| Directo | EA = dirección fija en instrucción | `MOV AX, \[var\_x]` | AX = FFFFh |

| Indirecto por registro | EA = contenido del registro | `MOV AX, \[SI]` | AX = 0055h |

| Indexado | EA = Base + Índice + Desplazamiento | `MOV AX, \[BX+SI]` | AX = 0096h |



\## Checkpoint 2 — Trazado Modo Indirecto



| Instrucción | Registro modificado | Valor resultante |

|-------------|--------------------|--------------------|

| `MOV SI, 010C` | SI | 010Ch (dir. nota1) |

| `MOV AX, \[SI]` | AX | 0055h (85 decimal) |

| `MOV SI, 010E` | SI | 010Eh (dir. nota2) |

| `MOV BX, \[SI]` | BX | 0049h (73 decimal) |

| `ADD AX, BX` | AX | 009Eh (158 decimal) |



\## Capturas

\- Checkpoint 1: dump del array en DEBUG

\- Checkpoint 2: trazado modo indirecto

\- Checkpoint 3: AX=0096h (150) al finalizar bucle indexado

