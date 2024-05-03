import { connectionPool } from "../Config/Con_Db_MySQL_Server.mjs";

const getLogin = (req, res) => {
  const codigoUsuario = req.query.codigoUsuario;

  if (!codigoUsuario) {
    res.status(400).send('Código do usuário não fornecido nos parâmetros da consulta.');
    return;
  }

  connectionPool.getConnection((err, connection) => {
    if (err) {
      console.error('Erro ao obter conexão do pool:', err);
      res.status(500).send('Erro interno do servidor.');
      return;
    }

    const sql = `SELECT * FROM or_usuario WHERE CODIGO_USUARIO = '${codigoUsuario}'`;
    connection.query(sql, (queryErr, results) => {
      connection.release(); // Liberando a conexão de volta ao pool

      if (queryErr) {
        console.error('Erro ao executar a consulta:', queryErr);
        res.status(500).send('Erro interno do servidor.');
        return;
      }

      console.log('200 - Login OK');
      res.json(results);
    });
  });
};

export default getLogin;
