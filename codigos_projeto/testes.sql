-- Testar a Funcao
SELECT Nome, Data_Nascimento, fn_CalcularIdade(Data_Nascimento) AS Idade_Atual 
FROM Atleta;

-- Testar o Trigger 1 (A inscricao 5 foi cancelada, vamos testar se da para meter um pagamento)
-- Deu erro, ta certo!
INSERT INTO Pagamento (MetodoPagamento, Data_Transacao, Montante, idInscricao) 
VALUES ('MBWay', NOW(), 50.00, 5);

-- Testar o Trigger 2 (A inscricao 3 esta pendente, vamos meter um pagamento e ver se muda)
-- 1. Vemos o estado atual (Vai dizer 'Pendente')
SELECT idInscricao, Estado FROM Inscricao WHERE idInscricao = 3;

-- 2. Fazemos o pagamento
INSERT INTO Pagamento (MetodoPagamento, Data_Transacao, Montante, idInscricao) 
VALUES ('Dinheiro', NOW(), 75.00, 3);

-- 3. Vemos o estado novamente (Vai dizer 'Validada'!)
SELECT idInscricao, Estado FROM Inscricao WHERE idInscricao = 3;


-- Testar o Trigger 3. A nossa inscricao 3 agora ja esta validada, mas nao tem nenhuma nota do Prejudging.
-- Vamos ver se um Juri lhe consegue dar ja uma nota no Finals (nao deve)
-- Deu, ta bom!
INSERT INTO Avaliacao (Nota, Fase, Observacoes, idJuri, idInscricao, Nome_Criterio) 
VALUES (9.5, 'Finals', 'Incrível', 1, 3, 'Simetria');


-- Testar o procedure (A inscricao 5 esta cancelada, nao pode)
CALL sp_RegistarCheckIn(999, 5, 110.00, 1.80);