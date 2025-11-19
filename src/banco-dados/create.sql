use bd_tcc_des_125_consumo

-- ==========================
-- TABELA: TIPO_USUARIOS
-- ==========================
CREATE TABLE tipo_usuarios (
    tipoUsuario_id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_usuario   VARCHAR(30) NOT NULL
) ENGINE=InnoDB;

-- ==========================
-- TABELA: USUARIOS
-- ==========================
CREATE TABLE usuarios (
    usuario_id         INT AUTO_INCREMENT PRIMARY KEY,
    usuario_nome_login VARCHAR(60) NOT NULL,
    usuario_email      VARCHAR(70) NOT NULL UNIQUE,
    usuario_telefone   VARCHAR(20),
    tipoUsuario_id     INT NOT NULL,
    senha              VARCHAR(255) NOT NULL,
    usuario_ativo      BIT(1) NOT NULL,
    
    CONSTRAINT fk_usuarios_tipousuarios
        FOREIGN KEY (tipoUsuario_id)
        REFERENCES tipo_usuarios (tipoUsuario_id)
) ENGINE=InnoDB;

-- ==========================
-- TABELA: CATEGORIAS
-- ==========================
CREATE TABLE categorias (
    Categoria_id      INT AUTO_INCREMENT PRIMARY KEY,
    Categoria_nome    VARCHAR(50) NOT NULL,
    Categoria_pai_id  INT NULL,
    
    CONSTRAINT fk_categorias_categoria_pai
        FOREIGN KEY (Categoria_pai_id)
        REFERENCES categorias (Categoria_id)
) ENGINE=InnoDB;

-- ==========================
-- TABELA: UNIDADES_MEDIDA
-- ==========================
CREATE TABLE unidades_medida (
    Unidade_id INT AUTO_INCREMENT PRIMARY KEY,
    medida     VARCHAR(3) NOT NULL
) ENGINE=InnoDB;

-- ==========================
-- TABELA: FORNECEDORES
-- ==========================
CREATE TABLE fornecedores (
    Fornecedor_id          INT AUTO_INCREMENT PRIMARY KEY,
    Fornecedor_nome        VARCHAR(100) NOT NULL,
    Nome_fantasia          VARCHAR(40) NOT NULL,
    Fornecedore_cpf_cnpj   VARCHAR(20) NOT NULL UNIQUE,
    Fornecedor_telefone    VARCHAR(20) NOT NULL,
    Fornecedor_email       VARCHAR(70) UNIQUE,
    endereco               VARCHAR(120) NOT NULL,
    cidade                 VARCHAR(40) NOT NULL,
    estado                 CHAR(2) NOT NULL,
    cep                    CHAR(10) NOT NULL
) ENGINE=InnoDB;

-- ==========================
-- TABELA: PRODUTOS
-- ==========================
CREATE TABLE produtos (
    Produto_id      INT AUTO_INCREMENT PRIMARY KEY,
    Produto_nome    VARCHAR(70) NOT NULL,
    Categoria_id    INT NOT NULL,
    Unidade_id      INT NOT NULL,
    Estoque_minimo  SMALLINT NOT NULL,
    Produto_ativo   BIT(1) NOT NULL,
    
    CONSTRAINT fk_produtos_categorias
        FOREIGN KEY (Categoria_id)
        REFERENCES categorias (Categoria_id),
        
    CONSTRAINT fk_produtos_unidades
        FOREIGN KEY (Unidade_id)
        REFERENCES unidades_medida (Unidade_id)
) ENGINE=InnoDB;

-- ==========================
-- TABELA: TIPO_MOVIMENTOS
-- ==========================
CREATE TABLE tipo_movimentos (
    tipoMovimento_id INT AUTO_INCREMENT PRIMARY KEY,
    Tipo_movimento   VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

-- ==========================
-- TABELA: CONTAGENS
-- ==========================
CREATE TABLE contagens (
    contagem_id   INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id    INT NOT NULL,
    contagem_data DATE NOT NULL,
    CONSTRAINT fk_contagens_usuarios
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios (usuario_id)
) ENGINE=InnoDB;

-- ==========================
-- TABELA: CONTAGEM_ITENS
-- ==========================
CREATE TABLE contagem_itens (
    Contagem_id                INT NOT NULL,
    Produto_id                 INT NOT NULL,
    Contagem_itens_quantidade  SMALLINT NOT NULL,
    
    PRIMARY KEY (Contagem_id, Produto_id),
    
    CONSTRAINT fk_contagem_itens_contagens
        FOREIGN KEY (Contagem_id)
        REFERENCES contagens (contagem_id),
        
    CONSTRAINT fk_contagem_itens_produtos
        FOREIGN KEY (Produto_id)
        REFERENCES produtos (Produto_id)
) ENGINE=InnoDB;

-- ==========================
-- TABELA: MOVIMENTOS_ESTOQUE
-- ==========================
CREATE TABLE movimentos_estoque (
    Movimento_id     INT AUTO_INCREMENT PRIMARY KEY,
    tipoMovimento_id INT NOT NULL,
    Produto_id       INT NOT NULL,
    usuario_id       INT NOT NULL,
    Quantidade       SMALLINT NOT NULL,
    Valor_unitario   DECIMAL(6,2) NOT NULL,
    Justificativa    VARCHAR(128),
    
    CONSTRAINT fk_movestoque_tipomov
        FOREIGN KEY (tipoMovimento_id)
        REFERENCES tipo_movimentos (tipoMovimento_id),
        
    CONSTRAINT fk_movestoque_produtos
        FOREIGN KEY (Produto_id)
        REFERENCES produtos (Produto_id),
        
    CONSTRAINT fk_movestoque_usuarios
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios (usuario_id)
) ENGINE=InnoDB;

-- ==========================
-- TABELA: ESTOQUE
-- ==========================
CREATE TABLE estoque (
    Estoque_id            INT AUTO_INCREMENT PRIMARY KEY,
    Estoque_quantidade    INT NOT NULL,
    Estoque_dt_vencimento DATE NOT NULL,
    Produto_id            INT NOT NULL,
    Fornecedor_id         INT NOT NULL,
    
    CONSTRAINT fk_estoque_produtos
        FOREIGN KEY (Produto_id)
        REFERENCES produtos (Produto_id),
        
    CONSTRAINT fk_estoque_fornecedores
        FOREIGN KEY (Fornecedor_id)
        REFERENCES fornecedores (Fornecedor_id)
) ENGINE=InnoDB;
