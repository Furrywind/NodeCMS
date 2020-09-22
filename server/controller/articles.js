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

async function getArticles(req, res) {
  try {
    const result = await query(
      'SELECT contents.cid, contents.title, UNIX_TIMESTAMP(contents.created) date, ' +
        'contents.status, metas.name category, users.nickname author FROM contents ' +
        'JOIN metas on metas.mid = contents.categoryId JOIN users on users.uid = contents.authorId'
    );
    res.send(result);
  } catch (e) {
    res.sendStatus(500);
  }
}

async function getArticle(req, res) {
  try {
    const result = await query(
      'SELECT contents.cid, contents.title, contents.slug, contents.content, ' +
        'contents.categoryId, UNIX_TIMESTAMP(contents.created) created, ' +
        'UNIX_TIMESTAMP(contents.modified) modified, contents.status, users.nickname author FROM ' +
        'contents JOIN users on users.uid = contents.authorId WHERE contents.cid = ?',
      [req.query.cid]
    );
    const result2 = await query(
      'SELECT relationships.mid, metas.name FROM relationships JOIN metas on ' +
        'metas.mid = relationships.mid WHERE relationships.cid = ?',
      [req.query.cid]
    );
    const result3 = await query(
      'SELECT `mid`, `name` FROM `metas` WHERE `type` = "category"'
    );
    const result4 = await query(
      'SELECT `mid`, `name` FROM `metas` WHERE `type` = "label"'
    );
    res.send([result[0], result2, result3, result4]);
  } catch (e) {
    res.sendStatus(500);
  }
}

async function addArticle(req, res) {
  if (schema.validate(req.body[0]).error) return res.sendStatus(400);
  try {
    const result = await query(
      'INSERT INTO `contents` (`title`, `slug`, `content`, `categoryId`, `authorId`, ' +
        '`status`) VALUES (?,?,?,?,?,?)',
      [
        req.body[0].title,
        req.body[0].slug,
        req.body[0].content,
        req.body[0].categoryId,
        req.data.uid,
        req.body[0].status,
      ]
    );
    const result2 = await query(
      'SELECT contents.cid, contents.title, contents.slug, contents.content, ' +
        'contents.categoryId, UNIX_TIMESTAMP(contents.created) created, ' +
        'UNIX_TIMESTAMP(contents.modified) modified, contents.status, users.nickname author FROM ' +
        'contents JOIN users on users.uid = contents.authorId WHERE contents.cid = ' +
        '(SELECT `cid` FROM `contents` WHERE `slug` = ?)',
      [req.body[0].slug]
    );
    if (req.body[1].length !== 0) {
      const valArr = req.body[1].map((item) => `(${result2[0].cid}, ${item})`);
      const result3 = await query(
        'INSERT INTO `relationships` (`cid`, `mid`) VALUES ' + valArr
      );
    }
    res.send(result2[0]);
  } catch (e) {
    /* Already exist */
    if (e.errno === 1062) res.sendStatus(409);
    else res.sendStatus(500);
  }
}

async function editArticle(req, res) {
  delete req.body[0].created;
  delete req.body[0].modified;
  delete req.body[0].author;
  if (schema.validate(req.body[0]).error) return res.sendStatus(400);
  try {
    const result = await query(
      'UPDATE `contents` SET `title` = ?, `slug` = ?, `content` = ?, `categoryId` = ?, ' +
        '`status` = ? WHERE `cid` = ?',
      [
        req.body[0].title,
        req.body[0].slug,
        req.body[0].content,
        req.body[0].categoryId,
        req.body[0].status,
        req.body[0].cid,
      ]
    );
    const result2 = await query(
      'DELETE FROM `relationships` WHERE `cid` = ?;',
      [req.body[0].cid]
    );
    if (req.body[1].length !== 0) {
      const valArr = req.body[1].map((item) => `(${req.body[0].cid}, ${item})`);
      const result3 = await query(
        'INSERT INTO `relationships` (`cid`, `mid`) VALUES ' + valArr
      );
    }
    res.sendStatus(200);
  } catch (e) {
    /* Already exist */
    if (e.errno === 1062) res.sendStatus(409);
    else res.sendStatus(500);
  }
}

async function deleteArticle(req, res) {
  try {
    const result = await query('DELETE FROM `contents` WHERE `cid` = ?', [
      req.body.cid,
    ]);
    res.sendStatus(200);
  } catch (e) {
    res.sendStatus(500);
  }
}

module.exports = {
  getArticles,
  getArticle,
  addArticle,
  editArticle,
  deleteArticle,
};
