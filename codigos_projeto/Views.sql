CREATE VIEW View_Checkin_Pendente AS
SELECT 
    I.idInscricao,
    A.Nome AS Nome_Atleta,
    I.Nome_Categoria,
    I.Nome_Edicao
FROM Inscricao I
JOIN Atleta A ON I.idAtleta = A.idAtleta
LEFT JOIN Pesagem P ON I.idInscricao = P.idInscricao
WHERE I.Estado = 'Validada' 
  AND P.NumFrontal IS NULL;
  
CREATE VIEW View_Pauta_Classificativa AS
SELECT 
    I.Nome_Edicao,
    I.Nome_Categoria,
    Av.Fase,
    P.NumFrontal,
    -- Omitimos o Nome do Atleta para manter a imparcialidade até ao fim
    ROUND(AVG(Av.Nota), 2) AS Media_Final
FROM Avaliacao Av
JOIN Inscricao I ON Av.idInscricao = I.idInscricao
JOIN Pesagem P ON I.idInscricao = P.idInscricao
GROUP BY I.Nome_Edicao, I.Nome_Categoria, Av.Fase, P.NumFrontal
ORDER BY I.Nome_Edicao, I.Nome_Categoria, Media_Final DESC;

CREATE VIEW View_Avaliacoes_Juri AS
SELECT 
    Av.idAvaliacao,
    Av.idJuri,
    I.Nome_Edicao,
    I.Nome_Categoria,
    Av.Fase,
    P.NumFrontal,
    Av.Nome_Criterio,
    Av.Nota
FROM Avaliacao Av
JOIN Inscricao I ON Av.idInscricao = I.idInscricao
JOIN Pesagem P ON I.idInscricao = P.idInscricao;