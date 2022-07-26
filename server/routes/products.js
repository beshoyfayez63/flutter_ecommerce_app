const express = require('express');
const productRoutes = express.Router();

const auth = require('../middlewares/auth');
const { Product } = require('../models/product');

productRoutes.get('/api/products', auth, async (req, res) => {
  try {
    const { category } = req.query;
    console.log(category);
    const products = await Product.find({ category });
    return res.json(products);
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

productRoutes.get('/api/products/search/:name', async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: 'i' },
    });
    return res.json(products);
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

productRoutes.post('/api/rate-product', auth, async (req, res) => {
  try {
    const { id, rating } = req.body;
    console.log(id, rating);
    let product = await Product.findById(id);

    if (product.ratings.length) {
      for (let i = 0; product.ratings.length; i++) {
        if (product.ratings[i].userId === req.user) {
          product.ratings.splice(i, 1);
          break;
        }
      }
    }

    const ratingSchema = {
      userId: req.user,
      rating: +rating,
    };
    product.ratings.push(ratingSchema);
    product = await product.save();
    res.json(product);
  } catch (error) {
    console.log(error.message);
    res.status(500).json({ error: error.message });
  }
});

productRoutes.get('/api/deal-of-day', auth, async (req, res) => {
  try {
    let products = await Product.find({});

    products = products.sort((a, b) => {
      let aSum = 0;
      let bSum = 0;

      for (let i = 0; i < a.ratings.length; i++) {
        aSum += a.ratings[i].rating;
      }

      for (let i = 0; i < b.ratings.length; i++) {
        bSum += b.ratings[i].rating;
      }
      return aSum < bSum ? 1 : -1;
    });

    res.json(products[0]);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRoutes;
