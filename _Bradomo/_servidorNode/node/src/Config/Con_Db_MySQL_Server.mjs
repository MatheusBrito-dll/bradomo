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

const connectionPool = mysql.createPool({
  connectionLimit: 10, // número máximo de conexões no pool
  host: '172.16.3.180',
  user: 'castrillon',
  password: 'castri123',
  database: 'brd_master',
  port: 3306,
  charset: 'utf8mb4'
});

const connectToMySQLServer = () => {
  return connectionPool.getConnection();
};

export { connectionPool, connectToMySQLServer };

