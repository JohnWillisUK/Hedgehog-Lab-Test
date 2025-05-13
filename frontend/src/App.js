import React, { useState, useEffect } from 'react';

const API_BASE = process.env.REACT_APP_API_BASE_URL;

function App() {
  const [item, setItem] = useState('');
  const [shoppingList, setShoppingList] = useState([]);
  const [backendStatus, setBackendStatus] = useState('Checking backend...');

  const addItem = async () => {
    if (!item.trim()) return;

    try {
      await fetch(`${API_BASE}/items`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ item }),
      });
      setItem('');
      fetchShoppingList();
    } catch (error) {
      console.error('Failed to add item:', error);
    }
  };

  const fetchShoppingList = async () => {
    try {
      const res = await fetch(`${API_BASE}/items`);
      const data = await res.json();
      setShoppingList(data.items || []);
    } catch (error) {
      console.error('Failed to fetch shopping list:', error);
    }
  };

  const checkBackendHealth = async () => {
    try {
      const res = await fetch(`${API_BASE}/healthz`);
      if (res.ok) {
        setBackendStatus('✅ Backend is healthy');
      } else {
        setBackendStatus('❌ Backend is unhealthy');
      }
    } catch (error) {
      setBackendStatus('❌ Backend is unreachable');
    }
  };

  useEffect(() => {
    checkBackendHealth();
    fetchShoppingList();
  }, []);

  return (
    <div className="app-container">
      <h1>🛒 Shopping List</h1>
      <p className="status">{backendStatus}</p>
      <div className="form">
        <input
          type="text"
          value={item}
          onChange={(e) => setItem(e.target.value)}
          placeholder="Enter an item"
        />
        <button onClick={addItem}>Add</button>
      </div>
      <h2>Your List</h2>
      <ul className="list">
        {shoppingList.map((entry, index) => (
          <li key={index}>{entry[1]}</li> {/* entry[1] assumes backend returns (id, item) */}
        ))}
      </ul>
    </div>
  );
}

export default App;
