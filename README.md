# Base de Dados para Competições de Musculação

Projeto de **Bases de Dados**, implementado em **MySQL**. Sistema de gestão completo para competições de musculação, cobrindo atletas, inscrições, pesagens, avaliações de júri e patrocinadores.

## Domínio

A base de dados gere o ciclo de vida completo de uma competição:

1. **Planeamento** — criação de edições (competições) com categorias (Men's Physique, Classic Physique, etc.) definidas por limites de peso e altura.
2. **Inscrição** — atletas inscrevem-se numa edição e categoria; a inscrição começa como `Pendente`.
3. **Pagamento** — ao registar o pagamento, um trigger valida automaticamente a inscrição (`Pendente` → `Validada`).
4. **Check-in / Pesagem** — no dia da competição, o staff regista o peso e altura real do atleta e atribui-lhe um número frontal anónimo (para garantir imparcialidade na avaliação).
5. **Avaliação** — o júri avalia cada atleta por critérios (ex: Simetria, Condição, Apresentação) nas fases Prejudging e Finals.
6. **Classificação** — a pauta final é calculada automaticamente, excluindo a nota mais alta e mais baixa de cada atleta (sistema IFBB).

## Estrutura da base de dados

| Tabela | Descrição |
|---|---|
| `Atleta` | Dados pessoais, tipo sanguíneo, alergias e contacto de emergência |
| `Staff` | Funcionários que gerem inscrições e pesagens |
| `Juri` | Membros do júri com credenciais |
| `Patrocinador` | Empresas patrocinadoras e tipo de patrocínio |
| `Edicao` | Edições/competições (data, local, estado) |
| `Categoria` | Categorias com limites de peso, altura e género |
| `Criterio` | Critérios de avaliação com peso percentual |
| `Inscricao` | Ligação atleta ↔ edição ↔ categoria, com estado (Pendente/Validada/Cancelada) |
| `Pagamento` | Fatura associada a uma inscrição (MBWay, Transferência, Dinheiro) |
| `Pesagem` | Peso e altura reais medidos no dia + número frontal anónimo |
| `Avaliacao` | Nota por júri, por critério, por fase (Prejudging/Finals) |
| `Edicao_Staff` | Associação staff ↔ edição |
| `Edicao_Patrocinador` | Associação patrocinador ↔ edição com valor patrocinado |

## Funcionalidades implementadas

### Views
- `View_Checkin_Pendente` — atletas com inscrição validada mas ainda sem pesagem registada.
- `View_Pauta_Classificativa` — classificação por edição, categoria e fase, com média das notas por número frontal (sem revelar o nome do atleta até ao fim).
- `View_Avaliacoes_Juri` — registo detalhado de todas as avaliações por júri.

### Procedures
- `sp_RegistarCheckIn` — regista a pesagem de um atleta, validando que a inscrição está no estado correto antes de inserir.

### Triggers
- `trg_before_pagamento` — impede pagamentos em inscrições canceladas.
- `trg_after_pagamento` — ao registar um pagamento com sucesso, valida automaticamente a inscrição (Pendente → Validada).
- `trg_valida_fase_final` — validação antes de inserir avaliações na fase Finals.

### Functions
- `fn_CalcularIdade` — calcula a idade de um atleta a partir da data de nascimento.

### Permissões (utilizadores MySQL)
| Utilizador | Perfil | Acesso |
|---|---|---|
| `admin_apollo` | Direção | Total (ALL PRIVILEGES) |
| `staff_rececao` | Staff | Atleta, Inscrição, Pesagem, Pagamento (leitura/escrita) |
| `juri_avaliador` | Júri | Avaliação (leitura/escrita), Inscrição e Pesagem (leitura) |

## Ordem de execução dos scripts

```
1. gerar_tabelas.sql   — cria o schema e todas as tabelas
2. index.sql           — índices para otimização de queries
3. Views.sql           — views
4. Functions.sql       — funções
5. Procedures.sql      — stored procedures
6. Triggers.sql        — triggers
7. populacao.sql       — dados de exemplo
8. users_perms.sql     — criação de utilizadores e permissões
9. TRADUCAO.sql        — queries de tradução dos requisitos do modelo (testes funcionais)
```

## Como executar

Requisito: **MySQL Server** instalado e em execução.

```bash
mysql -u root -p < codigos_projeto/gerar_tabelas.sql
mysql -u root -p < codigos_projeto/index.sql
mysql -u root -p < codigos_projeto/Views.sql
mysql -u root -p < codigos_projeto/Functions.sql
mysql -u root -p < codigos_projeto/Procedures.sql
mysql -u root -p < codigos_projeto/Triggers.sql
mysql -u root -p < codigos_projeto/populacao.sql
mysql -u root -p < codigos_projeto/users_perms.sql
```

Ou abrir os ficheiros directamente no **MySQL Workbench** pela ordem indicada.

## Modelos

- `modelo_conceptual.png` — diagrama entidade-associação (modelo conceptual).
- `modelo_logico.png` — modelo lógico relacional.
- `modelo_conceptual.brM3` — ficheiro editável (BR Modelo).
- `modelo_logico.mwb` — ficheiro editável (MySQL Workbench).

## Relatório

`relatorio final.pdf` — relatório completo com modelo conceptual, modelo lógico, decisões de design, queries de tradução e testes.
