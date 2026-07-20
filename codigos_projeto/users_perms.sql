-- Administrador (Direção) com acesso total
CREATE USER 'admin_apollo'@'localhost' IDENTIFIED BY 'ApolloAdmin2026!';
GRANT ALL PRIVILEGES ON ApolloMuscleEvents.* TO 'admin_apollo'@'localhost';

-- Staff
CREATE USER 'staff_rececao'@'localhost' IDENTIFIED BY 'StaffSeguro#123';
GRANT SELECT, INSERT, UPDATE ON ApolloMuscleEvents.Atleta TO 'staff_rececao'@'localhost';
GRANT SELECT, INSERT, UPDATE ON ApolloMuscleEvents.Inscricao TO 'staff_rececao'@'localhost';
GRANT SELECT, INSERT, UPDATE ON ApolloMuscleEvents.Pesagem TO 'staff_rececao'@'localhost';
GRANT SELECT, INSERT, UPDATE ON ApolloMuscleEvents.Pagamento TO 'staff_rececao'@'localhost';
GRANT SELECT ON ApolloMuscleEvents.Edicao TO 'staff_rececao'@'localhost';
GRANT SELECT ON ApolloMuscleEvents.Categoria TO 'staff_rececao'@'localhost';

-- Juri
CREATE USER 'juri_avaliador'@'localhost' IDENTIFIED BY 'JuriIFBB!2026';
GRANT SELECT, INSERT, UPDATE ON ApolloMuscleEvents.Avaliacao TO 'juri_avaliador'@'localhost';
GRANT SELECT ON ApolloMuscleEvents.Inscricao TO 'juri_avaliador'@'localhost';
GRANT SELECT ON ApolloMuscleEvents.Pesagem TO 'juri_avaliador'@'localhost';

-- Atualizar privilegios
FLUSH PRIVILEGES;