USE ApolloMuscleEvents;

-- 1. TABELAS INDEPENDENTES

INSERT INTO Edicao (Nome, Data_Inicio, Data_Fim, Local, Estado) VALUES
('Apollo Summer 2026', '2026-07-15', '2026-07-16', 'Altice Forum Braga', 'Planeada'),
('Apollo Winter Classic 2026', '2026-12-05', '2026-12-06', 'Pavilhão Rosa Mota', 'Planeada'),
('Apollo Spring Cup 2026', '2026-04-10', '2026-04-11', 'Exponor', 'Concluída'),
('Apollo Autumn Fest 2026', '2026-10-20', '2026-10-21', 'MEO Arena', 'Planeada'),
('Apollo Regional North 2026', '2026-02-15', '2026-02-15', 'Multiusos de Guimarães', 'Concluída');

INSERT INTO Categoria (Nome, Altura_Max, Altura_Min, Peso_Max, Peso_Min, GeneroAlvo) VALUES
('Men''s Physique', 1.85, 1.70, 85.00, 70.00, 'M'),
('Bikini Fitness', 1.75, 1.55, 65.00, 50.00, 'F'),
('Classic Physique', 1.90, 1.75, 100.00, 80.00, 'M'),
('Wellness', 1.75, 1.50, 75.00, 55.00, 'F'),
('Bodybuilding Open', 2.20, 1.60, 140.00, 80.00, 'M');

INSERT INTO Atleta (NIF, Nome, Genero, Nacionalidade, Data_Nascimento, Email, Telefone, Tipo_Sanguineo, Alergias, Nome_emergencia, Telefone_Emergencia) VALUES
('123456789', 'João Silva', 'M', 'Portuguesa', '1995-04-12', 'joao.silva@email.com', '912345678', 'O+', 'Nenhuma', 'Maria Silva', '912345679'),
('987654321', 'Ana Costa', 'F', 'Brasileira', '1998-08-22', 'ana.costa@email.com', '961234567', 'A+', 'Amendoim', 'Pedro Costa', '961234568'),
('456123789', 'Carlos Rocha', 'M', 'Espanhola', '1990-11-05', 'carlos.rocha@email.com', '931234567', 'B-', NULL, 'Sofia Rocha', '931234568'),
('789123456', 'Mariana Lopes', 'F', 'Portuguesa', '2000-01-30', 'mariana.lopes@email.com', '921234567', 'AB+', 'Lactose', 'Luís Lopes', '921234568'),
('321654987', 'Rui Santos', 'M', 'Portuguesa', '1988-07-14', 'rui.santos@email.com', '919876543', 'O-', 'Nenhuma', 'Carla Santos', '919876544');

INSERT INTO Staff (NIF, Nome, Email, Telefone, Cargo) VALUES
('234567891', 'Marta Gomes', 'marta@apollo.pt', '923456781', 'Rececionista'),
('345678912', 'Tiago Mendes', 'tiago@apollo.pt', '934567812', 'Diretor de Prova'),
('456789123', 'Hugo Silva', 'hugo@apollo.pt', '944567812', 'Técnico de Pesagem'),
('567891234', 'Sara Pinto', 'sara@apollo.pt', '954567812', 'Coordenadora de Palco'),
('678912345', 'Bruno Alves', 'bruno@apollo.pt', '964567812', 'Segurança');

INSERT INTO Juri (NIF, Nome, Telefone, Credenciais) VALUES
('111222333', 'Arnold Carvalho', '911111111', 'Juiz Principal IFBB'),
('222333444', 'Dorian Santos', '922222222', 'Juiz Nacional'),
('333444555', 'Ronnie Pereira', '933333333', 'Juiz Regional'),
('444555666', 'Lee Tavares', '944444444', 'Juiz IFBB Pro'),
('555666777', 'Jay Martins', '955555555', 'Juiz Estagiário');

INSERT INTO Patrocinador (NIF, NomeEmpresa, TipoPatrocinio) VALUES
('500111222', 'Prozis', 'Ouro - Suplementação'),
('500333444', 'Panatta', 'Prata - Equipamento'),
('500555666', 'Zumub', 'Bronze - Nutrição'),
('500777888', 'Gymshark', 'Ouro - Vestuário'),
('500999000', 'Gold''s Gym', 'Premium - Ginásio Oficial');

INSERT INTO Criterio (Nome_Criterio, PesoPercentual) VALUES
('Simetria', 30.00),
('Muscularidade', 30.00),
('Posing', 20.00),
('Condicionamento', 10.00),
('Apresentacao Geral', 10.00);


-- 2. TABELAS INTERMÉDIAS (Com 1 ou 2 Chaves Estrangeiras)

INSERT INTO Edicao_Staff (Nome_Edicao, idStaff) VALUES
('Apollo Summer 2026', 1),
('Apollo Summer 2026', 2),
('Apollo Summer 2026', 3),
('Apollo Winter Classic 2026', 1),
('Apollo Spring Cup 2026', 4);

INSERT INTO Edicao_Patrocinador (Nome_Edicao, idPatrocinador, ValorPatrocinado) VALUES
('Apollo Summer 2026', 1, 5000.00),
('Apollo Summer 2026', 2, 2500.00),
('Apollo Winter Classic 2026', 1, 4000.00),
('Apollo Spring Cup 2026', 3, 1500.00),
('Apollo Autumn Fest 2026', 4, 3500.00);

-- Inscrições
-- idAtleta 1 a 5, idStaff 1 (Rececionista)
INSERT INTO Inscricao (Data_Inscricao, Estado, idAtleta, Nome_Edicao, Nome_Categoria, idStaff) VALUES
('2026-05-01', 'Validada', 1, 'Apollo Summer 2026', 'Men''s Physique', 1),
('2026-05-02', 'Validada', 2, 'Apollo Summer 2026', 'Bikini Fitness', 1),
('2026-05-03', 'Pendente', 3, 'Apollo Summer 2026', 'Classic Physique', 1),
('2026-10-01', 'Validada', 4, 'Apollo Winter Classic 2026', 'Wellness', 1),
('2026-03-01', 'Cancelada', 5, 'Apollo Spring Cup 2026', 'Bodybuilding Open', 1);


-- 3. TABELAS DEPENDENTES DA INSCRIÇÃO E AVALIAÇÃO

-- Pagamentos
-- 3. TABELAS DEPENDENTES DA INSCRIÇÃO E AVALIAÇÃO

-- Pagamentos (Apenas para as inscrições previamente validadas: 1, 2 e 4)
INSERT INTO Pagamento (MetodoPagamento, Data_Transacao, Montante, idInscricao) VALUES
('MBWay', '2026-05-01 14:30:00', 75.00, 1),
('Transferencia', '2026-05-02 10:15:00', 75.00, 2),
('MBWay', '2026-10-02 18:20:00', 80.00, 4);

-- Pesagens (Apenas os atletas validados chegaram ao check-in)
INSERT INTO Pesagem (NumFrontal, idInscricao, PesoReal, AlturaReal, DataHora) VALUES
(101, 1, 78.50, 1.78, '2026-07-14 09:00:00'),
(102, 2, 58.00, 1.65, '2026-07-14 09:15:00'),
(201, 4, 65.00, 1.68, '2026-12-04 14:00:00');

-- Avaliações do Júri (Apenas os atletas pesados subiram a palco)
INSERT INTO Avaliacao (Nota, Fase, Observacoes, idJuri, idInscricao, Nome_Criterio) VALUES
(8.5, 'Prejudging', 'Boa definição.', 1, 1, 'Muscularidade'),
(9.0, 'Prejudging', 'Excelente proporção.', 1, 1, 'Simetria'),
(7.5, 'Prejudging', 'Melhorar transição.', 2, 1, 'Posing'),
-- Adicionámos esta linha abaixo para o Atleta 2 cumprir a regra do Prejudging!
(8.0, 'Prejudging', 'Boa base para a final.', 3, 2, 'Apresentacao Geral'),
(9.5, 'Finals', 'Apresentação perfeita.', 3, 2, 'Apresentacao Geral'),
(8.5, 'Prejudging', 'Bom tónus muscular.', 4, 4, 'Condicionamento');