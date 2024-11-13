INSERT INTO ESTADOS (CODIGO_ESTADO, NOMBRE_ESTADO) VALUES (1, 'Activo');
INSERT INTO ESTADOS (CODIGO_ESTADO, NOMBRE_ESTADO) VALUES (2, 'Inactivo');

INSERT INTO ESTADOS_EXAMENES (CODIGO_ESTADO, ESTADO_EXAMEN) VALUES (1, 'Aprobado');
INSERT INTO ESTADOS_EXAMENES (CODIGO_ESTADO, ESTADO_EXAMEN) VALUES (2, 'Reprobado');
INSERT INTO ESTADOS_EXAMENES (CODIGO_ESTADO, ESTADO_EXAMEN) VALUES (3, 'Pendiente');

INSERT INTO ROLES (CODIGO_ROL, NOMBRE_ROL) VALUES (1, 'Administrador');
INSERT INTO ROLES (CODIGO_ROL, NOMBRE_ROL) VALUES (2, 'Estudiante');
INSERT INTO ROLES (CODIGO_ROL, NOMBRE_ROL) VALUES (3, 'Profesor');

INSERT INTO SEXOS (CODIGO_SEX, NOMBRE_SEX) VALUES (1, 'Masculino');
INSERT INTO SEXOS (CODIGO_SEX, NOMBRE_SEX) VALUES (2, 'Femenino');

INSERT INTO TIPODOCUMENTOS (CODIGO_TIPODOC, NOMBRE_DOC) VALUES (1, 'Cédula de Ciudadanía');
INSERT INTO TIPODOCUMENTOS (CODIGO_TIPODOC, NOMBRE_DOC) VALUES (2, 'Cédula de Extranjería');
INSERT INTO TIPODOCUMENTOS (CODIGO_TIPODOC, NOMBRE_DOC) VALUES (3, 'Pasaporte');
INSERT INTO TIPODOCUMENTOS (CODIGO_TIPODOC, NOMBRE_DOC) VALUES (4, 'Tarjeta de Identidad');

-- Inserts para la tabla SALONES
INSERT INTO SALONES (CODIGO_SALON, NUMERO_SALON, CAPACIDAD_SALON) VALUES (1, 101, 6);
INSERT INTO SALONES (CODIGO_SALON, NUMERO_SALON, CAPACIDAD_SALON) VALUES (2, 102, 6);
INSERT INTO SALONES (CODIGO_SALON, NUMERO_SALON, CAPACIDAD_SALON) VALUES (3, 103, 6);

-- Inserts para la tabla HORAS
INSERT INTO HORAS (CODIGO_HORA, HORA_INICIAL, HORA_FINAL) VALUES (1, '08:00', '09:30');
INSERT INTO HORAS (CODIGO_HORA, HORA_INICIAL, HORA_FINAL) VALUES (2, '10:00', '11:30');
INSERT INTO HORAS (CODIGO_HORA, HORA_INICIAL, HORA_FINAL) VALUES (3, '13:00', '14:30');
INSERT INTO HORAS (CODIGO_HORA, HORA_INICIAL, HORA_FINAL) VALUES (4, '15:00', '16:30');

-- Inserts para la tabla NIVELES
INSERT INTO NIVELES (CODIGO_NIVEL, NIVEL) VALUES (1, 'A1');
INSERT INTO NIVELES (CODIGO_NIVEL, NIVEL) VALUES (2, 'A2');
INSERT INTO NIVELES (CODIGO_NIVEL, NIVEL) VALUES (3, 'B1');
INSERT INTO NIVELES (CODIGO_NIVEL, NIVEL) VALUES (4, 'B2');
INSERT INTO NIVELES (CODIGO_NIVEL, NIVEL) VALUES (5, 'C1');


INSERT INTO Usuarios VALUES (
    '123456789',            -- DNI_USU
    'Juan',                 -- NOMBRE_USU
    'Pérez',                -- APELLIDO1_USU
    'Gómez',                -- APELLIDO2_USU
    1,                      -- TIPODOC_USU (debe existir en TIPODOCUMENTOS)
    'juan.perez@example.com', -- CORREO_USU
    1,                      -- SEXO_USU (debe existir en SEXOS)
    'password123',          -- CONTRASENNA_USU
    TO_DATE('1990-01-01', 'YYYY-MM-DD'), -- NACIMIENTO_USU
    1,                      -- ESTADO_USU (debe existir en ESTADOS)
    3                       -- ROL_USU (debe existir en ROLES)
);

INSERT INTO Usuarios VALUES (
    '555555',            -- DNI_USU
    'Alba',                 -- NOMBRE_USU
    'Moreno',                -- APELLIDO1_USU
    'Londoño',                -- APELLIDO2_USU
    1,                      -- TIPODOC_USU (debe existir en TIPODOCUMENTOS)
    'alba@example.com', -- CORREO_USU
    1,                      -- SEXO_USU (debe existir en SEXOS)
    'password123',          -- CONTRASENNA_USU
    TO_DATE('1974-04-13', 'YYYY-MM-DD'), -- NACIMIENTO_USU
    1,                      -- ESTADO_USU (debe existir en ESTADOS)
    3                       -- ROL_USU (debe existir en ROLES)
);

INSERT INTO Usuarios VALUES (
    '1000412597',            -- DNI_USU
    'Manuela',                 -- NOMBRE_USU
    'Gaviria',                -- APELLIDO1_USU
    'Moreno',                -- APELLIDO2_USU
    1,                      -- TIPODOC_USU (debe existir en TIPODOCUMENTOS)
    'mangav@example.com', -- CORREO_USU
    1,                      -- SEXO_USU (debe existir en SEXOS)
    'password123',          -- CONTRASENNA_USU
    TO_DATE('2002-07-05', 'YYYY-MM-DD'), -- NACIMIENTO_USU
    1,                      -- ESTADO_USU (debe existir en ESTADOS)
    2                       -- ROL_USU (debe existir en ROLES)
);

INSERT INTO Usuarios VALUES (
    '123456',            -- DNI_USU
    'Juan',                 -- NOMBRE_USU
    'Muriel',                -- APELLIDO1_USU
    'Rendon',                -- APELLIDO2_USU
    1,                      -- TIPODOC_USU (debe existir en TIPODOCUMENTOS)
    'juanjo@example.com', -- CORREO_USU
    1,                      -- SEXO_USU (debe existir en SEXOS)
    'password123',          -- CONTRASENNA_USU
    TO_DATE('2004-10-03', 'YYYY-MM-DD'), -- NACIMIENTO_USU
    1,                      -- ESTADO_USU (debe existir en ESTADOS)
    2                       -- ROL_USU (debe existir en ROLES)
);

INSERT INTO Usuarios VALUES (
    '1234568',            -- DNI_USU
    'Steven',                 -- NOMBRE_USU
    'Puerta',                -- APELLIDO1_USU
    'Molsalve',                -- APELLIDO2_USU
    1,                      -- TIPODOC_USU (debe existir en TIPODOCUMENTOS)
    'xteven@example.com', -- CORREO_USU
    1,                      -- SEXO_USU (debe existir en SEXOS)
    'password123',          -- CONTRASENNA_USU
    TO_DATE('1990-09-06', 'YYYY-MM-DD'), -- NACIMIENTO_USU
    1,                      -- ESTADO_USU (debe existir en ESTADOS)
    2                       -- ROL_USU (debe existir en ROLES)
);

INSERT INTO Usuarios VALUES (
    '123',            -- DNI_USU
    'Sofia',                 -- NOMBRE_USU
    'Guisado',                -- APELLIDO1_USU
    'Atehortua',                -- APELLIDO2_USU
    1,                      -- TIPODOC_USU (debe existir en TIPODOCUMENTOS)
    'sofi@example.com', -- CORREO_USU
    1,                      -- SEXO_USU (debe existir en SEXOS)
    'password123',          -- CONTRASENNA_USU
    TO_DATE('2003-02-04', 'YYYY-MM-DD'), -- NACIMIENTO_USU
    1,                      -- ESTADO_USU (debe existir en ESTADOS)
    2                       -- ROL_USU (debe existir en ROLES)
);

INSERT INTO Usuarios VALUES (
    '1234',            -- DNI_USU
    'Camila',                 -- NOMBRE_USU
    'Gomez',                -- APELLIDO1_USU
    'Holguin',                -- APELLIDO2_USU
    1,                      -- TIPODOC_USU (debe existir en TIPODOCUMENTOS)
    'cami@example.com', -- CORREO_USU
    1,                      -- SEXO_USU (debe existir en SEXOS)
    'password123',          -- CONTRASENNA_USU
    TO_DATE('2003-03-24', 'YYYY-MM-DD'), -- NACIMIENTO_USU
    1,                      -- ESTADO_USU (debe existir en ESTADOS)
    2                       -- ROL_USU (debe existir en ROLES)
);

INSERT INTO Usuarios VALUES (
    '321',            -- DNI_USU
    'Daniel',                 -- NOMBRE_USU
    'Roldan',                -- APELLIDO1_USU
    'Laverde',                -- APELLIDO2_USU
    1,                      -- TIPODOC_USU (debe existir en TIPODOCUMENTOS)
    'daniel@example.com', -- CORREO_USU
    1,                      -- SEXO_USU (debe existir en SEXOS)
    'password123',          -- CONTRASENNA_USU
    TO_DATE('1992-06-04', 'YYYY-MM-DD'), -- NACIMIENTO_USU
    1,                      -- ESTADO_USU (debe existir en ESTADOS)
    2                       -- ROL_USU (debe existir en ROLES)
);

INSERT INTO Usuarios VALUES (
    '4321',            -- DNI_USU
    'Luisa',                 -- NOMBRE_USU
    'Gomez',                -- APELLIDO1_USU
    'Acevedo',                -- APELLIDO2_USU
    1,                      -- TIPODOC_USU (debe existir en TIPODOCUMENTOS)
    'luisa@example.com', -- CORREO_USU
    1,                      -- SEXO_USU (debe existir en SEXOS)
    'password123',          -- CONTRASENNA_USU
    TO_DATE('2004-03-12', 'YYYY-MM-DD'), -- NACIMIENTO_USU
    1,                      -- ESTADO_USU (debe existir en ESTADOS)
    2                       -- ROL_USU (debe existir en ROLES)
);

-- Primero, asegúrate de tener el profesor en el formato de tipo USUARIO
DECLARE
    v_profesor USUARIO := USUARIO('123456789', 'Juan', 'Pérez', 'Gómez', 1, 'juan.perez@example.com', 1, 'password123', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 1, 3);
    v_estudiantes USUARIOS_TBL := USUARIOS_TBL(
        USUARIO('1000412597', 'Manuela', 'Gaviria', 'Moreno', 1, 'mangav@example.com', 1, 'password123', TO_DATE('2002-07-05', 'YYYY-MM-DD'), 1, 2),
        USUARIO('123456', 'Juan', 'Muriel', 'Rendon', 1, 'juanjo@example.com', 1, 'password123', TO_DATE('2004-10-03', 'YYYY-MM-DD'), 1, 2)
    );
BEGIN
    INSERT INTO CLASES_PROGRAMADAS VALUES (
        1,                  -- COD_CLASE_PROG
        1,                  -- COD_NIVEL (debe existir en NIVELES)
        TO_DATE('2024-11-10', 'YYYY-MM-DD'), -- FECHA
        1,                  -- COD_HORA (debe existir en HORAS)
        1,                  -- COD_SALON (debe existir en SALONES)
        2,
        v_profesor,         -- PROFESOR (objeto USUARIO)
        v_estudiantes       -- ESTUDIANTES (tabla anidada USUARIOS_TBL)
    );
END;
/

-- Inserts para la tabla RESPUESTAS
INSERT INTO RESPUESTAS VALUES (1, 'Respuesta correcta', 'Sí');
INSERT INTO RESPUESTAS VALUES (2, 'Respuesta incorrecta', 'No');
INSERT INTO RESPUESTAS VALUES (3, 'Opción válida', 'Sí');
INSERT INTO RESPUESTAS VALUES (4, 'Opción inválida', 'No');

-- Inserts para la tabla PREGUNTAS (usando RESPUESTAS como tabla anidada)
DECLARE
    v_respuestas RESPUESTAS_TBL := RESPUESTAS_TBL(
        RESPUESTA(1, 'Respuesta correcta', 'Sí'),
        RESPUESTA(2, 'Respuesta incorrecta', 'No')
    );
BEGIN
    INSERT INTO PREGUNTAS VALUES (1, '¿Cuál es la respuesta correcta?', v_respuestas);
END;
/

DECLARE
    v_respuestas RESPUESTAS_TBL := RESPUESTAS_TBL(
        RESPUESTA(3, 'Opción válida', 'Sí'),
        RESPUESTA(4, 'Opción inválida', 'No')
    );
BEGIN
    INSERT INTO PREGUNTAS VALUES (2, '¿Es esta opción válida?', v_respuestas);
END;
/

-- Inserts para la tabla EXAMENES_ESCRITOS (usando PREGUNTAS como tabla anidada)
DECLARE
    v_preguntas PREGUNTAS_TBL := PREGUNTAS_TBL(
        PREGUNTA(1, '¿Cuál es la respuesta correcta?', RESPUESTAS_TBL(
            RESPUESTA(1, 'Respuesta correcta', 'Sí'),
            RESPUESTA(2, 'Respuesta incorrecta', 'No')
        )),
        PREGUNTA(2, '¿Es esta opción válida?', RESPUESTAS_TBL(
            RESPUESTA(3, 'Opción válida', 'Sí'),
            RESPUESTA(4, 'Opción inválida', 'No')
        ))
    );
BEGIN
    INSERT INTO EXAMENES_ESCRITOS VALUES (1, v_preguntas);
END;
/

-- Inserts para la tabla EXAMENES_ORALES
INSERT INTO EXAMENES_ORALES VALUES (1, 'http://ejemplo.com/examen_oral_1.mp3');
INSERT INTO EXAMENES_ORALES VALUES (2, 'http://ejemplo.com/examen_oral_2.mp3');

-- Inserts para la tabla EXAMENES (usando un EXAMEN_ORAL y un EXAMEN_ESCRITO anidados)
DECLARE
    v_oral EXAMEN_ORAL := EXAMEN_ORAL(1, 'http://ejemplo.com/examen_oral_1.mp3');
    v_escrito EXAMEN_ESCRITO := EXAMEN_ESCRITO(1, PREGUNTAS_TBL(
        PREGUNTA(1, '¿Cuál es la respuesta correcta?', RESPUESTAS_TBL(
            RESPUESTA(1, 'Respuesta correcta', 'Sí'),
            RESPUESTA(2, 'Respuesta incorrecta', 'No')
        ))
    ));
BEGIN
    INSERT INTO EXAMENES VALUES (1, 'Examen Nivel Básico', v_oral, v_escrito);
END;
/

-- Inserts para la tabla CLASES
INSERT INTO CLASES VALUES ('CL001', 1, 'Clase introductoria');
INSERT INTO CLASES VALUES ('CL002', 2, 'Clase intermedia');

-- Inserts para la tabla NIVELES_OBJ (usando CLASES y EXAMENES como tablas anidadas)
DECLARE
    v_clases CLASES_TBL := CLASES_TBL(
        CLASE('CL001', 1, 'Clase introductoria'),
        CLASE('CL002', 2, 'Clase intermedia')
    );
    v_examenes EXAMENES_TBL := EXAMENES_TBL(
        EXAMEN(1, 'Examen Nivel Básico', EXAMEN_ORAL(1, 'http://ejemplo.com/examen_oral_1.mp3'), 
            EXAMEN_ESCRITO(1, PREGUNTAS_TBL(
                PREGUNTA(1, '¿Cuál es la respuesta correcta?', RESPUESTAS_TBL(
                    RESPUESTA(1, 'Respuesta correcta', 'Sí'),
                    RESPUESTA(2, 'Respuesta incorrecta', 'No')
                ))
            ))
        )
    );
BEGIN
    INSERT INTO NIVELES_OBJ VALUES (1, 'A1', v_clases, v_examenes);
END;
/

/* Este se debe hacer para probar que funcionen los trigger del promedio
-- Insert para la tabla EXAMENES_ORALES_PRESENTADOS
INSERT INTO EXAMENES_ORALES_PRESENTADOS (
    ID_EXAMEN, 
    DNI_ESTUDIANTE, 
    NOTA, 
    FECHA, 
    NIVEL
) VALUES (
    1,                      -- ID_EXAMEN (debe existir en EXAMENES_ORALES)
    '1000412597',           -- DNI_ESTUDIANTE (debe existir en USUARIOS)
    4.5,                    -- NOTA
    TO_DATE('2024-11-01', 'YYYY-MM-DD'), -- FECHA
    1                       -- NIVEL (debe existir en NIVELES_OBJ)
);

-- Insert para la tabla EXAMENES_ESCRITOS_PRESENTADOS
INSERT INTO EXAMENES_ESCRITOS_PRESENTADOS (
    ID_EXAMEN, 
    DNI_ESTUDIANTE, 
    NOTA, 
    FECHA, 
    NIVEL
) VALUES (
    1,                      -- ID_EXAMEN (debe existir en EXAMENES_ESCRITOS)
    '1000412597',               -- DNI_ESTUDIANTE (debe existir en USUARIOS)
    3.8,                    -- NOTA
    TO_DATE('2024-11-02', 'YYYY-MM-DD'), -- FECHA
    1                       -- NIVEL (debe existir en NIVELES_OBJ)
);

-- Insert para la tabla NOTAS
INSERT INTO NOTAS (
    ID_EXAMEN, 
    PROMEDIO, 
    ESTADO
) VALUES (
    1,                      -- ID_EXAMEN (debe existir en EXAMENES)
    4.15,                   -- PROMEDIO
    1                       -- ESTADO (debe existir en ESTADOS_EXAMENES)
);
*/
