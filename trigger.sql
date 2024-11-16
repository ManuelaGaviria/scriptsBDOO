CREATE OR REPLACE TRIGGER trg_examen_oral_presentado
AFTER INSERT ON EXAMENES_ORALES_PRESENTADOS
FOR EACH ROW
DECLARE
  v_numero_examen NUMBER;
  v_nota_examen_escrito NUMBER;
  v_promedio NUMBER;
BEGIN
  BEGIN
    -- Obtener el NUMERO_EXAMEN correspondiente al examen oral
    SELECT e.NUMERO_EXAMEN INTO v_numero_examen
    FROM EXAMENES e
    JOIN EXAMENES_ORALES eo ON eo.CODIGO_EXAMEN_ORAL = :NEW.ID_EXAMEN
    WHERE e.ORAL.CODIGO_EXAMEN_ORAL = eo.CODIGO_EXAMEN_ORAL;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001, 'Error: NUMERO_EXAMEN no encontrado para el ID_EXAMEN oral ' || :NEW.ID_EXAMEN);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'Error desconocido al obtener NUMERO_EXAMEN: ' || SQLERRM);
  END;

  -- Intentar obtener la nota del examen escrito asociada, si existe
  BEGIN
    SELECT es.NOTA INTO v_nota_examen_escrito
    FROM EXAMENES_ESCRITOS_PRESENTADOS es
    WHERE es.ID_EXAMEN = :NEW.ID_EXAMEN AND es.DNI_ESTUDIANTE = :NEW.DNI_ESTUDIANTE;
    
    -- Si se encuentra la nota del examen escrito, calcular el promedio
    BEGIN
      v_promedio := PKG_UTILIDADES.function_calcular_promedio(:NEW.NOTA, v_nota_examen_escrito);
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error al calcular el promedio: ' || SQLERRM);
    END;

    -- Actualizar el promedio y estado en la tabla NOTAS
    BEGIN
      UPDATE NOTAS
      SET PROMEDIO = v_promedio,
          ESTADO = CASE WHEN v_promedio > 4.0 THEN 1 ELSE 2 END
      WHERE ID_EXAMEN = v_numero_examen AND DNI_ESTUDIANTE=:NEW.DNI_ESTUDIANTE;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20004, 'Error al actualizar la tabla NOTAS: ' || SQLERRM);
    END;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- Si no se encuentra la nota del examen escrito, insertar en NOTAS solo con la nota del examen oral
      BEGIN
        INSERT INTO NOTAS (ID_EXAMEN, DNI_ESTUDIANTE, PROMEDIO, ESTADO)
        VALUES (v_numero_examen, :NEW.DNI_ESTUDIANTE, :NEW.NOTA, 3);
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20005, 'Error al insertar en la tabla NOTAS: ' || SQLERRM);
      END;
  END;
END;
/

CREATE OR REPLACE TRIGGER trg_examen_escrito_presentado
AFTER INSERT ON EXAMENES_ESCRITOS_PRESENTADOS
FOR EACH ROW
DECLARE
  v_numero_examen NUMBER;
  v_nota_examen_oral NUMBER;
  v_promedio NUMBER;
BEGIN
  BEGIN
    -- Obtener el NUMERO_EXAMEN correspondiente al examen escrito
    SELECT e.NUMERO_EXAMEN INTO v_numero_examen
    FROM EXAMENES e
    JOIN EXAMENES_ESCRITOS ee ON ee.CODIGO_EXAMEN_ESCRITO = :NEW.ID_EXAMEN
    WHERE e.ESCRITO.CODIGO_EXAMEN_ESCRITO = ee.CODIGO_EXAMEN_ESCRITO;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001, 'Error: NUMERO_EXAMEN no encontrado para el ID_EXAMEN escrito ' || :NEW.ID_EXAMEN);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'Error desconocido al obtener NUMERO_EXAMEN: ' || SQLERRM);
  END;

  -- Intentar obtener la nota del examen oral asociada, si existe
  BEGIN
    SELECT eo.NOTA INTO v_nota_examen_oral
    FROM EXAMENES_ORALES_PRESENTADOS eo
    WHERE eo.ID_EXAMEN = :NEW.ID_EXAMEN AND eo.DNI_ESTUDIANTE = :NEW.DNI_ESTUDIANTE;
    
    -- Si se encuentra la nota del examen oral, calcular el promedio
    BEGIN
      v_promedio := PKG_UTILIDADES.function_calcular_promedio(v_nota_examen_oral, :NEW.NOTA);
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error al calcular el promedio: ' || SQLERRM);
    END;

    -- Actualizar el promedio y estado en la tabla NOTAS
    BEGIN
      UPDATE NOTAS
      SET PROMEDIO = v_promedio,
          ESTADO = CASE WHEN v_promedio > 4.0 THEN 1 ELSE 2 END
     WHERE ID_EXAMEN = v_numero_examen AND DNI_ESTUDIANTE=:NEW.DNI_ESTUDIANTE;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20004, 'Error al actualizar la tabla NOTAS: ' || SQLERRM);
    END;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- Si no se encuentra la nota del examen oral, insertar en NOTAS solo con la nota del examen escrito
      BEGIN
        INSERT INTO NOTAS (ID_EXAMEN, DNI_ESTUDIANTE, PROMEDIO, ESTADO)
        VALUES (v_numero_examen, :NEW.DNI_ESTUDIANTE, :NEW.NOTA, 3);
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20005, 'Error al insertar en la tabla NOTAS: ' || SQLERRM);
      END;
  END;
END;
/