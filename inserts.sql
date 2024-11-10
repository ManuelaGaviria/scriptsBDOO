INSERT INTO ESTADOS (CODIGO_ESTADO, NOMBRE_ESTADO) VALUES (1, 'Activo');
INSERT INTO ESTADOS (CODIGO_ESTADO, NOMBRE_ESTADO) VALUES (2, 'Inactivo');

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