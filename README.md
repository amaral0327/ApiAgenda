# ApiAgenda - Sistema de Agendamento

Este projeto é uma **API RESTful** desenvolvida em **ASP.NET Core** com **Entity Framework Core** e **SQL Server**, que gerencia o agendamento de clientes para uma barbearia.

## Tecnologias Utilizadas

- ASP.NET Core Web API
- Entity Framework Core (com Migrations)
- SQL Server
- C#
- Swagger (para documentação e testes de endpoints)

## Estrutura da API

A API possui os seguintes endpoints:

### Clientes (`/api/values`)
- `GET /api/values` → Lista todos os clientes
- `GET /api/values/{id}` → Retorna cliente por ID
- `POST /api/values` → Cadastra um novo cliente
- `PUT /api/values/{id}` → Atualiza cliente existente
- `DELETE /api/values/{id}` → Remove cliente

### Barbeiros (`/api/barbeiros`)
- `GET /api/barbeiros`
- `GET /api/barbeiros/{id}`
- `POST /api/barbeiros`
- `PUT /api/barbeiros/{id}`
- `DELETE /api/barbeiros/{id}`

### Agendamentos (`/api/agendamentos`)
- `GET /api/agendamentos` → Lista agendamentos com dados do cliente e barbeiro
- `GET /api/agendamentos/{id}` → Retorna agendamento por ID
- `POST /api/agendamentos` → Cria um novo agendamento
- `PUT /api/agendamentos/{id}` → Atualiza um agendamento
- `DELETE /api/agendamentos/{id}` → Remove agendamento

## Banco de Dados

- O banco foi criado com **Migrations do Entity Framework Core**
- Tabelas: `Clientes`, `Barbeiros` e `Agendamentos` com relacionamentos apropriados


