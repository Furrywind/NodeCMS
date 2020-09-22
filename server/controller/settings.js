const { query } = require('../config/database');
const Joi = require('@hapi/joi');

/* Validate user input by using Joi */
const schema = Joi.object({
  cid: Joi.number().required(),
  title: Joi.string().min(1).max(150).required(),
  slug: Joi.string().alphanum().lowercase().min(1).max(16).required(),
  content: Joi.string(),
  categoryId: Joi.number().required(),
  status: Joi.number().max(1).required(),
});

async function getDashboard(req, res) {
  try {
    const result = await query('SELECT COUNT(`cid`) articles FROM contents');
    const result2 = await query(
      'SELECT cid, title, created FROM contents WHERE status = 1 order by created DESC LIMIT 0,5'
    );
    const result3 = await query(
      'SELECT cid, title, created FROM contents WHERE status = 0 order by created DESC LIMIT 0,5'
    );
    res.send([result[0], result2, result3]);
  } catch (e) {
    res.sendStatus(500);
  }
}

async function getSettings(req, res) {
  try {
    const result = await query(
      'SELECT `value` FROM `settings` WHERE `name` = "siteName"'
    );
    const result2 = await query(
      'SELECT `value` FROM `settings` WHERE `name` = "address"'
    );
    const result3 = await query(
      'SELECT `value` FROM `settings` WHERE `name` = "description"'
    );
    res.send({
      siteName: result[0].value,
      address: result2[0].value,
      description: result3[0].value,
    });
  } catch (e) {
    res.sendStatus(500);
  }
}

async function editSettings(req, res) {
  try {
    const result = await query(
      'UPDATE `settings` SET `value` = ? WHERE `name` = "siteName"',
      [req.body.siteName]
    );
    const result2 = await query(
      'UPDATE `settings` SET `value` = ? WHERE `name` = "address"',
      [req.body.address]
    );
    const result3 = await query(
      'UPDATE `settings` SET `value` = ? WHERE `name` = "description"',
      [req.body.description]
    );
    res.sendStatus(200);
  } catch (e) {
    res.sendStatus(500);
  }
}

module.exports = {
  getDashboard,
  getSettings,
  editSettings,
};
