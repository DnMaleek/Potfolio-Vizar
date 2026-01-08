const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');
const path = require('path');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

// Serve static files (css, js, images if any)
app.use(express.static(path.join(__dirname, 'public')));

// MySQL connection
const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
});

// ===== API ROUTES =====
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/projects', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'projects.html'));
});

app.get('/admin', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'admin_pannel.html'));
});


// ----- HERO -----
app.get('/api/hero', async (req, res) => {
  const [rows] = await db.query('SELECT * FROM hero LIMIT 1');
  res.json(rows[0]);
});

app.put('/api/hero', async (req, res) => {
  const { badge, title, subtitle, github_url } = req.body;
  await db.query('UPDATE hero SET badge=?, title=?, subtitle=?, github_url=? WHERE id=1', 
                 [badge, title, subtitle, github_url]);
  res.json({ message: 'Hero updated successfully' });
});

// ----- SKILLS -----
app.get('/api/skills', async (req, res) => {
  const [rows] = await db.query('SELECT * FROM skills');
  res.json(rows);
});

app.post('/api/skills', async (req, res) => {
  const { category, description } = req.body;
  await db.query('INSERT INTO skills (category, description) VALUES (?, ?)', [category, description]);
  res.json({ message: 'Skill added successfully' });
});

app.delete('/api/skills/:id', async (req, res) => {
  const { id } = req.params;
  await db.query('DELETE FROM skills WHERE id=?', [id]);
  res.json({ message: 'Skill deleted successfully' });
});

// ----- PROJECTS -----
app.get('/api/projects', async (req, res) => {
  const [rows] = await db.query('SELECT * FROM projects ORDER BY id DESC');
  res.json(rows);
});

app.get('/api/projects/:id', async (req, res) => {
  const [rows] = await db.query('SELECT * FROM projects WHERE id=?', [req.params.id]);
  res.json(rows[0]);
});

app.post('/api/projects', async (req, res) => {
  const { title, tech_stack, thumbnail_url, github_url, live_url, description } = req.body;
  await db.query(
    'INSERT INTO projects (title, tech_stack, thumbnail_url, github_url, live_url, description) VALUES (?, ?, ?, ?, ?, ?)',
    [title, tech_stack, thumbnail_url, github_url, live_url, description]
  );
  res.json({ message: 'Project added successfully' });
});

app.put('/api/projects/:id', async (req, res) => {
  const { title, tech_stack, thumbnail_url, github_url, live_url, description } = req.body;
  await db.query(
    'UPDATE projects SET title=?, tech_stack=?, thumbnail_url=?, github_url=?, live_url=?, description=? WHERE id=?',
    [title, tech_stack, thumbnail_url, github_url, live_url, description, req.params.id]
  );
  res.json({ message: 'Project updated successfully' });
});

app.delete('/api/projects/:id', async (req, res) => {
  await db.query('DELETE FROM projects WHERE id=?', [req.params.id]);
  res.json({ message: 'Project deleted successfully' });
});

// ----- CASE STUDIES -----
app.get('/api/cases', async (req, res) => {
  const [rows] = await db.query('SELECT * FROM case_studies');
  res.json(rows);
});

app.get('/api/cases/:id', async (req, res) => {
  const [rows] = await db.query('SELECT * FROM case_studies WHERE id=?', [req.params.id]);
  res.json(rows[0]);
});

app.post('/api/cases', async (req, res) => {
  const { project_id, problem, solution, tech_stack, challenges, outcome } = req.body;
  await db.query(
    'INSERT INTO case_studies (project_id, problem, solution, tech_stack, challenges, outcome) VALUES (?, ?, ?, ?, ?, ?)',
    [project_id, problem, solution, tech_stack, challenges, outcome]
  );
  res.json({ message: 'Case study added successfully' });
});

app.put('/api/cases/:id', async (req, res) => {
  const { project_id, problem, solution, tech_stack, challenges, outcome } = req.body;
  await db.query(
    'UPDATE case_studies SET project_id=?, problem=?, solution=?, tech_stack=?, challenges=?, outcome=? WHERE id=?',
    [project_id, problem, solution, tech_stack, challenges, outcome, req.params.id]
  );
  res.json({ message: 'Case study updated successfully' });
});

app.delete('/api/cases/:id', async (req, res) => {
  await db.query('DELETE FROM case_studies WHERE id=?', [req.params.id]);
  res.json({ message: 'Case study deleted successfully' });
});

// ===== SERVE HTML PAGES =====
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.get('/projects', (req, res) => {
  res.sendFile(path.join(__dirname, 'projects.html'));
});

app.get('/admin', (req, res) => {
  res.sendFile(path.join(__dirname, 'admin.html'));
});

// ----- EXPERIENCE -----
app.get('/api/experience', async (req, res) => {
  const [rows] = await db.query('SELECT * FROM experience');
  res.json(rows);
});

app.post('/api/experience', async (req, res) => {
  const { title, description } = req.body;
  await db.query('INSERT INTO experience (title, description) VALUES (?, ?)', [title, description]);
  res.json({ message: 'Experience added successfully' });
});

app.put('/api/experience/:id', async (req, res) => {
  const { title, description } = req.body;
  await db.query('UPDATE experience SET title=?, description=? WHERE id=?', [title, description, req.params.id]);
  res.json({ message: 'Experience updated successfully' });
});

app.delete('/api/experience/:id', async (req, res) => {
  await db.query('DELETE FROM experience WHERE id=?', [req.params.id]);
  res.json({ message: 'Experience deleted successfully' });
});

// ----- CONTACT -----
app.get('/api/contact', async (req, res) => {
  const [rows] = await db.query('SELECT * FROM contact LIMIT 1');
  res.json(rows[0]);
});

app.put('/api/contact', async (req, res) => {
  const { email, github_url } = req.body;
  await db.query('UPDATE contact SET email=?, github_url=? WHERE id=1', [email, github_url]);
  res.json({ message: 'Contact updated successfully' });
});


// ===== START SERVER =====
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port http://localhost:${PORT}`));
