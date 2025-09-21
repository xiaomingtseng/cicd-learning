import React from 'react';
import { render, screen } from '@testing-library/react';
import App from './App';

test('renders learn react link', () => {
  render(<App />);
  const linkElement = screen.getByText(/CI\/CD 學習專案/i);
  expect(linkElement).toBeInTheDocument();
});

test('renders GitHub repository link', () => {
  render(<App />);
  const linkElement = screen.getByText(/查看 GitHub Repository/i);
  expect(linkElement).toBeInTheDocument();
});