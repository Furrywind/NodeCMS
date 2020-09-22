const { query } = require('../config/database');

async function getHome(req, res) {
  try {
    const result = await query(
      'SELECT contents.slug, contents.title, contents.created date, metas.name category, ' +
        'users.nickname author FROM contents JOIN metas on metas.mid = contents.categoryId ' +
        'JOIN users on users.uid = contents.authorId order by created DESC LIMIT 0,10'
    );
    const result2 = await query(
      'SELECT `name`, `slug` FROM `metas` WHERE `type` = "category" LIMIT 0,20'
    );
    res.send([result, result2]);
  } catch (e) {
    res.sendStatus(500);
  }
}

async function getArticle(req, res) {
  try {
    const result = await query(
      'SELECT contents.title, contents.content, contents.created date, metas.name category, ' +
        'users.nickname author FROM contents JOIN metas on metas.mid = contents.categoryId ' +
        'JOIN users on users.uid = contents.authorId WHERE contents.slug = ?',
      [req.query.slug]
    );
    res.send(result[0]);
  } catch (e) {
    res.sendStatus(500);
  }
}

module.exports = {
  getHome,
  getArticle,
};
