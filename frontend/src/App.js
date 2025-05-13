import React, { useState, useEffect } from 'react';

const API_BASE = process.env.REACT_APP_API_BASE_URL;

function App() {
  const [name, setName] = useState('');
  const [results, setResults] = useState([]);

  const submitName = async () => {
    await fetch(`${API_BASE}/submit`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name }),
    });
    setName('');
    fetchResults();
  };

  const fetchResults = async () => {
    const res = await fetch(`${API_BASE}/results`);
    const data = await res.json();
    setResults(data.results);
  };

  useEffect(() => {
    fetchResults();
  }, []);

  return (
    <div>
      <h1>Submit Your Name</h1>
      <input value={name} onChange={(e) => setName(e.target.value)} />
      <button onClick={submitName}>Submit</button>
      <h2>Results</h2>
      <ul>
        {results.map((r, i) => <li key={i}>{r[1]}</li>)}
      </ul>
    </div>
  );
}

export default App;
