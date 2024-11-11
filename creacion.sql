
-- DROP MAIN TABLES (ordenados según dependencias)
DROP TABLE RESPUESTAS;
DROP TABLE PREGUNTAS;
DROP TABLE CLASES;
DROP TABLE EXAMENES_ESCRITOS;
DROP TABLE EXAMENES_ORALES;
DROP TABLE EXAMENES;
DROP TABLE EXAMENES_ORALES_PRESENTADOS;
DROP TABLE EXAMENES_ESCRITOS_PRESENTADOS;
DROP TABLE AUDITORIAS_CLASES_PROG;
DROP TABLE CLASES_PROGRAMADAS;
DROP TABLE USUARIOS;
DROP TABLE ROLES;
DROP TABLE ESTADOS;
DROP TABLE SEXOS;
DROP TABLE TIPODOCUMENTOS;
DROP TABLE NIVELES;
DROP TABLE NIVELES_OBJ;
DROP TABLE HORAS;
DROP TABLE SALONES;

-- DROP TYPES EN EL ORDEN CORRECTO
DROP TYPE NIVEL;
DROP TYPE EXAMENES_TBL;
DROP TYPE EXAMEN;
DROP TYPE EXAMEN_ESCRITO;
DROP TYPE EXAMEN_ORAL;
DROP TYPE PREGUNTAS_TBL;
DROP TYPE PREGUNTA;
DROP TYPE RESPUESTAS_TBL;
DROP TYPE RESPUESTA;
DROP TYPE EXAMEN_ORAL_PRESENTADO;
DROP TYPE EXAMEN_ESCRITO_PRESENTADO;
DROP TYPE CLASE_PROGRAMADA;
DROP TYPE CLASES_TBL;
DROP TYPE CLASE;
DROP TYPE USUARIOS_TBL;
DROP TYPE USUARIO;

----------------------------------------------------------------------------
--SECUENCIAS
DROP SEQUENCE SEQ_AUD_CLAS_PROG ;
CREATE SEQUENCE SEQ_AUD_CLAS_PROG 
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

DROP SEQUENCE CLASES_PROGRAMADAS_SEQ;
CREATE SEQUENCE CLASES_PROGRAMADAS_SEQ 
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

----------------------------------------------------------------------------
-- CREAR TABLAS NECESARIAS
--TABLA AUDITORIAS
CREATE TABLE AUDITORIAS_CLASES_PROG (
  CODIGO_AUD INTEGER,
  NOMBRE_TABLA VARCHAR2(50),
  OPERACION VARCHAR2(20),
  ID_REGISTRO INTEGER,
  DESCRIPCION VARCHAR2(250),
  FECHA TIMESTAMP,
  CONSTRAINT PK_AUD_CLAS_PROG PRIMARY KEY (CODIGO_AUD)
);

--TABLA ESTADOS DE LOS USUARIOS
CREATE TABLE ESTADOS(
	CODIGO_ESTADO NUMBER(1),
	NOMBRE_ESTADO VARCHAR2(50),
	CONSTRAINT PK_CODIGO_ESTADO PRIMARY KEY (CODIGO_ESTADO),
	CONSTRAINT NN_NOMBRE_ESTADO CHECK (NOMBRE_ESTADO IS NOT NULL)
) TABLESPACE ts_bdobjectual;

--TABLA ESTADOS DE LOS EXAMENES
CREATE TABLE ESTADOS_EXAMENES (
	CODIGO_ESTADO NUMBER(1),
	ESTADO_EXAMEN VARCHAR2(15),
	CONSTRAINT PK_ESTADO_EXAMEN PRIMARY KEY (CODIGO_ESTADO),
CONSTRAINT NN_ESTADO_EXAMEN CHECK (ESTADO_EXAMEN IS NOT NULL)
)TABLESPACE ts_bdobjectual;

--TABLA ROLES DE LOS USUARIOS
CREATE TABLE ROLES(
	CODIGO_ROL NUMBER(1),
	NOMBRE_ROL VARCHAR2(50),
	CONSTRAINT PK_COD_ROL PRIMARY KEY (CODIGO_ROL),
	CONSTRAINT NN_NOMBRE_ROL CHECK (NOMBRE_ROL IS NOT NULL)
) TABLESPACE ts_bdobjectual;

--TABLA SEXOS DE LOS USUARIOS
CREATE TABLE SEXOS (
	CODIGO_SEX NUMBER(1),
	NOMBRE_SEX VARCHAR2(20),
	CONSTRAINT PK_CODIGO_SEX PRIMARY KEY (CODIGO_SEX),
	CONSTRAINT NN_NOMBRE_SEX CHECK (NOMBRE_SEX IS NOT NULL)
) TABLESPACE ts_bdobjectual;

--TABLA TIPO DOCUMENTO DE LOS USUARIOS
CREATE TABLE TIPODOCUMENTOS (
	CODIGO_TIPODOC NUMBER(2),
	NOMBRE_DOC VARCHAR2(50),
	CONSTRAINT PK_COD_TIPODOC PRIMARY KEY (CODIGO_TIPODOC),
	CONSTRAINT NN_NOM_TIPODOC CHECK (NOMBRE_DOC IS NOT NULL)
) TABLESPACE ts_bdobjectual;

--TABLA SALONES
CREATE TABLE SALONES (
	CODIGO_SALON NUMBER(2),
	NUMERO_SALON NUMBER(3),
	CAPACIDAD_SALON NUMBER(1),
	CONSTRAINT PK_COD_SAL PRIMARY KEY (CODIGO_SALON),
	CONSTRAINT NN_NUM_SAL CHECK (NUMERO_SALON IS NOT NULL)
) TABLESPACE ts_bdobjectual;

--TABLA HORAS
CREATE TABLE HORAS(
	CODIGO_HORA NUMBER(2),
	HORA_INICIAL VARCHAR2(10),
	HORA_FINAL VARCHAR2(10),
	CONSTRAINT PK_COD_HORA PRIMARY KEY (CODIGO_HORA),
	CONSTRAINT NN_HO_INICIAL CHECK (HORA_INICIAL IS NOT NULL),
CONSTRAINT NN_HO_FINAL CHECK (HORA_FINAL IS NOT NULL)
) TABLESPACE ts_bdobjectual;

--TABLA NIVELES
CREATE TABLE NIVELES (
	CODIGO_NIVEL NUMBER(1),
	NIVEL VARCHAR2(5),
	CONSTRAINT PK_CODIGO_NIVEL PRIMARY KEY (CODIGO_NIVEL),
	CONSTRAINT NN_NIVEL CHECK (NIVEL IS NOT NULL)
) TABLESPACE ts_bdobjectual;


------------------------------------------------------------------------
-- CREAR OBJECTOS Y SUS TABLAS
--OBJETO USUARIO
CREATE OR REPLACE TYPE USUARIO AS OBJECT (
    DNI_USU VARCHAR2(50),
    NOMBRE_USU VARCHAR2(50),
    APELLIDO1_USU VARCHAR2(50),
    APELLIDO2_USU VARCHAR2(50),
    TIPODOC_USU NUMBER(2),
    CORREO_USU VARCHAR(100),
    SEXO_USU NUMBER(1),
    CONTRASENNA_USU VARCHAR(25),
    NACIMIENTO_USU DATE,
    ESTADO_USU NUMBER(1),
    ROL_USU NUMBER(1)
);
/

--TABLA DEL OBJETO USUARIO
CREATE TABLE USUARIOS OF USUARIO(
    CONSTRAINT PK_DNI_USU PRIMARY KEY (DNI_USU),
    CONSTRAINT NN_NOMBRE_USU CHECK (NOMBRE_USU IS NOT NULL),
    CONSTRAINT NN_APE1_USU CHECK (APELLIDO1_USU IS NOT NULL),
    CONSTRAINT NN_TIPODOC_USU CHECK (TIPODOC_USU IS NOT NULL),
    CONSTRAINT NN_CORREO_USU CHECK (CORREO_USU IS NOT NULL),
    CONSTRAINT NN_SEXO_USU CHECK (SEXO_USU IS NOT NULL),
    CONSTRAINT NN_CONTRA_USU CHECK (CONTRASENNA_USU IS NOT NULL),
    CONSTRAINT NN_NAC_USU CHECK (NACIMIENTO_USU IS NOT NULL),
    CONSTRAINT NN_ESTADO_USU CHECK (ESTADO_USU IS NOT NULL),
    CONSTRAINT NN_ROL_USU CHECK (ROL_USU IS NOT NULL),
    CONSTRAINT UK_CORREO_USU UNIQUE (CORREO_USU),
    CONSTRAINT FK_TIPODOC_USU FOREIGN KEY (TIPODOC_USU) REFERENCES TIPODOCUMENTOS(CODIGO_TIPODOC),
    CONSTRAINT FK_SEXO_USU FOREIGN KEY (SEXO_USU) REFERENCES SEXOS(CODIGO_SEX),
    CONSTRAINT FK_ESTADO_USU FOREIGN KEY (ESTADO_USU) REFERENCES ESTADOS(CODIGO_ESTADO),
    CONSTRAINT FK_ROL_USU FOREIGN KEY (ROL_USU) REFERENCES ROLES(CODIGO_ROL)
) TABLESPACE ts_bdobjectual;

--INSTANCIA PARA USUARIO
CREATE TYPE USUARIOS_TBL AS TABLE OF USUARIO;
/

--OBJETO CLASE_PROGRAMADA
CREATE OR REPLACE TYPE CLASE_PROGRAMADA AS OBJECT (
    COD_CLASE_PROG NUMBER(3),
    COD_NIVEL NUMBER(1),
    FECHA DATE,
    COD_HORA NUMBER(2),
    COD_SALON NUMBER(2),
    CUPOS_REGISTRADOS NUMBER(1),
    PROFESOR USUARIO,
    ESTUDIANTES USUARIOS_TBL
);
/

--TABLA DEL OBJETO CLASE PROGRAMADA
CREATE TABLE CLASES_PROGRAMADAS OF CLASE_PROGRAMADA(
    CONSTRAINT PK_CLA_PROG PRIMARY KEY (COD_CLASE_PROG),
    CONSTRAINT NN_COD_NIVEL CHECK (COD_NIVEL IS NOT NULL),
    CONSTRAINT NN_FECHA CHECK (FECHA IS NOT NULL),
    CONSTRAINT NN_COD_HORA CHECK (COD_HORA IS NOT NULL),
    CONSTRAINT NN_COD_SALON CHECK (COD_SALON IS NOT NULL),
    CONSTRAINT FK_NI_CLA_PROG FOREIGN KEY (COD_NIVEL) REFERENCES NIVELES(CODIGO_NIVEL),
    CONSTRAINT FK_HO_CLA_PROG FOREIGN KEY (COD_HORA) REFERENCES HORAS(CODIGO_HORA),
    CONSTRAINT FK_SAL_CLA_PROG FOREIGN KEY (COD_SALON) REFERENCES SALONES(CODIGO_SALON)
) NESTED TABLE ESTUDIANTES STORE AS ESTUDIANTES_NESTED_TABLE TABLESPACE ts_bdobjectual;

-- Objeto Respuesta
CREATE OR REPLACE TYPE RESPUESTA AS OBJECT (
    CODIGO_RESPUESTA NUMBER(4),
    CONTENIDO VARCHAR2(255),
    ACIERTO VARCHAR2(10)
);
/

CREATE TABLE RESPUESTAS OF RESPUESTA(
	CONSTRAINT PK_RESPUESTA PRIMARY KEY (CODIGO_RESPUESTA),
	CONSTRAINT NN_CONTENIDO_RESPUESTA CHECK (CONTENIDO IS NOT NULL),
	CONSTRAINT NN_ACIERTO_RESPUESTA CHECK (ACIERTO IS NOT NULL)
) TABLESPACE ts_bdobjectual;


-- Tabla para almacenar las respuestas
CREATE TYPE RESPUESTAS_TBL AS TABLE OF RESPUESTA;
/

-- Objeto Pregunta
CREATE OR REPLACE TYPE PREGUNTA AS OBJECT (
    CODIGO_PREGUNTA NUMBER(4),
    TEXTO VARCHAR2(255),
    RESPUESTAS RESPUESTAS_TBL
);
/

--Tabla preguntas
CREATE TABLE PREGUNTAS OF PREGUNTA(
	CONSTRAINT PK_PREGUNTA PRIMARY KEY (CODIGO_PREGUNTA)
) NESTED TABLE RESPUESTAS STORE AS RESPUESTAS_NESTED_TABLE TABLESPACE ts_bdobjectual;

-- Tabla para almacenar preguntas
CREATE TYPE PREGUNTAS_TBL AS TABLE OF PREGUNTA;
/

-- Objeto Examen Escrito
CREATE OR REPLACE TYPE EXAMEN_ESCRITO AS OBJECT (
  CODIGO_EXAMEN_ESCRITO NUMBER(2),
  PREGUNTAS_EXAMEN PREGUNTAS_TBL
);
/

-- Tabla de EXAMENES_ESCRITOS con almacenamiento para la tabla anidada
CREATE TABLE EXAMENES_ESCRITOS OF EXAMEN_ESCRITO (
  CONSTRAINT PK_EXAMEN_ESCRITO PRIMARY KEY (CODIGO_EXAMEN_ESCRITO)
)
NESTED TABLE PREGUNTAS_EXAMEN STORE AS PREGUNTAS_EXAMEN_NESTED_TABLE
(
  NESTED TABLE RESPUESTAS STORE AS RESPUESTAS_EXAMEN_NESTED_TABLE
)
TABLESPACE ts_bdobjectual;

-- Objeto Examen Oral
CREATE OR REPLACE TYPE EXAMEN_ORAL AS OBJECT (
    CODIGO_EXAMEN_ORAL NUMBER(2),
    ARCHIVO_URL VARCHAR2(255)
);
/

--Tabla examenes orales
CREATE TABLE EXAMENES_ORALES OF EXAMEN_ORAL(
	CONSTRAINT PK_EXAMEN_ORAL PRIMARY KEY (CODIGO_EXAMEN_ORAL),
	CONSTRAINT NN_ARCHIVO_URL CHECK (ARCHIVO_URL IS NOT NULL)
) TABLESPACE ts_bdobjectual;

-- Objeto Examen
CREATE OR REPLACE TYPE EXAMEN AS OBJECT (
  NUMERO_EXAMEN NUMBER(2),
  TEMATICA_EXAMEN VARCHAR2(50),
  ORAL EXAMEN_ORAL,
  ESCRITO EXAMEN_ESCRITO
);
/

-- Tabla examenes
CREATE TABLE EXAMENES OF EXAMEN (
  CONSTRAINT PK_NUM_EXAM PRIMARY KEY (NUMERO_EXAMEN),
  CONSTRAINT NN_TEMATICA_EXAM CHECK (TEMATICA_EXAMEN IS NOT NULL)
)
NESTED TABLE ESCRITO.PREGUNTAS_EXAMEN STORE AS PREGUNTAS_NESTED_TABLE_EXAMEN
  (NESTED TABLE RESPUESTAS STORE AS RESPUESTAS_NESTED_TABLE_EXAMEN)
TABLESPACE ts_bdobjectual;

-- Tabla para almacenar exámenes
CREATE TYPE EXAMENES_TBL AS TABLE OF EXAMEN;
/

-- Objeto Clase
CREATE OR REPLACE TYPE CLASE AS OBJECT (
    CODIGO_CLASE VARCHAR2(10),
    NUMERO_CLASE NUMBER(2),
    DESCRIPCION VARCHAR2(100)
);
/

--Tabla clases
CREATE TABLE CLASES OF CLASE(
	CONSTRAINT PK_COD_CLA PRIMARY KEY (CODIGO_CLASE),
	CONSTRAINT NN_NUM_CLA CHECK (NUMERO_CLASE IS NOT NULL),
	CONSTRAINT NN_DES_CLA CHECK (DESCRIPCION IS NOT NULL)
) TABLESPACE ts_bdobjectual;

-- Tabla para almacenar clases
CREATE TYPE CLASES_TBL AS TABLE OF CLASE;
/

-- Objeto Nivel
CREATE OR REPLACE TYPE NIVEL AS OBJECT (
    COD_NIVEL NUMBER(1),
    NIVEL VARCHAR2(5),
    CLASES CLASES_TBL,
    EXAMENES EXAMENES_TBL
);
/

-- Tabla del objeto Nivel
CREATE TABLE NIVELES_OBJ OF NIVEL (
  CONSTRAINT PK_NIVEL_OBJ PRIMARY KEY (COD_NIVEL)
)
NESTED TABLE CLASES STORE AS CLASES_NESTED_TABLE
NESTED TABLE EXAMENES STORE AS EXAMENES_NESTED_TABLE
  (NESTED TABLE ESCRITO.PREGUNTAS_EXAMEN STORE AS PREGUNTAS_NESTED_TABLE_EXAMEN_NIVEL
    (NESTED TABLE RESPUESTAS STORE AS RESPUESTAS_NESTED_TABLE_EXAMEN_NIVEL))
TABLESPACE ts_bdobjectual;



CREATE TABLE EXAMENES_ORALES_PRESENTADOS (
    ID_EXAMEN NUMBER(2), -- PK FK que se refiere a EXAMEN_ORAL
    DNI_ESTUDIANTE VARCHAR2(50), -- PK FK que se refiere a USUARIO (DNI_USU)
    NOTA NUMBER(3,2),
    FECHA DATE,
    NIVEL NUMBER(1), -- FK que se refiere a NIVELES_OBJ
    CONSTRAINT PK_EXAMEN_ORAL_PRESENTADO PRIMARY KEY (ID_EXAMEN, DNI_ESTUDIANTE),
    CONSTRAINT FK_DNI_ESTUDIANTE_ORAL FOREIGN KEY (DNI_ESTUDIANTE) REFERENCES USUARIOS(DNI_USU),
    CONSTRAINT FK_NIVEL_ORAL FOREIGN KEY (NIVEL) REFERENCES NIVELES_OBJ(COD_NIVEL),
    CONSTRAINT FK_ID_EXAMEN_ORAL FOREIGN KEY (ID_EXAMEN) REFERENCES EXAMENES_ORALES(CODIGO_EXAMEN_ORAL)
) TABLESPACE ts_bdobjectual;

CREATE TABLE EXAMENES_ESCRITOS_PRESENTADOS (
    ID_EXAMEN NUMBER(2), -- PK FK que se refiere a EXAMEN_ESCRITO
    DNI_ESTUDIANTE VARCHAR2(50), -- PK FK que se refiere a USUARIO (DNI_USU)
    NOTA NUMBER(3,2),
    FECHA DATE,
    NIVEL NUMBER(1), -- FK que se refiere a NIVELES_OBJ
    CONSTRAINT PK_EXAMEN_ESCRITO_PRESENTADO PRIMARY KEY (ID_EXAMEN, DNI_ESTUDIANTE),
    CONSTRAINT FK_DNI_ESTUDIANTE_ESCRITO FOREIGN KEY (DNI_ESTUDIANTE) REFERENCES USUARIOS(DNI_USU),
    CONSTRAINT FK_NIVEL_ESCRITO FOREIGN KEY (NIVEL) REFERENCES NIVELES_OBJ(COD_NIVEL),
    CONSTRAINT FK_ID_EXAMEN_ESCRITO FOREIGN KEY (ID_EXAMEN) REFERENCES EXAMENES_ESCRITOS(CODIGO_EXAMEN_ESCRITO)
) TABLESPACE ts_bdobjectual;

CREATE TABLE NOTAS (
    ID_EXAMEN NUMBER(2), -- PK FK que se refiere a EXAMEN (NUMERO_EXAMEN)
    PROMEDIO NUMBER(3,2),
    ESTADO NUMBER(1), -- FK que se refiere a ESTADOS_EXAMENES
    CONSTRAINT PK_NOTA PRIMARY KEY (ID_EXAMEN),
    CONSTRAINT FK_ESTADO_NOTA FOREIGN KEY (ESTADO) REFERENCES ESTADOS_EXAMENES(CODIGO_ESTADO),
    CONSTRAINT FK_ID_EXAMEN_NOTA FOREIGN KEY (ID_EXAMEN) REFERENCES EXAMENES(NUMERO_EXAMEN)
) TABLESPACE ts_bdobjectual;





---------------------------------------------------------------
/*
-- Objeto EXAMEN_ORAL_PRESENTADO
CREATE OR REPLACE TYPE EXAMEN_ORAL_PRESENTADO AS OBJECT (
    ID_EXAMEN NUMBER(2),
    DNI_USUARIO VARCHAR2(50),
    NOTA NUMBER(5, 2),
    FECHA DATE,
    NIVEL NUMBER(1),
    EXAMEN_ORIGINAL EXAMEN_ORAL -- Referencia al examen oral original
);

-- Tabla para almacenar instancias de EXAMEN_ORAL_PRESENTADO
CREATE TABLE EXAMENES_ORALES_PRESENTADOS OF EXAMEN_ORAL_PRESENTADO (
    CONSTRAINT PK_EXAMEN_ORAL_PRESENTADO PRIMARY KEY (ID_EXAMEN, DNI_USUARIO),
    CONSTRAINT NN_NOTA CHECK (NOTA IS NOT NULL),
    CONSTRAINT FK_NIVEL_EXAM_ORAL FOREIGN KEY (NIVEL) REFERENCES NIVELES(CODIGO_NIVEL),
    CONSTRAINT FK_EXAMEN_ESCRITO FOREIGN KEY (ID_EXAMEN) REFERENCES EXAMENES_ORALES(CODIGO_EXAMEN_ORAL)
) TABLESPACE ts_bdobjectual;

-- Objeto EXAMEN_ESCRITO_PRESENTADO
CREATE OR REPLACE TYPE EXAMEN_ESCRITO_PRESENTADO AS OBJECT (
    ID_EXAMEN NUMBER(2),
    DNI_USUARIO VARCHAR2(50),
    NOTA NUMBER(5, 2),
    FECHA DATE,
    NIVEL NUMBER(1),
    EXAMEN_ORIGINAL EXAMEN_ESCRITO -- Referencia al examen escrito original
);

-- Tabla para almacenar instancias de EXAMEN_ESCRITO_PRESENTADO
CREATE TABLE EXAMENES_ESCRITOS_PRESENTADOS OF EXAMEN_ESCRITO_PRESENTADO (
    CONSTRAINT PK_EXAMEN_ESCRITO_PRESENTADO PRIMARY KEY (ID_EXAMEN, DNI_USUARIO),
    CONSTRAINT NN_NOTA_EXAM_ESCRITO CHECK (NOTA IS NOT NULL),
    CONSTRAINT FK_NIVEL_EXAM_ESCRITO FOREIGN KEY (NIVEL) REFERENCES NIVELES(CODIGO_NIVEL)
) TABLESPACE ts_bdobjectual;

-- Objeto NOTA
CREATE OR REPLACE TYPE NOTA AS OBJECT (
    CODIGO_NOTA NUMBER(3),
    DNI_ESTUDIANTE VARCHAR2(20),
    EXAMEN_ORAL EXAMEN_ORAL_PRESENTADO,
    EXAMEN_ESCRITO EXAMEN_ESCRITO_PRESENTADO,
    PROMEDIO NUMBER(5, 2),
    ESTADO NUMBER(1)
);
/

-- Tabla para almacenar las instancias del objeto NOTA
CREATE TABLE NOTAS OF NOTA (
    CONSTRAINT PK_NOTA PRIMARY KEY (CODIGO_NOTA),
    CONSTRAINT NN_ESTUDIANTE_NOTA CHECK (DNI_ESTUDIANTE IS NOT NULL),
    CONSTRAINT FK_ESTADO_EXAMEN FOREIGN KEY (ESTADO) REFERENCES ESTADOS_EXAMENES(CODIGO_ESTADO)
) TABLESPACE ts_bdobjectual;
*/