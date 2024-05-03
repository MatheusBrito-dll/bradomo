import { connectionPool } from "../Config/Con_Db_MySQL_Server.mjs";
import { v4 as uuidv4 } from 'uuid';

const CadMesa = (req, res) => {
    const novaMesa = req.body;
  
    console.log(req.body);
    
    // Gera um novo ID para a mesa e converte para maiúsculas
    const novoId = uuidv4().toUpperCase();
  
    // Verifica se o número da mesa já existe
    connectionPool.query('SELECT COUNT(*) AS count FROM rs_mesa WHERE NUMERO = ?', [novaMesa.NUMERO], (error, results, fields) => {
        if (error) {
            console.error('Ops! Erro ao verificar número da mesa:', error);
            res.status(500).send('Ops! Erro ao verificar número da mesa');
            return;
        }
  
        // Se o número da mesa já existe, retorna uma mensagem de erro
        if (results[0].count > 0) {
            res.status(400).json({ error: 'Ops! O número da mesa já está cadastrado.' });
            return;
        }
  
        // Atribui o mesmo usuário tanto para USR_CAD quanto para USR_ALT
        novaMesa.USR_CAD = req.body.USUARIO;
        novaMesa.USR_ALT = req.body.USUARIO;
  
        // Insere os dados da nova mesa no banco de dados
        connectionPool.query('INSERT INTO rs_mesa (ID_MESA, NUMERO, CAPACIDADE, STATUS, LOCAL, DEFEITO, ATIVO, USR_ALT, USR_CAD, PEND, LOG) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', 
            [novoId, novaMesa.NUMERO, novaMesa.CAPACIDADE, novaMesa.STATUS || 0, novaMesa.LOCAL, novaMesa.DEFEITO || 0, novaMesa.ATIVO ? 1 : 0, novaMesa.USR_ALT, novaMesa.USR_CAD, 0, "CADASTRADA"], 
            (error, results, fields) => {
                if (error) {
                    console.error('Ops! Erro ao cadastrar nova mesa:', error);
                    res.status(500).send('Ops! Erro ao cadastrar nova mesa');
                    return;
                }
                console.log('Nova mesa cadastrada com sucesso:', novoId);
                res.status(201).send('Mesa cadastrada com sucesso');
            });
    });
  };

  function generateUniqueId() {
    return `${Date.now().toString(36)}${Math.random().toString(36).substr(2, 9)}`;
  }

  export default CadMesa