const express = require('express');
const mysql = require('mysql');
const basicAuth = require('basic-auth');

const app = express();
const port = 3000;

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'brd',
  port: 3306
});

connection.connect(err => {
  if (err) {
    console.error('Erro ao conectar ao banco de dados!! -> ', err);
    return;
  }
  console.log('Conectado ao banco de dados MySQL...');
});

// Middleware para autenticação básica
const authenticate = (req, res, next) => {
  const credentials = basicAuth(req);

  if (!credentials || credentials.name !== 'adminMaster@bradomo@sis' || credentials.pass !== '@B@str1ll0n@adminMaster@bradomo@sis') {
    res.status(401).send('Autenticação falhou. Credenciais inválidas.');
    return;
  }

  next(); // Continuar para a próxima rota
};

app.get('/api/exemplo', authenticate, (req, res) => {
  const codigoUsuario = req.query.codigoUsuario;

  if (!codigoUsuario) {
    res.status(400).send('Código do usuário não fornecido nos parâmetros da consulta.');
    return;
  }

  const sql = `SELECT * FROM OR_USUARIO WHERE CODIGO_USUARIO = '${codigoUsuario}'`;  
  connection.query(sql, (err, results) => {
    if (err) {
      console.error('Erro ao executar a consulta!! -> ', err);
      res.status(500).send('Erro interno do servidor!!');
      return;
    }
    res.json(results);
  });
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
