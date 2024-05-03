import { connectionPool } from "../Config/Con_Db_MySQL_Server.mjs";

const atualizaSenha = (req, res) => {
    const codigoUsuario = req.query.codigoUsuario;
    const userCpf = req.query.userCpf;
    const senhaNova = req.query.senhaNova;
  
    if (!codigoUsuario || !userCpf || !senhaNova) {
      return res.status(400).send('Informações insuficientes!');
    }
  
    // Verifica se o usuário existe antes de realizar a atualização
    const checkUserExistsSQL = 'SELECT COUNT(*) AS userCount FROM or_usuario WHERE CODIGO_USUARIO = ? AND CPF = ?';
  
    connectionPool.query(checkUserExistsSQL, [codigoUsuario, userCpf], (err, results) => {
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
  
      connectionPool.query(updatePasswordSQL, [senhaNova, codigoUsuario, userCpf], (err, updateResults) => {
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
  };

  export default atualizaSenha