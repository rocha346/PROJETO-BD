DELIMITER //
CREATE PROCEDURE sp_RegistarCheckIn (
    IN p_NumFrontal INT, 
    IN p_idInscricao INT, 
    IN p_Peso DECIMAL(5,2), 
    IN p_Altura DECIMAL(3,2)
)
BEGIN
    DECLARE v_estado VARCHAR(20);
    
    -- Verifica o estado da inscrição
    SELECT Estado INTO v_estado FROM Inscricao WHERE idInscricao = p_idInscricao;
    
    IF v_estado != 'Validada' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: Apenas atletas com inscrição Validada podem efetuar pesagem.';
    ELSE
        INSERT INTO Pesagem (NumFrontal, idInscricao, PesoReal, AlturaReal, DataHora) 
        VALUES (p_NumFrontal, p_idInscricao, p_Peso, p_Altura, NOW());
    END IF;
END //
DELIMITER ;