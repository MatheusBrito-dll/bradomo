import { connectToMySQLServer } from "../Config/Con_Db_MySQL_Server.mjs";

const PostAltMesas = (req, res) => {
    const connection = connectToMySQLServer();
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
  };


  export default PostAltMesas 