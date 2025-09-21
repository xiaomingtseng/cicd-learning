const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());

// Routes
app.get('/', (req, res) => {
  res.json({
    message: '歡迎使用 CI/CD 學習 API！',
    version: '1.0.0',
    status: 'running'
  });
});

app.get('/api/health', (req, res) => {
  res.json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime()
  });
});

app.get('/api/users', (req, res) => {
  res.json([
    { id: 1, name: '張三', role: 'developer' },
    { id: 2, name: '李四', role: 'designer' },
    { id: 3, name: '王五', role: 'tester' }
  ]);
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: '伺服器內部錯誤' });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({ error: '找不到該路徑' });
});

if (require.main === module) {
  app.listen(PORT, () => {
    console.log(`伺服器運行在 port ${PORT}`);
  });
}

module.exports = app;