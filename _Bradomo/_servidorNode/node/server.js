const express = require('express');
const mysql = require('mysql');
const basicAuth = require('basic-auth');

const app = express();
const port = 3000;

const connection = mysql.createConnection({
  host: '172.16.3.180',
  user: 'castrillon',
  password: 'castri123',
  database: 'brd_master',
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

    res.json(results);
    
  });
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
  console.log("                    .,,uod8B8bou,,.")
  console.log("            ..,uod8BBBBBBBBBBBBBBBBRPFT?l!i:.")
  console.log("       ,=m8BBBBBBBBBBBBBBBRPFT?!||||||||||||||")
  console.log("       !...:!TVBBBRPFT||||||||||!!^^'''   ||||")
  console.log("       !.......:!?|||||!!^^'''            ||||")
  console.log("       !.........||||                     ||||")
  console.log("       !.........||||  ##b r a d o m o    ||||")
  console.log("       !.........||||  ##o n l i n e      ||||")
  console.log("       !.........||||  ##n o d e . j s    ||||")
  console.log("       !.........||||                     ||||")
  console.log("       !.........||||                     ||||")
  console.log("       `.........||||                    ,||||")
  console.log("        .;.......||||               _.-!!|||||")
  console.log(" .,uodWBBBBb.....||||       _.-!!|||||||||!:'")
  console.log("!YBBBBBBBBBBBBBBb..!|||:..-!!|||||||!iof68BBBBBb....")
  console.log("!..YBBBBBBBBBBBBBBb!!||||||||!iof68BBBBBBRPFT?!::   `.")
  console.log("!....YBBBBBBBBBBBBBBbaaitf68BBBBBBRPFT?!:::::::::     `.")
  console.log("!......YBBBBBBBBBBBBBBBBBBBRPFT?!::::::;:!^''`;:::       `.")
  console.log("!........YBBBBBBBBBBRPFT?!::::::::::^''...::::::;         iBBbo.")
  console.log("`..........YBRPFT?!::::::::::::::::::::::::;iof68bo.      WBBBBbo.")
  console.log("`..........:::::::::::::::::::::::;iof688888888888b.     `YBBBP^'")
  console.log("`........::::::::::::::::;iof688888888888888888888b.     `")
  console.log("`......:::::::::;iof688888888888888888888888888888b.")
  console.log("`....:::;iof688888888888888888888888888888888899fT!")
  console.log("`..::!8888888888888888888888888888888899fT|!^'''")
  console.log("`' !!988888888888888888888888899fT|!^'''")
  console.log("`!!8888888888888888899fT|!^'''")
  console.log("`!988888888899fT|!^''")
  console.log("`!9899fT|!^")
  console.log("`!^")
});
