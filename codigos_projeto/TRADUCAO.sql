-- RM1
INSERT INTO Inscricao (Data_Inscricao, Estado, idAtleta, Nome_Edicao, Nome_Categoria, idStaff) 
VALUES ('2026-06-01', 'Pendente', 1, 'Apollo Summer 2026', 'Men''s Physique', 1);

-- RM2
UPDATE Inscricao 
SET Estado = 'Validada' 
WHERE idInscricao = 1;

-- RM3
INSERT INTO Pesagem (NumFrontal, idInscricao, PesoReal, AlturaReal, DataHora) 
VALUES (104, 1, 79.00, 1.79, '2026-07-14 10:00:00');

-- RM4
SELECT 
    P.NumFrontal, 
    A.Nome AS Nome_Atleta
FROM Pesagem P
JOIN Inscricao I ON P.idInscricao = I.idInscricao
JOIN Atleta A ON I.idAtleta = A.idAtleta
WHERE I.Estado = 'Validada' 
  AND I.Nome_Edicao = 'Apollo Summer 2026'
  AND I.Nome_Categoria = 'Men''s Physique'
ORDER BY P.NumFrontal ASC;

-- RM5
-- Inserir nova nota
INSERT INTO Avaliacao (Nota, Fase, Observacoes, idJuri, idInscricao, Nome_Criterio) 
VALUES (8.5, 'Prejudging', 'Boa simetria', 1, 1, 'Simetria');

-- Editar a nota (caso haja engano)
UPDATE Avaliacao 
SET Nota = 9.0 
WHERE idAvaliacao = 1 AND idJuri = 1;

-- RM6
SELECT 
    P.NumFrontal,
    (SUM(Av.Nota) - MAX(Av.Nota) - MIN(Av.Nota)) AS Pontuacao_Base_IFBB
FROM Avaliacao Av
JOIN Pesagem P ON Av.idInscricao = P.idInscricao
JOIN Inscricao I ON P.idInscricao = I.idInscricao
WHERE I.Nome_Categoria = 'Men''s Physique' AND Av.Fase = 'Prejudging'
GROUP BY P.NumFrontal
ORDER BY Pontuacao_Base_IFBB DESC;

-- RM7
SELECT 
    P.NumFrontal,
    SUM(Av.Nota * (C.PesoPercentual / 100)) AS Pontuacao_Ponderada
FROM Avaliacao Av
JOIN Criterio C ON Av.Nome_Criterio = C.Nome_Criterio
JOIN Pesagem P ON Av.idInscricao = P.idInscricao
JOIN Inscricao I ON P.idInscricao = I.idInscricao
WHERE I.Nome_Categoria = 'Men''s Physique' AND Av.Fase = 'Finals'
GROUP BY P.NumFrontal
ORDER BY Pontuacao_Ponderada DESC;

-- RM8
SELECT 
    I.Nome_Edicao, 
    I.Nome_Categoria, 
    Av.Fase,
    ROUND(AVG(Av.Nota), 2) AS Media_Final
FROM Inscricao I
LEFT JOIN Avaliacao Av ON I.idInscricao = Av.idInscricao
WHERE I.idAtleta = 1
GROUP BY I.Nome_Edicao, I.Nome_Categoria, Av.Fase
ORDER BY I.Nome_Edicao DESC;

-- RM9
SELECT DISTINCT J.Nome, J.Credenciais
FROM Juri J
JOIN Avaliacao Av ON J.idJuri = Av.idJuri
JOIN Inscricao I ON Av.idInscricao = I.idInscricao
WHERE I.Nome_Categoria = 'Men''s Physique' 
  AND I.Nome_Edicao = 'Apollo Summer 2026';
  
-- RM10
SELECT 
    (SELECT COALESCE(SUM(Montante), 0) FROM Pagamento) + 
    (SELECT COALESCE(SUM(ValorPatrocinado), 0) FROM Edicao_Patrocinador) 
AS Receita_Total_Global;

-- RM11
SELECT 
    P.NumFrontal, 
    ROUND(AVG(Av.Nota), 2) AS Media_Prejudging
FROM Avaliacao Av
JOIN Pesagem P ON Av.idInscricao = P.idInscricao
JOIN Inscricao I ON P.idInscricao = I.idInscricao
WHERE I.Nome_Categoria = 'Men''s Physique' 
  AND Av.Fase = 'Prejudging'
GROUP BY P.NumFrontal
ORDER BY Media_Prejudging DESC
LIMIT 5;