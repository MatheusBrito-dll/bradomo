import { connectToMySQLServer } from "../Config/Con_Db_MySQL_Server.mjs";

const getLogin =  (req, res) => {
    const codigoUsuario = req.query.codigoUsuario;
    const connection = connectToMySQLServer();
    
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
  };

export default getLogin