import React from 'react';
import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <h1>CI/CD 學習專案</h1>
        <p>
          歡迎來到 CI/CD 學習平台！這個應用程式展示了完整的 DevOps 流程。
        </p>
        <a
          className="App-link"
          href="https://github.com/your-username/cicd-learning"
          target="_blank"
          rel="noopener noreferrer"
        >
          查看 GitHub Repository
        </a>
      </header>
    </div>
  );
}

export default App;