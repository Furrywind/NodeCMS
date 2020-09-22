const { query } = require('../config/database');
const Joi = require('@hapi/joi');

/* Validate user input by using Joi */
const schema = Joi.object({
  name: Joi.string().min(1).max(16).required(),
  slug: Joi.string().alphanum().lowercase().min(1).max(16).required(),
});

async function getLabels(req, res) {
  try {
    const result = await query(
      'SELECT `mid`, `name`, `slug` FROM `metas` WHERE `type` = "label"'
    );
    res.send(result);
  } catch (e) {
    res.sendStatus(500);
  }
}

async function addLabel(req, res) {
  delete req.body.mid;
  if (schema.validate(req.body).error) return res.sendStatus(400);
  try {
    const result = await query(
      'INSERT INTO `metas` (`name`, `slug`, `type`) VALUES (?,?,"label")',
      [req.body.name, req.body.slug]
    );
    const result2 = await query(
      'SELECT `mid` FROM `metas` WHERE `name` = ? AND `slug` = ?',
      [req.body.name, req.body.slug]
    );
    res.send(result2[0]);
  } catch (e) {
    /* Already exist */
    if (e.errno === 1062) res.sendStatus(409);
    else res.sendStatus(500);
  }
}

async function editLabel(req, res) {
  const mid = req.body.mid;
  delete req.body.mid;
  if (schema.validate(req.body).error) return res.sendStatus(400);
  try {
    const result = await query(
      'UPDATE `metas` SET `name` = ?, `slug` = ? WHERE `mid` = ?',
      [req.body.name, req.body.slug, mid]
    );
    res.sendStatus(200);
  } catch (e) {
    /* Already exist */
    if (e.errno === 1062) res.sendStatus(409);
    else res.sendStatus(500);
  }
}

async function deleteLabel(req, res) {
  if (req.body.mid === 0) return res.sendStatus(400);
  try {
    const result = await query('DELETE FROM `metas` WHERE `mid` = ?', [
      req.body.mid,
    ]);
    res.sendStatus(200);
  } catch (e) {
    res.sendStatus(500);
  }
}

module.exports = { getLabels, addLabel, editLabel, deleteLabel };
