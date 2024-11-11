-- Trigger para EXAMENES_ORALES_PRESENTADOS
CREATE OR REPLACE TRIGGER TRG_INSERT_UPDATE_NOTAS_ORALES
AFTER INSERT OR UPDATE ON EXAMENES_ORALES_PRESENTADOS
FOR EACH ROW
DECLARE
    nota_examen_oral NUMBER(3, 2) := :NEW.NOTA;
    nota_examen_escrito NUMBER(3, 2) := 0.0;
    promedio NUMBER(3, 2);
    estado NUMBER(1);
BEGIN
    -- Intentar obtener la nota del examen escrito si ya existe
    BEGIN
        SELECT NOTA INTO nota_examen_escrito
        FROM EXAMENES_ESCRITOS_PRESENTADOS
        WHERE ID_EXAMEN = :NEW.ID_EXAMEN AND DNI_ESTUDIANTE = :NEW.DNI_ESTUDIANTE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            nota_examen_escrito := 0.0; -- Si no hay nota de examen escrito, usar 0.0
    END;

    -- Calcular el promedio inicial
    promedio := PKG_UTILIDADES.function_calcular_promedio(nota_examen_oral, nota_examen_escrito);

    -- Determinar el estado en función del promedio inicial
    IF nota_examen_escrito = 0.0 THEN
        estado := 3; -- Estado pendiente si falta la nota de examen escrito
    ELSE
        estado := CASE WHEN promedio > 4 THEN 1 ELSE 2 END;
    END IF;

    -- Insertar o actualizar en la tabla NOTAS
    BEGIN
        UPDATE NOTAS
        SET PROMEDIO = promedio, ESTADO = estado
        WHERE ID_EXAMEN = :NEW.ID_EXAMEN;

        -- Si no se actualizó ninguna fila, insertamos un nuevo registro en NOTAS
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO NOTAS (ID_EXAMEN, PROMEDIO, ESTADO)
            VALUES (:NEW.ID_EXAMEN, promedio, estado);
        END IF;
    END;
END;
/

-- Trigger para EXAMENES_ESCRITOS_PRESENTADOS
CREATE OR REPLACE TRIGGER TRG_INSERT_UPDATE_NOTAS_ESCRITOS
AFTER INSERT OR UPDATE ON EXAMENES_ESCRITOS_PRESENTADOS
FOR EACH ROW
DECLARE
    nota_examen_escrito NUMBER(3, 2) := :NEW.NOTA;
    nota_examen_oral NUMBER(3, 2) := 0.0;
    promedio NUMBER(3, 2);
    estado NUMBER(1);
BEGIN
    -- Intentar obtener la nota del examen oral si ya existe
    BEGIN
        SELECT NOTA INTO nota_examen_oral
        FROM EXAMENES_ORALES_PRESENTADOS
        WHERE ID_EXAMEN = :NEW.ID_EXAMEN AND DNI_ESTUDIANTE = :NEW.DNI_ESTUDIANTE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            nota_examen_oral := 0.0; -- Si no hay nota de examen oral, usar 0.0
    END;

    -- Calcular el promedio inicial
    promedio := PKG_UTILIDADES.function_calcular_promedio(nota_examen_oral, nota_examen_escrito);

    -- Determinar el estado en función del promedio inicial
    IF nota_examen_oral = 0.0 THEN
        estado := 3; -- Estado pendiente si falta la nota de examen oral
    ELSE
        estado := CASE WHEN promedio > 4 THEN 1 ELSE 2 END;
    END IF;

    -- Insertar o actualizar en la tabla NOTAS
    BEGIN
        UPDATE NOTAS
        SET PROMEDIO = promedio, ESTADO = estado
        WHERE ID_EXAMEN = :NEW.ID_EXAMEN;

        -- Si no se actualizó ninguna fila, insertamos un nuevo registro en NOTAS
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO NOTAS (ID_EXAMEN, PROMEDIO, ESTADO)
            VALUES (:NEW.ID_EXAMEN, promedio, estado);
        END IF;
    END;
END;
/
