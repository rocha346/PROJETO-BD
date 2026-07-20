DELIMITER //
CREATE TRIGGER trg_before_pagamento
BEFORE INSERT ON Pagamento
FOR EACH ROW
BEGIN
    DECLARE v_estado_atual VARCHAR(20);
    SELECT Estado INTO v_estado_atual FROM Inscricao WHERE idInscricao = NEW.idInscricao;
    
    IF v_estado_atual = 'Cancelada' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Não é possível registar um pagamento para uma inscrição cancelada.';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_after_pagamento
AFTER INSERT ON Pagamento
FOR EACH ROW
BEGIN
    UPDATE Inscricao 
    SET Estado = 'Validada' 
    WHERE idInscricao = NEW.idInscricao AND Estado = 'Pendente';
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_valida_fase_final
BEFORE INSERT ON Avaliacao
FOR EACH ROW
BEGIN
    DECLARE v_tem_prejudging INT;
    
    -- Se a nota a inserir for para a Final, verifica se o atleta participou no Prejudging
    IF NEW.Fase = 'Finals' THEN
        SELECT COUNT(*) INTO v_tem_prejudging 
        FROM Avaliacao 
        WHERE idInscricao = NEW.idInscricao AND Fase = 'Prejudging';
        
        IF v_tem_prejudging = 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'O atleta não pode ser avaliado nas Finais sem ter participado no Prejudging.';
        END IF;
    END IF;
END //
DELIMITER ;