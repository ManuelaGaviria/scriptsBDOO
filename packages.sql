--DROP PACKAGES
DROP PACKAGE BODY PKG_AUDITORIA;
DROP PACKAGE PKG_AUDITORIA;
DROP PACKAGE BODY PKG_ASIGNACION_AUTOMATICA;
DROP PACKAGE PKG_ASIGNACION_AUTOMATICA;
DROP PACKAGE BODY PKG_CLASES;
DROP PACKAGE PKG_CLASES;

--------------------------------------------------------------------------------
--Paquete para la auditoria
-- Especificación del paquete
CREATE OR REPLACE PACKAGE PKG_AUDITORIA
AS
  PROCEDURE log_audit_action(
    p_nombre_tabla VARCHAR2,
    p_operacion VARCHAR2,
    p_id_registro INTEGER,
    p_descripcion VARCHAR2
  );
END PKG_AUDITORIA;
/

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY PKG_AUDITORIA
AS
  PROCEDURE log_audit_action(
    p_nombre_tabla VARCHAR2,
    p_operacion VARCHAR2,
    p_id_registro INTEGER,
    p_descripcion VARCHAR2
  )
  IS
  BEGIN
    INSERT INTO AUDITORIAS_CLASES_PROG (
        CODIGO_AUD,
        NOMBRE_TABLA,
        OPERACION,
        ID_REGISTRO,
        DESCRIPCION,
        FECHA
    ) VALUES (
        SEQ_AUD_CLAS_PROG.NEXTVAL,
        p_nombre_tabla,
        p_operacion,
        p_id_registro,
        p_descripcion,
        SYSTIMESTAMP
    );
  END log_audit_action;  -- Asegura que coincida con la declaración en la especificación
END PKG_AUDITORIA;
/

------------------------------------------------------------------------------
--Paquete de Asignación Automática
-- Especificación del paquete
CREATE OR REPLACE PACKAGE PKG_ASIGNACION_AUTOMATICA
AS
  FUNCTION default_professor(
    p_fecha IN DATE,
    p_hora IN NUMBER
  ) RETURN USUARIO;

  FUNCTION default_salon_code(
    p_fecha IN DATE,
    p_hora IN NUMBER
  ) RETURN NUMBER;
END PKG_ASIGNACION_AUTOMATICA;
/

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY PKG_ASIGNACION_AUTOMATICA
AS
  FUNCTION default_professor(
    p_fecha IN DATE,
    p_hora IN NUMBER
  ) RETURN USUARIO
  IS
    v_profesor USUARIO;
  BEGIN
    BEGIN
      SELECT VALUE(u) INTO v_profesor
      FROM USUARIOS u
      WHERE u.ROL_USU = 3
        AND u.DNI_USU NOT IN (
            SELECT CP.PROFESOR.DNI_USU
            FROM CLASES_PROGRAMADAS CP
            WHERE CP.FECHA = p_fecha AND CP.COD_HORA = p_hora
        )
      ORDER BY DBMS_RANDOM.VALUE
      FETCH FIRST 1 ROWS ONLY;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;

    RETURN v_profesor;
  END default_professor;

  --cambia left join de clases programadas a cupos
  FUNCTION default_salon_code(
    p_fecha IN DATE,
    p_hora IN NUMBER
  ) RETURN NUMBER
  IS
    v_salon_code NUMBER;
  BEGIN
    SELECT CODIGO_SALON INTO v_salon_code
    FROM (SELECT s.CODIGO_SALON
          FROM SALONES s
          LEFT JOIN CLASES_PROGRAMADAS cp
          ON s.CODIGO_SALON = cp.COD_SALON
             AND cp.FECHA = p_fecha
             AND cp.COD_HORA = p_hora
          GROUP BY s.CODIGO_SALON, s.CAPACIDAD_SALON, cp.CUPOS_REGISTRADOS
          HAVING NVL(cp.CUPOS_REGISTRADOS, 0) < s.CAPACIDAD_SALON
          ORDER BY DBMS_RANDOM.VALUE)
    WHERE ROWNUM = 1;

    RETURN v_salon_code;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
  END default_salon_code;
END PKG_ASIGNACION_AUTOMATICA;
/

--------------------------------------------------------------------------------
--Paquete de Manejo de Clases
-- Especificación del paquete
CREATE OR REPLACE PACKAGE PKG_CLASES
AS
  PROCEDURE agregar_estudiante_clase(
    p_cod_clase_prog IN NUMBER,
    p_dni_usu IN VARCHAR2
  );

  PROCEDURE controlador_clases(
    p_fecha DATE,
    p_hora NUMBER,
    p_dni VARCHAR2
  );

  FUNCTION estudiante_ya_programado(
    p_fecha DATE,
    p_hora NUMBER,
    p_dni VARCHAR2
  ) RETURN BOOLEAN;
END PKG_CLASES;
/

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY PKG_CLASES
AS
    FUNCTION estudiante_ya_programado(
    p_fecha DATE,
    p_hora NUMBER,
    p_dni VARCHAR2
  ) RETURN BOOLEAN
  IS
    v_count NUMBER;
  BEGIN
  --Ahora las tres operaciones son sobre cp
    SELECT COUNT(*)
    INTO v_count
    FROM CLASES_PROGRAMADAS cp, TABLE(cp.ESTUDIANTES) e
    WHERE cp.FECHA = p_fecha
      AND cp.COD_HORA = p_hora
      AND e.DNI_USU = p_dni;

    RETURN v_count > 0;
  END estudiante_ya_programado;

  PROCEDURE agregar_estudiante_clase(
    p_cod_clase_prog IN NUMBER,
    p_dni_usu IN VARCHAR2
  )
  IS
    v_clase CLASE_PROGRAMADA;
    v_estudiante USUARIO;
  BEGIN
    -- Obtener la clase programada en una variable temporal
    SELECT VALUE(cp) INTO v_clase 
    FROM CLASES_PROGRAMADAS cp 
    WHERE cp.COD_CLASE_PROG = p_cod_clase_prog
    FOR UPDATE;

    -- Obtener la información del estudiante desde la tabla USUARIOS
    SELECT VALUE(u) INTO v_estudiante 
    FROM USUARIOS u 
    WHERE u.DNI_USU = p_dni_usu;

    -- Agregar el estudiante al final de la colección ESTUDIANTES
    v_clase.ESTUDIANTES.EXTEND;
    v_clase.ESTUDIANTES(v_clase.ESTUDIANTES.COUNT) := v_estudiante;

    -- Aumentar CUPOS_REGISTRADOS en 1
    v_clase.CUPOS_REGISTRADOS := v_clase.CUPOS_REGISTRADOS + 1;

    -- Actualizar la clase programada con los cambios
    UPDATE CLASES_PROGRAMADAS cp
    SET cp.ESTUDIANTES = v_clase.ESTUDIANTES,
        cp.CUPOS_REGISTRADOS = v_clase.CUPOS_REGISTRADOS
    WHERE cp.COD_CLASE_PROG = p_cod_clase_prog;

    COMMIT;
  END agregar_estudiante_clase;

  PROCEDURE controlador_clases(
    p_fecha DATE,
    p_hora NUMBER,
    p_dni VARCHAR2
  )
  IS
    v_cod_clase_prog NUMBER;
    v_salon_code NUMBER;
    v_profesor_dni USUARIO;
  BEGIN
    -- Llamada a la función para verificar si el estudiante ya está programado
    IF estudiante_ya_programado(p_fecha, p_hora, p_dni) THEN
      RAISE_APPLICATION_ERROR(-20003, 'El estudiante ya tiene una clase programada en esta fecha y hora.');
    END IF;

    --select count en clases_programads donde fecha y hora, contar cuántos hay
    --Si hay menos de 6, llamamos al procedimiento de agregar
    
    -- Verificar clases existentes en la fecha y hora dadas
    FOR clase_rec IN (
        SELECT COD_CLASE_PROG, CUPOS_REGISTRADOS
        FROM CLASES_PROGRAMADAS
        WHERE FECHA = p_fecha
          AND COD_HORA = p_hora
    ) LOOP
        IF clase_rec.CUPOS_REGISTRADOS < 6 THEN
            v_cod_clase_prog := clase_rec.COD_CLASE_PROG;
            agregar_estudiante_clase(v_cod_clase_prog, p_dni);
            PKG_AUDITORIA.log_audit_action('CLASES_PROGRAMADAS', 'UPDATE', v_cod_clase_prog, 'Added student ' || p_dni);
            RETURN;
        END IF;
    END LOOP;

    v_cod_clase_prog := CLASES_PROGRAMADAS_SEQ.NEXTVAL;

    -- Llamar a la función de asignación de salón desde el paquete PKG_ASIGNACION_AUTOMATICA
    v_salon_code := PKG_ASIGNACION_AUTOMATICA.default_salon_code(p_fecha, p_hora);
    IF v_salon_code IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'No available salons for the specified date and time.');
    END IF;

    -- Llamar a la función de asignación de profesor desde el paquete PKG_ASIGNACION_AUTOMATICA
    v_profesor_dni := PKG_ASIGNACION_AUTOMATICA.default_professor(p_fecha, p_hora);
    IF v_profesor_dni IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'No available professors for the specified date and time.');
    END IF;

    -- Insertar la nueva clase con el salón y profesor asignados

    --Este insert cambia
    INSERT INTO CLASES_PROGRAMADAS (
        COD_CLASE_PROG, COD_NIVEL, FECHA, COD_HORA, COD_SALON, CUPOS_REGISTRADOS, PROFESOR, ESTUDIANTES
    ) VALUES (
        v_cod_clase_prog,
        1,
        p_fecha,
        p_hora,
        TO_NUMBER(v_salon_code),
        0,
        v_profesor_dni,
        USUARIOS_TBL()
    );

    agregar_estudiante_clase(v_cod_clase_prog, p_dni);
    PKG_AUDITORIA.log_audit_action('CLASES_PROGRAMADAS', 'INSERT', v_cod_clase_prog, 'Created new class and added student ' || p_dni);

    COMMIT;
  END controlador_clases;
END PKG_CLASES;
/

----------------------------------------------------------------------------------------
--Paquete de utilidades
-- Especificación del paquete
CREATE OR REPLACE PACKAGE PKG_UTILIDADES AS
  FUNCTION function_calcular_promedio(
    nota_examen_oral NUMBER,
    nota_examen_escrito NUMBER
  ) RETURN NUMBER;
END PKG_UTILIDADES;
/

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY PKG_UTILIDADES AS

  FUNCTION function_calcular_promedio(
    nota_examen_oral NUMBER,
    nota_examen_escrito NUMBER
  ) RETURN NUMBER
  IS
    sumarespuesta NUMBER(5, 2) := 0.0;
    respuesta NUMBER(5, 2) := 0.0;
  BEGIN
    sumarespuesta := nota_examen_oral + nota_examen_escrito;
    respuesta := sumarespuesta / 2;
    RETURN respuesta;
  END function_calcular_promedio;

END PKG_UTILIDADES;
/
--------------------------------------------------------------------------------------------



