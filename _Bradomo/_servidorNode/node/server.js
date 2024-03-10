const express = require('express');
const mysql = require('mysql');
const basicAuth = require('basic-auth');

const app = express();
app.use(express.json());
const port = 3000;

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'brd',
  port: 3306
});

/**

const connection = mysql.createConnection({
  host: '172.16.3.180',
  user: 'castrillon',
  password: 'castri123',
  database: 'brd_master',
  port: 3306
});

 */

connection.connect(err => {
  if (err) {
    console.error('Erro ao conectar ao banco de dados!! -> ', err);
    return;
  }
  console.log('!Conexão com DB Completa!');
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

app.post('/atualizaSenha', authenticate, (req, res) => {
  const codigoUsuario = req.query.codigoUsuario;
  const userCpf = req.query.userCpf;
  const senhaNova = req.query.senhaNova;

  if (!codigoUsuario || !userCpf || !senhaNova) {
    return res.status(400).send('Informações insuficientes!');
  }

  // Verifica se o usuário existe antes de realizar a atualização
  const checkUserExistsSQL = 'SELECT COUNT(*) AS userCount FROM or_usuario WHERE CODIGO_USUARIO = ? AND CPF = ?';

  connection.query(checkUserExistsSQL, [codigoUsuario, userCpf], (err, results) => {
    if (err) {
      console.error('Erro ao verificar existência do usuário:', err);
      return res.status(500).send('Erro interno do servidor!');
    }

    const userCount = results[0].userCount;

    if (userCount === 0) {
      return res.status(404).send('Usuário não encontrado.');
    }

    // Usando Prepared Statement para a atualização
    const updatePasswordSQL = 'UPDATE or_usuario SET SENHA = ? WHERE CODIGO_USUARIO = ? AND CPF = ?';

    connection.query(updatePasswordSQL, [senhaNova, codigoUsuario, userCpf], (err, updateResults) => {
      if (err) {
        console.error('Erro ao executar a atualização da senha:', err);
        return res.status(500).send('Erro interno do servidor!');
      }

      if (updateResults.changedRows === 0) {
        return res.status(400).send('A senha fornecida é igual à senha atual.');
      }
      console.log('200 - Troca Senha OK.');
      res.json(updateResults);
    });
  });
});

app.get('/getLogin', authenticate, (req, res) => {
  const codigoUsuario = req.query.codigoUsuario;

  if (!codigoUsuario) {
    res.status(400).send('Código do usuário não fornecido nos parâmetros da consulta.');
    return;
  }

  const sql = `SELECT * FROM or_usuario WHERE CODIGO_USUARIO = '${codigoUsuario}'`;  
  connection.query(sql, (err, results) => {
    if (err) {
      console.error('Erro ao executar a consulta!! -> ', err);
      res.status(500).send('Erro interno do servidor!!');
      return;
    }
    console.log('200 - Login OK');
    res.json(results); 
  });
});

app.get('/getMesas', authenticate, (req, res) => {

  //setTimeout(function() {
    // Seu código aqui
    const sql = `SELECT * FROM rs_mesa ORDER BY NUMERO`;  
    connection.query(sql, (err, results) => {
      if (err) {
        console.error('Erro ao executar a consulta!! -> ', err);
        res.status(500).send('Erro interno do servidor!!');
        return;
      }
      console.log('200 - Get Mesa OK');
      res.json(results);
    });

  //}, 5000);

  
});

app.post('/PostAltMesas', authenticate, (req, res) => {
  const { id, defeito, ativo, capacidade, usuario } = req.body;

  console.log(req.body);

  if (id === undefined || defeito === undefined || ativo === undefined || usuario === undefined || capacidade === undefined) {
    return res.status(400).send('Informações insuficientes!');
  }
  

  const updateMesaSQL = 'UPDATE rs_mesa SET CAPACIDADE = ?, DEFEITO = ?, ATIVO = ?, USR_ALT = ?, DT_ALT = now() WHERE ID_MESA = ?';

  connection.query(updateMesaSQL, [capacidade, defeito, ativo, usuario, id], (err, updateResults) => {
    if (err) {
      console.error('Erro ao executar a atualização da mesa:', err);
      return res.status(500).send('Erro interno do servidor!');
    }

    if (updateResults.changedRows === 0) {
      return res.status(404).send('Mesa não encontrada.');
    }

    console.log('200 - Atualização de mesa OK.');
    res.json(updateResults);
  });
});




app.listen(port, () => {
  console.log();
  console.log(`⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⠕⠕⠕⠕⢕⢕
⢕⢕⢕⢕⢕⠕⠕⢕⢕⢕⢕⢕⢕⢕⢕⢕⢕⠕⠁⣁⣠⣤⣤⣤⣶⣦⡄⢑
⢕⢕⢕⠅⢁⣴⣤⠀⣀⠁⠑⠑⠁⢁⣀⣀⣀⣀⣘⢻⣿⣿⣿⣿⣿⡟⢁⢔
⢕⢕⠕⠀⣿⡁⠄⠀⣹⣿⣿⣿⡿⢋⣥⠤⠙⣿⣿⣿⣿⣿⡿⠿⡟⠀⢔⢕
⢕⠕⠁⣴⣦⣤⣴⣾⣿⣿⣿⣿⣇⠻⣇⠐⠀⣼⣿⣿⣿⣿⣿⣄⠀⠐⢕⢕
⠅⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠐⢕
⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠐
⢄⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆
⢕⢔⠀⠈⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⢕⢕⢄⠈⠳⣶⣶⣶⣤⣤⣤⣤⣭⡍⢭⡍⢨⣯⡛⢿⣿⣿⣿⣿⣿⣿⣿⣿
⢕⢕⢕⢕⠀⠈⠛⠿⢿⣿⣿⣿⣿⣿⣦⣤⣿⣿⣿⣿⣦⣈⠛⢿⢿⣿⣿⣿
⢕⢕⢕⠁⢠⣾⣶⣾⣭⣖⣛⣿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡆⢸⣿⣿⣿
⢕⢕⠅⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠈⢿⣿⣿⡇
⢕⠕⠀⠼⠟⢉⣉⡙⠻⠿⢿⣿⣿⣿⣿⣿⡿⢿⣛⣭⡴⠶⠶⠂⠀⠿⠿⠇`)
  console.log();
  console.log(`Servidor rodando em http://localhost:${port}`);
});

