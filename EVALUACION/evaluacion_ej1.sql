CREATE TABLE USUARIOS(ID_USUARIO NUMBER PRIMARY KEY, NOMBRE_USUARIO VARCHAR2(45) NOT NULL, CONTRASEŅA VARCHAR2(45) NOT NULL);
ALTER TABLE CLIENTES ADD (ID_USUARIO NUMBER);
ALTER TABLE CLIENTES ADD CONSTRAINT FK_CLIENTES_USUARIOS FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS(ID_USUARIO);