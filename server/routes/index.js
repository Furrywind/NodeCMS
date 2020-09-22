const express = require('express');
const router = express.Router();

const { getHome, getArticle } = require('../controller/front');

router.get('/gethome', getHome);
router.get('/getarticle', getArticle);

module.exports = router;
