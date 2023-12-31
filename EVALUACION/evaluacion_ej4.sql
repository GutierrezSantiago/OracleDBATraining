CREATE SEQUENCE SEQ_FACTURAS MAXVALUE 99999999;
/
CREATE OR REPLACE FUNCTION FC_OBTENER_PROXIMO_NRO_FACTURA RETURN VARCHAR2
AS
V_NRO_FACTURA_SIN_CEROS NUMBER;
V_NRO_FACTURA VARCHAR2(8);
BEGIN
    V_NRO_FACTURA_SIN_CEROS := SEQ_FACTURAS.NEXTVAL;
    V_NRO_FACTURA := LPAD(V_NRO_FACTURA_SIN_CEROS, 8, '0');
    RETURN V_NRO_FACTURA;
END FC_OBTENER_PROXIMO_NRO_FACTURA;
/
CREATE SEQUENCE SEQ_ID_COMPRA;
/
CREATE OR REPLACE PROCEDURE PR_INSERTAR_COMPRA (P_FECHA VARCHAR2, P_ID_CLIENTE NUMBER, P_ID_FORMA_DE_PAGO NUMBER, P_ID_COMPRA OUT NUMBER, P_ID OUT NUMBER, P_ERROR OUT VARCHAR2)
AS
BEGIN
    P_ID_COMPRA := SEQ_ID_COMPRA.NEXTVAL;
    INSERT INTO COMPRAS(ID_COMPRA, FECHA_COMPRA, ID_CLIENTE, ID_FORMA_DE_PAGO, NUMERO_DE_FACTURA) VALUES (P_ID_COMPRA, P_FECHA, P_ID_CLIENTE, P_ID_FORMA_DE_PAGO, FC_OBTENER_PROXIMO_NRO_FACTURA());
    COMMIT;
    P_ID := 1;
EXCEPTION
    WHEN OTHERS THEN
        P_ID := SQLCODE;
        P_ERROR := SQLERRM;
END PR_INSERTAR_COMPRA;
/
CREATE SEQUENCE SEQ_ID_DETALLE_COMPRA;
/
CREATE OR REPLACE PROCEDURE PR_INSERTAR_DETALLE_COMPRA (P_ID_COMPRA NUMBER, P_CANTIDAD NUMBER, P_ID_MEDICAMENTO NUMBER, P_ID  OUT NUMBER, P_ERROR OUT VARCHAR2)
AS
    E_STOCK_NEGATIVO EXCEPTION;
    V_STOCK NUMBER;
BEGIN
    SELECT CANTIDAD_STOCK INTO V_STOCK FROM MEDICAMENTOS WHERE ID_MEDICAMENTO=P_ID_MEDICAMENTO;
    
    IF (V_STOCK-P_CANTIDAD)<0 THEN
        RAISE E_STOCK_NEGATIVO;
    END IF;
    
    INSERT INTO DETALLES_COMPRA(ID_DETALLE_COMPRA, CANTIDAD, ID_COMPRA, ID_MEDICAMENTO)VALUES(SEQ_ID_DETALLE_COMPRA.NEXTVAL, P_CANTIDAD, P_ID_COMPRA, P_ID_MEDICAMENTO);
    
    UPDATE MEDICAMENTOS SET CANTIDAD_STOCK = (CANTIDAD_STOCK - P_CANTIDAD) WHERE ID_MEDICAMENTO=P_ID_MEDICAMENTO;
    
    COMMIT;
    P_ID := 1;
EXCEPTION
    WHEN E_STOCK_NEGATIVO THEN
        P_ID := -1;
        P_ERROR := 'No se puede agregar una cantidad superior al stock al detalle factura';
    WHEN OTHERS THEN
        ROLLBACK;
        P_ID := SQLCODE;
        P_ERROR := SQLERRM;
END PR_INSERTAR_DETALLE_COMPRA;