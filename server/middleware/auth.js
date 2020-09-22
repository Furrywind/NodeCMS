const { query } = require('../config/database');
const jwt = require('jsonwebtoken');

function authenticate(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  if (token == null || token === '') return res.sendStatus(401);
  jwt.verify(token, process.env.TOKEN_SECRET, (err, data) => {
    if (err) return res.sendStatus(401);
    req.data = data;
    next();
  });
}

function permission(req, res, next) {
  if (req.data.role === 0) next();
  else if (req.data.role === 1) {
    if (req.body.role !== undefined && req.body.role !== 2) res.sendStatus(403);
    else next();
  } else if (req.data.role === 2) return res.sendStatus(403);
}

/* Target user's role must be match */
async function checkRole(req, res, next) {
  try {
    const result = await query(
      'SELECT `role` FROM `users` WHERE `username` = ?',
      [req.body.username]
    );
    if (result[0].role === req.body.role) next();
    else res.sendStatus(403);
  } catch (e) {
    res.sendStatus(500);
  }
}

module.exports = { authenticate, permission, checkRole };
