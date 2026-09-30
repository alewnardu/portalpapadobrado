# portalpapadobrado
Repositório do projeto do sistema Papa Dobrado

## Instalação

### Docker

docker-compose up -d

### Prisma

docker exec -it portalpapadobrado_app npm install prisma@7.10.0 -D

docker exec -it portalpapadobrado_app npx prisma init --datasource-provider "postgresql"

docker exec -it portalpapadobrado_app npx prisma migrate dev

docker exec -it portalpapadobrado_app npx prisma migrate reset