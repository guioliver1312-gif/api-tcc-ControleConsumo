# api-tcc-ControleConsumo
TCC de controle de consumo

## Estrutura do repositório
- `src/banco-dados/create.sql`: cria todas as tabelas do banco de dados MySQL utilizadas pelo sistema de controle de consumo.
- `src/banco-dados/insert.sql`: popula tabelas essenciais com dados iniciais (tipos de usuário, categorias, produtos etc.).
- `src/banco-dados/select.sql`: contém consultas úteis para validar a estrutura e testar o preenchimento das tabelas.
- `src/banco-dados/apagar-banco.sql`: script auxiliar para remover o banco de dados caso seja necessário recriar o ambiente.

## Como executar os scripts de banco de dados
1. Crie o banco de dados executando o conteúdo de `src/banco-dados/create.sql` em um servidor MySQL (ajuste o nome do schema se precisar).
2. Insira os registros básicos com `src/banco-dados/insert.sql` para ter tipos de usuário, categorias e produtos de exemplo.
3. Utilize as consultas em `src/banco-dados/select.sql` para verificar se as tabelas foram criadas e populadas corretamente.
4. Para limpar o ambiente ou recriar o schema do zero, use `src/banco-dados/apagar-banco.sql` antes de rodar novamente o script de criação.
