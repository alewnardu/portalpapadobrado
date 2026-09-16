create schema portalpapadobrado;

CREATE TABLE IF NOT EXISTS portalpapadobrado.peladeiro (
    id integer GENERATED ALWAYS AS IDENTITY primary key,
    nome varchar(50) NOT NULL UNIQUE,
    email varchar(50) NOT NULL UNIQUE,
    senha varchar(255) NOT NULL,
    foto varchar(255),
    data_cadastro timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE PROCEDURE portalpapadobrado.criar_peladeiro(
    p_nome varchar(50),
    p_email varchar(50),
    p_senha varchar(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO portalpapadobrado.peladeiro (nome, email, senha)
    VALUES (p_nome, p_email, p_senha);
END;
$$;
