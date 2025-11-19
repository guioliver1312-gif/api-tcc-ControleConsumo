USE controle_estoque;

-- ============================================
-- TIPO_USUARIOS
-- ============================================
INSERT INTO tipo_usuarios (tipoUsuario_id, tipo_usuario) VALUES
(1, 'Administrador'),
(2, 'Responsável Estoque'),
(3, 'Caixa');

-- ============================================
-- USUARIOS
-- ============================================
INSERT INTO usuarios (
    usuario_id,
    usuario_nome_login,
    usuario_email,
    usuario_telefone,
    tipoUsuario_id,
    senha,
    usuario_ativo
) VALUES
(1, 'admin', 'admin@sistemarestaurante.com',       '11999990000', 1, '$2y$10$adminhash',       1),
(2, 'joao.estoque', 'joao.estoque@sistemarestaurante.com', '11988887777', 2, '$2y$10$joaoestoque',   1),
(3, 'maria.caixa',  'maria.caixa@sistemarestaurante.com',  '11977776666', 3, '$2y$10$mariacaixa',    1);

-- ============================================
-- CATEGORIAS (com categoria pai simulando hierarquia)
-- ============================================
INSERT INTO categorias (Categoria_id, Categoria_nome, Categoria_pai_id) VALUES
(1, 'Bebidas',        NULL),
(2, 'Refrigerantes',  1),
(3, 'Sucos',          1),
(4, 'Carnes',         NULL),
(5, 'Laticínios',     NULL),
(6, 'Mercearia',      NULL);

-- ============================================
-- UNIDADES_MEDIDA
-- ============================================
INSERT INTO unidades_medida (Unidade_id, medida) VALUES
(1, 'UN'),
(2, 'KG'),
(3, 'L');

-- ============================================
-- FORNECEDORES
-- ============================================
INSERT INTO fornecedores (
    Fornecedor_id,
    Fornecedor_nome,
    Nome_fantasia,
    Fornecedore_cpf_cnpj,
    Fornecedor_telefone,
    Fornecedor_email,
    endereco,
    cidade,
    estado,
    cep
) VALUES
(1, 'Distribuidora de Bebidas São Paulo Ltda', 'DBSP',
 '12.345.678/0001-90', '1133334444', 'contato@dbsp.com.br',
 'Rua das Bebidas, 100', 'São Paulo', 'SP', '01000-000'),

(2, 'Atacado de Alimentos Brasil', 'Atacadão Brasil',
 '98.765.432/0001-10', '1122223333', 'vendas@atacadaobrasil.com.br',
 'Av. dos Alimentos, 250', 'São Paulo', 'SP', '02000-000'),

(3, 'Laticínios Serra Bela', 'Serra Bela',
 '11.222.333/0001-55', '1144445555', 'comercial@serrabela.com.br',
 'Rua do Leite, 50', 'Campinas', 'SP', '13000-000');

-- ============================================
-- PRODUTOS
-- ============================================
INSERT INTO produtos (
    Produto_id,
    Produto_nome,
    Categoria_id,
    Unidade_id,
    Estoque_minimo,
    Produto_ativo
) VALUES
(1, 'Coca-Cola Lata 350ml',           2, 1, 24, 1),
(2, 'Guaraná 2L',                     2, 1, 12, 1),
(3, 'Suco de Laranja 1L',             3, 1, 10, 1),
(4, 'Carne Bovina Patinho (kg)',      4, 2, 15, 1),
(5, 'Queijo Mussarela (kg)',          5, 2,  8, 1),
(6, 'Arroz Agulhinha 5kg',            6, 1, 20, 1);

-- ============================================
-- TIPO_MOVIMENTOS
-- ============================================
INSERT INTO tipo_movimentos (tipoMovimento_id, Tipo_movimento) VALUES
(1, 'CADASTRO'),
(2, 'ENTRADA'),
(3, 'SAIDA'),
(4, 'AJUSTE');

-- ============================================
-- CONTAGENS (simulando inventários em datas diferentes)
-- ============================================
INSERT INTO contagens (contagem_id, usuario_id, contagem_data) VALUES
(1, 2, '2025-01-10'),  -- João responsável pelo estoque
(2, 2, '2025-02-15');

-- ============================================
-- CONTAGEM_ITENS (ligando contagens aos produtos)
-- ============================================
INSERT INTO contagem_itens (
    Contagem_id,
    Produto_id,
    Contagem_itens_quantidade
) VALUES
-- Contagem 1 (inventário de janeiro)
(1, 1,  80),  -- Coca-Cola Lata
(1, 2,  30),  -- Guaraná 2L
(1, 3,  25),  -- Suco de Laranja
(1, 4,  40),  -- Carne Bovina
(1, 6,  50),  -- Arroz 5kg

-- Contagem 2 (inventário de fevereiro)
(2, 1,  70),
(2, 2,  28),
(2, 3,  22),
(2, 4,  38),
(2, 5,  15),
(2, 6,  48);

-- ============================================
-- MOVIMENTOS_ESTOQUE (entradas/saídas com valores)
-- ============================================
INSERT INTO movimentos_estoque (
    Movimento_id,
    tipoMovimento_id,
    Produto_id,
    usuario_id,
    Quantidade,
    Valor_unitario,
    Justificativa
) VALUES
-- Cadastro inicial dos produtos principais
(1, 1, 1, 1, 50,  3.00, 'Cadastro inicial de Coca-Cola Lata'),
(2, 1, 2, 1, 20,  6.50, 'Cadastro inicial de Guaraná 2L'),
(3, 1, 3, 1, 30,  5.80, 'Cadastro inicial de Suco de Laranja 1L'),
(4, 1, 4, 1, 30, 25.00, 'Cadastro inicial de Carne Bovina'),
(5, 1, 5, 1, 15, 32.00, 'Cadastro inicial de Queijo Mussarela'),
(6, 1, 6, 1, 40, 22.00, 'Cadastro inicial de Arroz 5kg'),

-- Entradas de compras
(7, 2, 1, 2, 100, 2.80, 'Compra de lote promocional de Coca-Cola'),
(8, 2, 4, 2,  20, 24.50, 'Compra de carne para fim de semana'),
(9, 2, 6, 2,  30, 21.50, 'Reposição de arroz para estoque'),

-- Saídas por consumo/venda
(10, 3, 1, 3,  40, 3.00, 'Consumo de Coca-Cola no salão'),
(11, 3, 4, 3,  10, 25.00, 'Consumo de carne em pratos do dia'),
(12, 3, 3, 3,  15, 5.80, 'Uso de suco em bebidas'),

-- Ajuste de estoque (ex.: perda, quebra, conferência)
(13, 4, 2, 2,   2, 6.50, 'Ajuste por quebra de garrafas de Guaraná'),
(14, 4, 5, 2,   1, 32.00, 'Ajuste por deterioração de queijo');

-- ============================================
-- ESTOQUE (quantidade atual por produto/fornecedor e validade)
-- ============================================
INSERT INTO estoque (
    Estoque_id,
    Estoque_quantidade,
    Estoque_dt_vencimento,
    Produto_id,
    Fornecedor_id
) VALUES
-- Coca-Cola (Distribuidora de Bebidas)
(1, 60, '2025-03-31', 1, 1),
(2, 50, '2025-04-30', 1, 1),

-- Guaraná (Distribuidora de Bebidas)
(3, 18, '2025-04-15', 2, 1),

-- Suco de Laranja (Distribuidora de Bebidas)
(4, 20, '2025-03-20', 3, 1),

-- Carne Bovina (Atacado de Alimentos)
(5, 25, '2025-02-05', 4, 2),
(6, 15, '2025-02-10', 4, 2),

-- Queijo Mussarela (Laticínios Serra Bela)
(7, 12, '2025-05-15', 5, 3),

-- Arroz 5kg (Atacado de Alimentos)
(8, 40, '2025-12-31', 6, 2);
