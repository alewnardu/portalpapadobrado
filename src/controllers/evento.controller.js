import prisma from "../../prisma/lib/prisma.js";

export async function createEvento(req, res) {
    try {
        const {nome, local, dataInicio, tipoEvento} = req.body;
        const evento = await prisma.evento.create({
            data: {
                nome,
                local,
                dataInicio: new Date(dataInicio),
                tipoEvento
            }
        });
        return res.status(201).json(evento);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: error.message });
    }
}