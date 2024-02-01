const express = require('express');
const mysql = require('mysql');

const app = express();
const port = 3000;
/*
// Configuração da conexão com o banco de dados
const connection = mysql.createConnection({
  host: '172.16.3.61',
  user: 'castrillon',
  password: 'castri123',
  database: 'sav_loja2',
  port: 3306
}); */

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'brd',
  port: 3306
});


// Conectar ao banco de dados
connection.connect(err => {
  if (err) {
    console.error('Erro ao conectar ao banco de dados!! -> ', err);
    return;
  }
  console.log('Conectado ao banco de dados MySQL...');
});

// Rota de exemplo para obter dados do banco de dados
app.get('/api/exemplo', (req, res) => {
    const codigoUsuario = '000001';
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

// Iniciar o servidor
app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
