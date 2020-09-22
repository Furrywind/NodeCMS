const express = require('express');
const router = express.Router();

const { authenticate, permission, checkRole } = require('../middleware/auth');

const {
  getDashboard,
  getSettings,
  editSettings,
} = require('../controller/settings');
const {
  getArticles,
  getArticle,
  addArticle,
  editArticle,
  deleteArticle,
} = require('../controller/articles');
const {
  getCategorys,
  addCategory,
  editCategory,
  deleteCategory,
} = require('../controller/categorys');
const {
  getLabels,
  addLabel,
  editLabel,
  deleteLabel,
} = require('../controller/labels');
const {
  login,
  getUsers,
  addUser,
  editUser,
  deleteUser,
} = require('../controller/users');

router.get('/getdashboard', authenticate, getDashboard);
router.get('/getsettings', authenticate, getSettings);
router.post('/editsettings', authenticate, editSettings);

router.get('/getarticles', authenticate, getArticles);
router.get('/getarticle', authenticate, getArticle);
router.post('/addarticle', authenticate, addArticle);
router.post('/editarticle', authenticate, editArticle);
router.post('/deletearticle', authenticate, deleteArticle);

router.get('/getcategorys', authenticate, getCategorys);
router.post('/addcategory', authenticate, addCategory);
router.post('/editcategory', authenticate, editCategory);
router.post('/deletecategory', authenticate, deleteCategory);

router.get('/getlabels', authenticate, getLabels);
router.post('/addlabel', authenticate, addLabel);
router.post('/editlabel', authenticate, editLabel);
router.post('/deletelabel', authenticate, deleteLabel);

router.post('/login', login);
router.get('/getusers', authenticate, permission, getUsers);
router.post('/adduser', authenticate, permission, addUser);
router.post('/edituser', authenticate, permission, checkRole, editUser);
router.post('/deleteuser', authenticate, permission, checkRole, deleteUser);

module.exports = router;
