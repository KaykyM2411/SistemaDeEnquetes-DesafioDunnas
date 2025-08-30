
-----

# Sistema de Enquetes - Rails ✨

Um sistema completo de criação e gerenciamento de enquetes desenvolvido em **Ruby on Rails**, permitindo que usuários criem, participem e administrem votações online.

-----

## 💻 Tecnologias Utilizadas

Este projeto foi construído sobre uma base robusta de tecnologias modernas para garantir segurança, desempenho e uma ótima experiência de usuário.

  * **Backend**: **Ruby on Rails 8.0**
  * **Banco de Dados**: **PostgreSQL** 🐘
  * **Frontend**: **Tailwind CSS**, **Stimulus JS** e **Hotwire**
  * **Controle de Versão**: **Git** e **GitHub**

### 💎 Gems Principais

As seguintes gems foram essenciais para o desenvolvimento:

  * **`pg`**: Conector para o banco de dados **PostgreSQL**.
  * **`bcrypt`**: Utilizada para a criptografia segura de senhas via `has_secure_password`.
  * **`turbo-rails` e `stimulus-rails`**: A suite **Hotwire** foi a base para o frontend, proporcionando uma experiência de SPA com o mínimo de JavaScript. O Stimulus foi fundamental para a funcionalidade dinâmica de adicionar e remover campos de opção nas enquetes.

-----

## 💡 O Desafio e a Solução

Este projeto foi um grande marco para mim, representando minha primeira experiência prática com o framework Ruby on Rails. O aprendizado foi intenso e desafiador, especialmente em um curto período, mas a experiência foi incrivelmente recompensadora.

A solução foi projetada para cumprir todos os requisitos propostos no desafio, incluindo a separação clara de papéis entre **Usuários** e **Administradores**.

### Para Usuários

  - **Autenticação segura** com email e senha.
  - **Criação de enquetes** com múltiplas opções.
  - **Votação em enquetes abertas** com validação de voto único.
  - **Visualização de resultados** em tempo real.
  - **Histórico de participação** em enquetes.

### Para Administradores

  - **Gerenciamento completo** de usuários e enquetes.
  - **Controle de status** das enquetes (abrir/fechar).
  - **Moderação de conteúdo**: ao excluir um usuário, todas as suas enquetes são automaticamente fechadas, mantendo a integridade dos dados.

-----

## 🗃️ Arquitetura do Banco de Dados

### Modelo de Dados

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    Users    │────│    Polls    │────│   Options   │────│    Votes    │
├─────────────┤    ├─────────────┤    ├─────────────┤    ├─────────────┤
│ id          │    │ id          │    │ id          │    │ id          │
│ email       │    │ question    │    │ content     │    │ user_id     │
│ password_*  │    │ poll_type   │    │ poll_id     │    │ poll_id     │
│ user_type   │    │ status      │    │ created_at  │    │ option_id   │
│ created_at  │    │ user_id     │    │ updated_at  │    │ created_at  │
│ updated_at  │    │ user_email  │    └─────────────┘    │ updated_at  │
└─────────────┘    │ created_at  │                       └─────────────┘
                   │ updated_at  │
                   └─────────────┘
```

### Relacionamentos

  - **User** `has_many` **Polls** (1:N)
  - **User** `has_many` **Votes** (1:N)
  - **Poll** `has_many` **Options** (1:N)
  - **Poll** `has_many` **Votes** `through` **Options**
  - **Option** `has_many` **Votes** (1:N)
  - **Vote** `belongs_to` **User**, **Poll**, **Option** (N:1)

-----

## 🛡️ Funcionalidades Técnicas

### Segurança

  - **Autenticação** com `bcrypt` via `has_secure_password`.
  - **Validação de integridade** entre votos, opções e enquetes.
  - **Prevenção de voto duplo** por usuário/enquete.
  - **Controle de acesso** por tipo de usuário.

### Performance

  - **Índices otimizados** para consultas frequentes:
      - `users.email` (único)
      - `polls.status`
      - `votes.user_id + poll_id` (único)
  - **Eager loading** para evitar N+1 queries.
  - **Contadores eficientes** para resultados.

### Validações de Negócio

  - **Voto único**: Usuário não pode votar duas vezes na mesma enquete.
  - **Integridade de dados**: Opção deve pertencer à enquete.
  - **Status consistente**: Controle de enquetes abertas/fechadas.

-----

## 🚀 Instalação e Configuração

### Pré-requisitos

  - Ruby 3.x
  - Rails 8.0
  - PostgreSQL
  - Bundler

### Setup do Projeto

```bash
# Clone o repositório
git clone https://github.com/KaykyM2411/SistemaDeEnquetes-DesafioDunnas.git
cd sistema-enquetes

# Instale as dependências
bundle install
rails assets:precompile

# Configure o banco de dados
rails db:create
rails db:migrate
rails db:seed

# Inicie o servidor
rails server
```

### Configuração do Banco

```bash
# Criar o banco de dados de desenvolvimento
rails db:create

# Executar as migrações
rails db:migrate

# Popular com dados de exemplo (opcional)
rails db:seed
```

### Credenciais de Acesso

Após rodar `rails db:seed`, os seguintes usuários serão criados para facilitar o teste:

  * **Usuário Administrador**
      * **Email**: `admin123@gmail.com`
      * **Senha**: `123456`
  * **Usuários Comuns**
      * **Emails**: `kaykymarcelo@gmail.com`, `joao@gmail.com`, `maria@gmail.com`
      * **Senha**: `123456` (para todos os usuários comuns)

-----

## 📝 Uso do Sistema

### Criando uma Enquete

```ruby
# Exemplo de criação via console
user = User.find_by(email: "usuario@email.com")
poll = user.polls.create(
  question: "Qual sua linguagem favorita?",
  poll_type: "single",
  options_attributes: [
    { content: "Ruby" },
    { content: "Python" },
    { content: "JavaScript" }
  ]
)
```

### Votando em uma Enquete

```ruby
# Registrar voto
user = User.find(1)
poll = Poll.find(1)
option = poll.options.first

vote = Vote.create(
  user: user,
  poll: poll,
  option: option
)
```

### Consultando Resultados

```ruby
poll = Poll.find(1)

# Resultados detalhados
results = poll.results
# => {"Ruby" => 15, "Python" => 8, "JavaScript" => 12}

# Total de votos
total = poll.total_votes
# => 35

# Verificar se usuário votou
poll.voted_by?(current_user)
# => true/false
```

-----

## 📈 API e Endpoints

### Rotas Principais

  - `GET /polls` - Lista todas as enquetes
  - `POST /polls` - Cria nova enquete
  - `GET /polls/:id` - Detalhes da enquete
  - `PATCH /polls/:id` - Atualiza enquete
  - `POST /polls/:id/vote` - Registra voto
  - `GET /polls/:id/results` - Resultados da enquete

### Exemplo de Response

```json
{
  "poll": {
    "id": 1,
    "question": "Qual sua linguagem favorita?",
    "poll_type": "single",
    "status": "open",
    "total_votes": 35,
    "options": [
      {
        "id": 1,
        "content": "Ruby",
        "votes_count": 15
      },
      {
        "id": 2,
        "content": "Python", 
        "votes_count": 8
      }
    ]
  }
}
```


-----

## 🗺️ Roadmap e Melhorias

### Próximas Funcionalidades

  - [ ] **Enquetes com prazo** de encerramento automático ⏳
  - [ ] **Comentários** nas enquetes 💬
  - [ ] **Categorização** de enquetes 🏷️
  - [ ] **Dashboard analytics** avançado 📊
  - [ ] **API REST** completa.
  - [ ] **Notificações** em tempo real 🔔
  - [ ] **Enquetes anônimas** 👻
  - [ ] **Export de resultados** (CSV, PDF) 📥

### Otimizações Técnicas

  - [ ] **Cache** de resultados frequentes.
  - [ ] **Background jobs** para processamento.
  - [ ] **Rate limiting** para votação.
  - [ ] **Logs estruturados**.
  - [ ] **Monitoramento** de performance.

-----

## 🤝 Contribuição

1.  **Fork** o projeto.
2.  **Crie** uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`).
3.  **Commit** suas mudanças (`git commit -am 'feat: Adiciona nova funcionalidade'`).
4.  **Push** para a branch (`git push origin feature/nova-funcionalidade`).
5.  **Abra** um Pull Request.

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

-----

**Sistema de Enquetes Rails** - Desenvolvido por Kayky
