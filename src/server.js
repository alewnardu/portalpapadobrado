import express from 'express'
import peladeiroRouter from './routes/peladeiro.routes.js'
import eventoRouter from './routes/evento.routes.js'

const app = express()
app.use(express.json())
const PORT = 3000

app.get('/', (req, res) => {
  res.send('API do Portal Papado Dobrado')
})

app.use('/peladeiros', peladeiroRouter)
app.use('/eventos', eventoRouter)

app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
})