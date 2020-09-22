const { createPool } = require('mysql');

const pool = createPool({
  host: process.env.MYSQL_HOST,
  port: process.env.MYSQL_PORT,
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DATABASE
});

const query = (sql, values) => {
  return new Promise((resolve, reject) => {
    pool.getConnection((err, connection) => {
      if (err) reject(err);
      else {
        connection.query(sql, values, (err, rows) => {
          if (err) reject(err);
          else resolve(rows);
          connection.release();
        });
      }
    });
  });
};

module.exports = { query };
