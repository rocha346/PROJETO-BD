CREATE UNIQUE INDEX idx_atleta_nif ON Atleta(NIF);

CREATE INDEX idx_inscricao_operacional ON Inscricao(Estado, Nome_Edicao);

CREATE INDEX idx_avaliacao_fase ON Avaliacao(Fase);

CREATE INDEX idx_pesagem_frontal ON Pesagem(NumFrontal);

