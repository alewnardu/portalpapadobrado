import prisma from "../../prisma/lib/prisma.js";

export async function getPeladeiros(req, res) {
  try {
    const peladeiros = await prisma.peladeiro.findMany();
    return res.json(peladeiros);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Internal Server Error" });
  }
};

export async function createPeladeiro(req, res) {
    try {
        const { nomeCompleto, nomeCamisa, numeroCamisa, funcaoTatica, slug } = req.body;
        
        const peladeiro = await prisma.peladeiro.create({
            data: {
                nomeCompleto,
                nomeCamisa,
                numeroCamisa: parseInt(numeroCamisa, 10),
                funcaoTatica,
                slug
            }
        });
        return res.status(201).json(peladeiro);
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            message: "Erro ao criar usuário!",
            error: error.message,
        });
    }
}
