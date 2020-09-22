const { query } = require('../config/database');
const Joi = require('@hapi/joi');

/* Validate user input by using Joi */
const schema = Joi.object({
  name: Joi.string().min(1).max(16).required(),
  slug: Joi.string().alphanum().lowercase().min(1).max(16).required(),
  description: Joi.string().max(140),
});

async function getCategorys(req, res) {
  try {
    const result = await query(
      'SELECT `mid`, `name`, `slug`, `description`, (SELECT COUNT(categoryId) FROM contents ' +
        'WHERE categoryId = metas.mid) "count" FROM `metas` WHERE `type` = "category"'
    );
    res.send(result);
  } catch (e) {
    res.sendStatus(500);
  }
}

async function addCategory(req, res) {
  delete req.body.mid;
  delete req.body.count;
  if (req.body.description === null || req.body.description === '')
    delete req.body.description;
  if (schema.validate(req.body).error) return res.sendStatus(400);
  try {
    const result = await query(
      'INSERT INTO `metas` (`name`, `slug`, `description`, `type`) VALUES (?,?,?,"category")',
      [req.body.name, req.body.slug, req.body.description]
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

async function editCategory(req, res) {
  const mid = req.body.mid;
  delete req.body.mid;
  delete req.body.count;
  if (req.body.description === null || req.body.description === '')
    delete req.body.description;
  if (schema.validate(req.body).error) return res.sendStatus(400);
  try {
    const result = await query(
      'UPDATE `metas` SET `name` = ?, `slug` = ?, `description` = ? WHERE `mid` = ?',
      [req.body.name, req.body.slug, req.body.description, mid]
    );
    res.sendStatus(200);
  } catch (e) {
    /* Already exist */
    if (e.errno === 1062) res.sendStatus(409);
    else res.sendStatus(500);
  }
}

async function deleteCategory(req, res) {
  if (req.body.mid === 0) return res.sendStatus(400);
  try {
    const result = await query(
      'UPDATE `contents` SET `categoryId` = 0 WHERE `categoryId` = ?',
      [req.body.mid]
    );
    const result2 = await query('DELETE FROM `metas` WHERE `mid` = ?', [
      req.body.mid,
    ]);
    res.sendStatus(200);
  } catch (e) {
    res.sendStatus(500);
  }
}

module.exports = { getCategorys, addCategory, editCategory, deleteCategory };
