const { query } = require('../config/database');
const jwt = require('jsonwebtoken');
const Joi = require('@hapi/joi');
const { hash, compare } = require('bcrypt');

/* Validate user input by using Joi */
const schema = Joi.object({
  username: Joi.string().alphanum().lowercase().min(1).max(16).required(),
  password: Joi.string().pattern(/^[a-zA-Z0-9@^$!%*#?&]{8,64}$/),
  nickname: Joi.string().min(1).max(16),
  role: Joi.number().integer().min(1).max(2),
});

async function login(req, res) {
  if (schema.validate(req.body).error) return res.sendStatus(400);
  try {
    const result = await query('SELECT * FROM `users` WHERE `username` = ?', [
      req.body.username,
    ]);
    if (result[0] == null) return res.sendStatus(400);
    if (!(await compare(req.body.password, result[0].password)))
      return res.sendStatus(400);
    const userInfo = {
      uid: result[0].uid,
      nickname: result[0].nickname,
      role: result[0].role,
    };
    jwt.sign(
      userInfo,
      process.env.TOKEN_SECRET,
      { expiresIn: '3d' },
      (err, token) => {
        res.json({
          userInfo,
          token,
        });
      }
    );
  } catch (e) {
    res.sendStatus(500);
  }
}

async function getUsers(req, res) {
  try {
    const result = await query(
      'SELECT `username`, `nickname`, `role` FROM `users` WHERE `role` >= ?',
      [req.data.role]
    );
    res.send(result);
  } catch (e) {
    res.sendStatus(500);
  }
}

async function addUser(req, res) {
  delete req.body.confirmPassword;
  if (schema.validate(req.body).error) return res.sendStatus(400);
  try {
    const hashedPassword = await hash(req.body.password, 10);
    const result = await query(
      'INSERT INTO `users` (`username`, `password`, `nickname`, `role`) VALUES (?,?,?,?)',
      [req.body.username, hashedPassword, req.body.nickname, req.body.role]
    );
    res.sendStatus(200);
  } catch (e) {
    /* User already exist */
    if (e.errno === 1062) res.sendStatus(409);
    else res.sendStatus(500);
  }
}

async function editUser(req, res) {
  delete req.body.role;
  delete req.body.confirmPassword;
  if (req.body.password === '') delete req.body.password;
  if (schema.validate(req.body).error) return res.sendStatus(400);
  try {
    if (req.body.password !== undefined) {
      const hashedPassword = await hash(req.body.password, 10);
      const result = await query(
        'UPDATE `users` SET `nickname` = ?, `password` = ? WHERE `username` = ?',
        [req.body.nickname, hashedPassword, req.body.username]
      );
    } else {
      const result = await query(
        'UPDATE `users` SET `nickname` = ? WHERE `username` = ?',
        [req.body.nickname, req.body.username]
      );
    }
    res.sendStatus(200);
  } catch (e) {
    /* Nickname already exist */
    if (e.errno === 1062) res.sendStatus(409);
    else res.sendStatus(500);
  }
}

async function deleteUser(req, res) {
  if (req.body.username === 'admin') return res.sendStatus(403);
  try {
    const result = await query('DELETE FROM `users` WHERE `username` = ?', [
      req.body.username,
    ]);
    res.sendStatus(200);
  } catch (e) {
    res.sendStatus(500);
  }
}

module.exports = { login, getUsers, addUser, editUser, deleteUser };
