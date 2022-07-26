const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRoutes = require('./routes/products');
const userRouter = require('./routes/user');

const PORT = 3000;
const app = express();

app.use(express.json());
app.use(authRouter);
app.use(productRoutes);
app.use(adminRouter);
app.use(userRouter);

mongoose
  .connect(
    'mongodb+srv://beshoy:ujZlUI0aySup9cTS@cluster0.ow0ldjb.mongodb.net/flutter-amazone-clone?retryWrites=true&w=majority'
  )
  .then(() => {
    console.log('Connection Successful');
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, '192.168.1.4', () => {
  console.log('CONNECTED');
});
