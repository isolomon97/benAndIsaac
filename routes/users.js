const express = require('express');
const {getUsers, getUser, createUser, updateUser, deleteUser} = require('../controllers/users');

const router = express.Router();



module.exports = router;