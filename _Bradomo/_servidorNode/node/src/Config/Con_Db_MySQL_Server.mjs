import mysql from "mysql";

/**
const connection_MySQL_Server = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'brd',
    port: 3306,
    charset : 'utf8mb4' // Definindo a codificação como UTF-8
  });
*/  

  const connection_MySQL_Server = mysql.createConnection({
    host: '172.16.3.180',
    user: 'castrillon',
    password: 'castri123',
    database: 'brd_master',
    port: 3306,
    charset : 'utf8mb4' // Definindo a codificação como UTF-8
  });


const connectToMySQLServer = () => {
    const connection = mysql.createConnection(connection_MySQL_Server.config);
    connection.connect(err => {
      if (err) {
        console.error('ERRO - {Db_MySQL_Server}', err);
        return;
      }
      console.log('OK - Conexão {Db_MySQL_Server} Completa');
    });
    return connection;
  };
  
  export { connectToMySQLServer };