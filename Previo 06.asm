ORG 0000H                  ; Define la dirección de inicio

INICIO: LD SP,27FFH        ; Inicia la localidad de la pila
        LD A,089H          ; PA = Salida, PB = Salida y PC = Entrada
        OUT (03H),A        ; Envía al puerto de control
        LD A,00H           ; Limpia la localidad 2000H
        LD (2000H),A
        CALL CHECA         ; Checa el código generado por el teclado

CICLO:  LD A,(2000H)       ; Carga en el acumulador el último dato almacenado
        AND 0FH            ; Enmascara para mostrar solo los 4 bits menos significativos
        OUT (00H),A        ; Saca el dato al puerto A
        CALL CHECA
        JP CICLO           ; Repite el ciclo de forma infinita

CHECA:  IN A,(02H)         ; Inserta el dato del teclado desde el puerto C
        AND 7FH            ; Limpia el bit más significativo
        CP  7FH            ; Compara con 7FH para ver si hay tecla presionada
        RET Z              ; Si no hay tecla presionada, regresa
        LD H,00H
        LD L,A
        LD A,(HL)          ; Accede a la localidad sobre la tabla
        AND 0FH            ; Enmascara para obtener solo los 4 bits menos significativos
        LD (2000H),A       ; Guarda el dato en la memoria
        RET

        ORG 37H
        DB 01H             ; Tabla de asignación de valores para cada tecla
        ORG 57H
        DB 02H
        ORG 67H
        DB 03H
        ORG 3BH
        DB 04H
        ORG 5BH
        DB 05H
        ORG 6BH
        DB 06H
        ORG 3DH
        DB 07H
        ORG 5DH
        DB 08H
        ORG 6DH
        DB 09H
        ORG 3EH
        DB 0AH
        ORG 5EH
        DB 00H
        ORG 6EH
        DB 0BH
        END