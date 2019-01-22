module.exports.controller = (app) => {
  app.get('/service-status', (req, res) => {
    res.send('All Good');
  });
};
