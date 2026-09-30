import express from "express";
import { createEvento } from "../controllers/evento.controller.js";

const eventoRouter = express.Router();  

eventoRouter.post("/", createEvento);

export default eventoRouter;