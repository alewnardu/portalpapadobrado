import express from "express";
import { getPeladeiros, createPeladeiro } from "../controllers/peladeiro.controller.js";

const peladeiroRouter = express.Router();

peladeiroRouter.get("/", getPeladeiros);
peladeiroRouter.post("/", createPeladeiro);

export default peladeiroRouter;