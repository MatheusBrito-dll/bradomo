import express       from "express";
import cors          from "cors";
import basicAuth     from "basic-auth";

import getLogin      from "./Login/getLogin.mjs";
import atualizaSenha from "./Login/postAtualizaSenha.mjs";
import getMesas      from "./Mesas/getMesas.mjs";
import PostAltMesas  from "./Mesas/postAltMesas.mjs";
import CadMesa       from "./Mesas/postCadMesa.mjs";

import { connectToMySQLServer } from "./Config/Con_Db_MySQL_Server.mjs";
connectToMySQLServer();

//const basicAuth      = require('basic-auth');
const app            = express();
const port           = 3091;

app.use(express.json());
app.use(cors());

const authenticate = (req, res, next) => {
  const credentials = basicAuth(req);

  if (!credentials || credentials.name !== 'adminMaster@bradomo@sis' || credentials.pass !== '@B@str1ll0n@adminMaster@bradomo@sis') {
    res.status(401).send('Autenticação falhou. Credenciais inválidas.');
    return;
  }
  next();
};

app.get("/getLogin",       authenticate, getLogin);

app.post('/atualizaSenha', authenticate, atualizaSenha);

app.get('/getMesas',       authenticate, getMesas);

app.post('/PostAltMesas',  authenticate, PostAltMesas);

app.post('/CadMesas',      authenticate, CadMesa);

app.listen(port, () => {
  console.log();
  console.log(`
  _____       _    _                     _____       _  _        
  |     | ___ | |_ | |_  ___  _ _  ___   | __  | ___ |_|| |_  ___ 
  | | | || .'||  _||   || -_|| | ||_ -|  | __ -||  _|| ||  _|| . |
  |_|_|_||__,||_|  |_|_||___||___||___|  |_____||_|  |_||_|  |___|`);
  console.log();
  console.log(`Servidor rodando em http://localhost:${port}`);
});

export { authenticate };