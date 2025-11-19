USE controle_estoque;

-- 1) Tabelas mais dependentes (lado "filho" das FKs)
DROP TABLE IF EXISTS contagem_itens;
DROP TABLE IF EXISTS movimentos_estoque;
DROP TABLE IF EXISTS estoque;

-- 2) Tabelas que ainda são "pais" das primeiras, mas "filhas" de outras
DROP TABLE IF EXISTS contagens;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS usuarios;

-- 3) Tabelas de apoio referenciadas por outras
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS tipo_movimentos;
DROP TABLE IF EXISTS unidades_medida;
DROP TABLE IF EXISTS fornecedores;
DROP TABLE IF EXISTS tipo_usuarios;
