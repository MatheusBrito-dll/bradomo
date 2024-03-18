const express = require('express');
const mysql = require('mysql');
const basicAuth = require('basic-auth');

const app = express();
const { v4: uuidv4 } = require('uuid');
app.use(express.json());
const port = 3000;

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'brd',
  port: 3306,
  charset : 'utf8mb4' // Definindo a codificação como UTF-8
});

/**

const connection = mysql.createConnection({
  host: '172.16.3.180',
  user: 'castrillon',
  password: 'castri123',
  database: 'brd_master',
  port: 3306,
  charset : 'utf8mb4' // Definindo a codificação como UTF-8
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

  let status = 0; // Alteração para utilizar let em vez de const

  console.log('Atualização de Mesa ->');
  console.log(req.body);

  if (id === undefined || defeito === undefined || ativo === undefined || usuario === undefined || capacidade === undefined) {
    return res.status(400).send('Informações insuficientes!');
  }

  const updateMesaSQL = 'UPDATE rs_mesa SET CAPACIDADE = ?, DEFEITO = ?, ATIVO = ?, USR_ALT = ?, STATUS = ?, DT_ALT = now() WHERE ID_MESA = ?';

  if (ativo === 1 ) {
    status = 0;
  } else if(ativo === 0){
    status = 3;
  }

  connection.query(updateMesaSQL, [capacidade, defeito, ativo, usuario, status, id], (err, updateResults) => {
    if (err) {
      console.error('Erro ao executar a atualização da mesa:', err);
      return res.status(500).send('Erro interno do servidor!');
    }

    if (updateResults.changedRows === 0) {
      return res.status(404).send('Mesa não encontrada.');
    }

    console.log('200 - Atualização de mesa OK.'); // Esta linha foi removida
    res.json(updateResults);
  });
});

app.post('/CadMesas', authenticate, (req, res) => {
  const novaMesa = req.body;
  
  // Gera um novo ID para a mesa e converte para maiúsculas
  const novoId = uuidv4().toUpperCase();

  // Verifica se o número da mesa já existe
  connection.query('SELECT COUNT(*) AS count FROM rs_mesa WHERE NUMERO = ?', [novaMesa.NUMERO], (error, results, fields) => {
      if (error) {
          console.error('Erro ao verificar número da mesa:', error);
          res.status(500).send('Erro ao verificar número da mesa');
          return;
      }

      // Se o número da mesa já existe, retorna uma mensagem de erro
      if (results[0].count > 0) {
          res.status(400).json({ error: 'O número da mesa já está cadastrado.' });
          return;
      }

      // Atribui o mesmo usuário tanto para USR_CAD quanto para USR_ALT
      novaMesa.USR_CAD = req.body.USUARIO;
      novaMesa.USR_ALT = req.body.USUARIO;

      // Insere os dados da nova mesa no banco de dados
      connection.query('INSERT INTO rs_mesa (ID_MESA, NUMERO, CAPACIDADE, STATUS, LOCAL, DEFEITO, ATIVO, USR_ALT, USR_CAD, PEND, LOG) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', 
          [novoId, novaMesa.NUMERO, novaMesa.CAPACIDADE, novaMesa.STATUS || 0, novaMesa.LOCAL, novaMesa.DEFEITO || 0, novaMesa.ATIVO ? 1 : 0, novaMesa.USR_ALT, novaMesa.USR_CAD, 0, "CADASTRADA"], 
          (error, results, fields) => {
              if (error) {
                  console.error('Erro ao cadastrar nova mesa:', error);
                  res.status(500).send('Erro ao cadastrar nova mesa');
                  return;
              }
              console.log('Nova mesa cadastrada com sucesso:', novoId);
              res.status(201).send('Mesa cadastrada com sucesso');
          });
  });
});




// Função para gerar um ID único para a mesa
function generateUniqueId() {
  // Gera um ID com base no timestamp atual e um número aleatório
  return `${Date.now().toString(36)}${Math.random().toString(36).substr(2, 9)}`;
}

