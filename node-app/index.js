const axios = require('axios');
const cheerio = require('cheerio');

const dotenv = require('dotenv');
const path = require('path');
const Joi = require('joi');

dotenv.config({ path: path.join(__dirname, '../../.env') });

const envVarsSchema = Joi.object()
  .keys({
    ENV_MODE: Joi.string().valid('production', 'development', 'test').required()
  })
  .unknown();

const { value: envVars, error } = envVarsSchema.prefs({ errors: { label: 'key' } }).validate(process.env);

const express = require('express'),
  app = express(),
  port = process.env.PORT || 3000;

const parsePost = (post) => {
  return post.replace(/(\n\t+)/gm, '').replace(/(\n\n)/gm, '\n');
}

const webscrape = async (count) => {
  const host = 'http://bash.org.pl/latest/';
  const ID_TAG = 'div.post';
  const POST_TAG = 'div.post-body';
  let page = 1;
  let posts = [];

  try {
    while (posts.length < count) {
      const response = await axios.get(`${host}?page=${page}`);
      const $ = cheerio.load(response.data);
      $(ID_TAG).each((i, prop) => {
        if (posts.length < count) {
          const itemId = $(prop).attr('id');
          const content = parsePost($(POST_TAG, prop).text());
          
          posts.push({
            id: itemId,
            content: content,
          });
        }
      });
      page++;
    }
  } catch (e) {
    console.log(`Error while fetching data from ${host} - ${e.message}`);
  }
  return posts;
}

app.get('/jokes', async (req, res) => {
  const DEFAULT_COUNT = 20;
  count = req.query.count !== undefined ? req.query.count : DEFAULT_COUNT;
  const posts = await webscrape(count);
  return res.send({
    data: posts,
  });
})

app.get('/', async (req, res) => {
  return res.send('Hello Backend! (' + envVars.ENV_MODE + ') : API endpoint is <a href="/jokes?count=100">here</a>.');
})

app.listen(port);
console.log('RESTful API server started on: ' + port);