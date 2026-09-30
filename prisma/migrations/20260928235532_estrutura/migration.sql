-- CreateEnum
CREATE TYPE "StatusPeladeiro" AS ENUM ('ATIVO', 'INATIVO', 'DEPARTAMENTO_MEDICO', 'SUSPENSO', 'PROIBIDO');

-- CreateEnum
CREATE TYPE "FuncaoTatica" AS ENUM ('GOLEIRO', 'ZAGUEIRO', 'MEIO_CAMPO', 'ATACANTE');

-- CreateEnum
CREATE TYPE "TipoVinculoPeladeiro" AS ENUM ('FILIADO', 'MENSALISTA', 'CONVIDADO');

-- CreateEnum
CREATE TYPE "StatusEvento" AS ENUM ('AGENDADO', 'INICIADO', 'ENCERRADO', 'CANCELADO');

-- CreateEnum
CREATE TYPE "TipoEvento" AS ENUM ('PELADA', 'TORNEIRO');

-- CreateEnum
CREATE TYPE "StatusPeladeiroEvento" AS ENUM ('ESCALAVEL', 'NAO_ESCALAVEL');

-- CreateEnum
CREATE TYPE "TipoCaixaMovimentacao" AS ENUM ('ENTRADA', 'SAIDA');

-- CreateEnum
CREATE TYPE "StatusCaixaMovimentacao" AS ENUM ('PENDENTE', 'PAGO');

-- CreateEnum
CREATE TYPE "StatusMaterial" AS ENUM ('NOVO', 'BOM', 'REGULAR', 'MANUTENCAO', 'EXTRAVIADO', 'BAIXADO');

-- CreateEnum
CREATE TYPE "OrigemRecursoMaterial" AS ENUM ('AQUISICAO', 'DOACAO');

-- CreateEnum
CREATE TYPE "StatusPartida" AS ENUM ('AGUARDANDO', 'PAUSADA', 'EM_ANDAMENTO', 'ENCERRADA', 'CANCELADA');

-- CreateEnum
CREATE TYPE "OpcoesCorColete" AS ENUM ('AZUL', 'PRETO');

-- CreateTable
CREATE TABLE "usuarios" (
    "id" SERIAL NOT NULL,
    "public_id" UUID NOT NULL,
    "peladeiro_id" INTEGER NOT NULL,
    "username" VARCHAR(50) NOT NULL,
    "email" VARCHAR(50) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT false,
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_atualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "peladeiros" (
    "id" SERIAL NOT NULL,
    "public_id" UUID NOT NULL,
    "nome_completo" VARCHAR(150) NOT NULL,
    "nome_camisa" VARCHAR(30) NOT NULL,
    "numero_camisa" INTEGER,
    "funcao_tatica" "FuncaoTatica",
    "slug" VARCHAR(100) NOT NULL,
    "imagem" VARCHAR(500),
    "status" "StatusPeladeiro" NOT NULL DEFAULT 'ATIVO',
    "data_nascimento" TIMESTAMP(3),
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_atualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "peladeiros_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "peladeiro_vinculos" (
    "id" SERIAL NOT NULL,
    "peladeiro_id" INTEGER NOT NULL,
    "tipo" "TipoVinculoPeladeiro" NOT NULL,
    "data_inicio" TIMESTAMP(3) NOT NULL,
    "data_fim" TIMESTAMP(3),
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_atualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "peladeiro_vinculos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "eventos" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(150) NOT NULL,
    "local" VARCHAR(150) NOT NULL,
    "status" "StatusEvento" NOT NULL DEFAULT 'AGENDADO',
    "tipoEvento" "TipoEvento" NOT NULL DEFAULT 'TORNEIRO',
    "data_inicio" TIMESTAMP(3) NOT NULL,
    "data_fim" TIMESTAMP(3),
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_atualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "eventos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "peladeiro_eventos" (
    "id" SERIAL NOT NULL,
    "peladeiro_id" INTEGER NOT NULL,
    "evento_id" INTEGER NOT NULL,
    "status" "StatusPeladeiroEvento" NOT NULL DEFAULT 'ESCALAVEL',
    "registro_entrada" TIMESTAMP(3) NOT NULL,
    "registro_saida" TIMESTAMP(3),
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_atualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "peladeiro_eventos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "caixa_movimentacoes" (
    "id" SERIAL NOT NULL,
    "evento_id" INTEGER NOT NULL,
    "peladeiro_id" INTEGER NOT NULL,
    "tipo" "TipoCaixaMovimentacao" NOT NULL,
    "status" "StatusCaixaMovimentacao" NOT NULL DEFAULT 'PENDENTE',
    "descricao" VARCHAR(255) NOT NULL,
    "valor" DECIMAL(10,2) NOT NULL,
    "data_movimentacao" TIMESTAMP(3) NOT NULL,
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_atualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "caixa_movimentacoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "recursos_materials" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(150) NOT NULL,
    "descricao" VARCHAR(255) NOT NULL,
    "status" "StatusMaterial",
    "origem" "OrigemRecursoMaterial" NOT NULL DEFAULT 'AQUISICAO',
    "caixa_movimentacao_id" INTEGER,
    "data_incorporacao" TIMESTAMP(3) NOT NULL,
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_atualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "recursos_materials_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "times" (
    "id" SERIAL NOT NULL,
    "public_id" UUID NOT NULL,
    "nome" VARCHAR(50) NOT NULL,
    "imagem" VARCHAR(500),
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_atualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "times_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "peladeiro_evento_times" (
    "id" SERIAL NOT NULL,
    "time_id" INTEGER NOT NULL,
    "peladeiro_evento_id" INTEGER NOT NULL,
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_atualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "peladeiro_evento_times_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partidas" (
    "id" SERIAL NOT NULL,
    "public_id" UUID NOT NULL,
    "evento_id" INTEGER NOT NULL,
    "status" "StatusPartida" NOT NULL DEFAULT 'AGUARDANDO',
    "inicio" TIMESTAMP(3),
    "fim" TIMESTAMP(3),
    "duracao_minutos" INTEGER,
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_atualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "partidas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partidas_times" (
    "id" SERIAL NOT NULL,
    "partida_id" INTEGER NOT NULL,
    "time_id" INTEGER NOT NULL,
    "cor_do_colete" "OpcoesCorColete" NOT NULL,

    CONSTRAINT "partidas_times_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gols" (
    "id" SERIAL NOT NULL,
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_atualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "gols_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_public_id_key" ON "usuarios"("public_id");

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_peladeiro_id_key" ON "usuarios"("peladeiro_id");

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "usuarios"("email");

-- CreateIndex
CREATE UNIQUE INDEX "peladeiros_public_id_key" ON "peladeiros"("public_id");

-- CreateIndex
CREATE UNIQUE INDEX "peladeiros_slug_key" ON "peladeiros"("slug");

-- CreateIndex
CREATE INDEX "peladeiro_vinculos_peladeiro_id_idx" ON "peladeiro_vinculos"("peladeiro_id");

-- CreateIndex
CREATE INDEX "peladeiro_eventos_peladeiro_id_idx" ON "peladeiro_eventos"("peladeiro_id");

-- CreateIndex
CREATE INDEX "peladeiro_eventos_evento_id_idx" ON "peladeiro_eventos"("evento_id");

-- CreateIndex
CREATE UNIQUE INDEX "peladeiro_eventos_peladeiro_id_evento_id_key" ON "peladeiro_eventos"("peladeiro_id", "evento_id");

-- CreateIndex
CREATE UNIQUE INDEX "recursos_materials_caixa_movimentacao_id_key" ON "recursos_materials"("caixa_movimentacao_id");

-- CreateIndex
CREATE UNIQUE INDEX "times_public_id_key" ON "times"("public_id");

-- CreateIndex
CREATE UNIQUE INDEX "partidas_public_id_key" ON "partidas"("public_id");

-- CreateIndex
CREATE INDEX "partidas_evento_id_idx" ON "partidas"("evento_id");

-- CreateIndex
CREATE INDEX "partidas_times_time_id_idx" ON "partidas_times"("time_id");

-- CreateIndex
CREATE UNIQUE INDEX "partidas_times_partida_id_time_id_key" ON "partidas_times"("partida_id", "time_id");

-- CreateIndex
CREATE UNIQUE INDEX "partidas_times_partida_id_cor_do_colete_key" ON "partidas_times"("partida_id", "cor_do_colete");

-- AddForeignKey
ALTER TABLE "usuarios" ADD CONSTRAINT "usuarios_peladeiro_id_fkey" FOREIGN KEY ("peladeiro_id") REFERENCES "peladeiros"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "peladeiro_vinculos" ADD CONSTRAINT "peladeiro_vinculos_peladeiro_id_fkey" FOREIGN KEY ("peladeiro_id") REFERENCES "peladeiros"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "peladeiro_eventos" ADD CONSTRAINT "peladeiro_eventos_peladeiro_id_fkey" FOREIGN KEY ("peladeiro_id") REFERENCES "peladeiros"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "peladeiro_eventos" ADD CONSTRAINT "peladeiro_eventos_evento_id_fkey" FOREIGN KEY ("evento_id") REFERENCES "eventos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "caixa_movimentacoes" ADD CONSTRAINT "caixa_movimentacoes_peladeiro_id_fkey" FOREIGN KEY ("peladeiro_id") REFERENCES "peladeiros"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "caixa_movimentacoes" ADD CONSTRAINT "caixa_movimentacoes_evento_id_fkey" FOREIGN KEY ("evento_id") REFERENCES "eventos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recursos_materials" ADD CONSTRAINT "recursos_materials_caixa_movimentacao_id_fkey" FOREIGN KEY ("caixa_movimentacao_id") REFERENCES "caixa_movimentacoes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "peladeiro_evento_times" ADD CONSTRAINT "peladeiro_evento_times_peladeiro_evento_id_fkey" FOREIGN KEY ("peladeiro_evento_id") REFERENCES "peladeiro_eventos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "peladeiro_evento_times" ADD CONSTRAINT "peladeiro_evento_times_time_id_fkey" FOREIGN KEY ("time_id") REFERENCES "times"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "partidas_times" ADD CONSTRAINT "partidas_times_partida_id_fkey" FOREIGN KEY ("partida_id") REFERENCES "partidas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "partidas_times" ADD CONSTRAINT "partidas_times_time_id_fkey" FOREIGN KEY ("time_id") REFERENCES "times"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
