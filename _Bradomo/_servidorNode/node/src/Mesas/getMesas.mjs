import { connectToMySQLServer } from "../Config/Con_Db_MySQL_Server.mjs";

const getMesas = (req, res) => {
    const connection = connectToMySQLServer();
    const sql = `SELECT * FROM rs_mesa ORDER BY NUMERO`;  
    connection.query(sql, (err, results) => {
      if (err) {
        console.error('Ops! Erro ao executar a consulta!! -> ', err);
        res.status(500).send('Erro interno do servidor!!');
        return;
      }
      console.log('200 - Get Mesa OK');
      res.json(results);
    });
};

export default getMesas