-- Create Database
CREATE DATABASE IF NOT EXISTS portfolio;
USE portfolio;

-- ===== HERO =====
CREATE TABLE IF NOT EXISTS hero (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  subtitle TEXT,
  badge VARCHAR(100),
  github_url VARCHAR(255)   -- This is required for your backend
);

-- Insert default row for hero (so API GET works)
INSERT INTO hero (title, subtitle, badge, github_url)
VALUES ('Your Name', 'Full Stack Developer', 'Full Stack Developer', 'https://github.com/yourusername');

-- ===== SKILLS =====
CREATE TABLE IF NOT EXISTS skills (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(100) NOT NULL,
  description TEXT NOT NULL
);

-- ===== PROJECTS =====
CREATE TABLE IF NOT EXISTS projects (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  tech_stack TEXT NOT NULL,
  thumbnail_url VARCHAR(255) NOT NULL,
  github_url VARCHAR(255),
  live_url VARCHAR(255)
);

-- ===== CASE STUDIES =====
CREATE TABLE IF NOT EXISTS case_studies (
  id INT AUTO_INCREMENT PRIMARY KEY,
  project_id INT NOT NULL,
  problem TEXT NOT NULL,
  solution TEXT NOT NULL,
  tech_stack TEXT NOT NULL,
  challenges TEXT NOT NULL,
  outcome TEXT NOT NULL,
  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

INSERT INTO skills (category, description) VALUES
('Backend Development', 'Building scalable backend systems using Node.js, Express, and MySQL.'),
('Frontend Development', 'Creating responsive and dynamic UI using HTML, CSS, Tailwind, and JS.'),
('Databases', 'Designing and managing relational databases using MySQL.'),
('Networking', 'Fundamentals of networking, HTTP, TCP/IP, and network configuration.'),
('Version Control', 'Using Git and GitHub for source control and collaboration.');


INSERT INTO projects (title, description, tech_stack, thumbnail_url, github_url, live_url) VALUES
('Library Management System', 'A full-featured library management system with user authentication, book borrowing, and return functionalities.', 'Java, MySQL, JavaFX, JDBC', 'https://via.placeholder.com/300x200.png?text=Library+Project', 'https://github.com/your-github-username/library-management', '#'),
('Student Material Center', 'A web application for managing and sharing study materials with search and categorization features.', 'Node.js, MySQL, Tailwind CSS, HTML', 'https://via.placeholder.com/300x200.png?text=SMC+Project', 'https://github.com/your-github-username/student-material-center', '#'),
('Portfolio Website', 'Personal portfolio website showcasing projects, skills, and experience with a responsive design.', 'HTML, CSS, Tailwind CSS, JS', 'https://via.placeholder.com/300x200.png?text=Portfolio', 'https://github.com/your-github-username/portfolio', '#'),
('E-commerce Platform', 'A basic e-commerce platform with product listing, shopping cart, and checkout functionalities.', 'Node.js, Express, MySQL, Tailwind CSS', 'https://via.placeholder.com/300x200.png?text=E-commerce', 'https://github.com/your-github-username/e-commerce-platform', '#'),
('Blog Application', 'A simple blogging platform where users can create, edit, and delete posts.', 'Node.js, Express, MySQL, HTML, CSS', 'https://via.placeholder.com/300x200.png?text=Blog+App', 'https://github.com/your-github-username/blog-application', '#');


INSERT INTO case_studies (project_id, problem, solution, tech_stack, challenges, outcome) VALUES
(1, 'Manual library tracking was inefficient.', 'Developed a system for book management and borrowing/return tracking.', 'Java, MySQL, JavaFX', 'Integrating database with UI for real-time updates.', 'Reduced manual errors and streamlined library management.'),
(2, 'Students needed a centralized place for study materials.', 'Created a web platform for uploading, sharing, and categorizing materials.', 'Node.js, MySQL, Tailwind CSS', 'File management and categorization logic.', 'Improved access to study materials for students.'),
(3, 'No digital showcase for personal work.', 'Built a portfolio website to display projects, skills, and experience.', 'HTML, CSS, JS, Tailwind CSS', 'Responsive design across devices.', 'Professional online presence for potential clients and employers.'),
(4, 'E-commerce order management was manual.', 'Developed an online platform for product listing, cart, and checkout.', 'Node.js, Express, MySQL', 'Managing product inventory and transactions.', 'Streamlined online sales process for users.'),
(5, 'No simple blogging solution for sharing knowledge.', 'Created a web application for creating and managing blog posts.', 'Node.js, Express, MySQL', 'Implementing CRUD operations securely.', 'Users can easily share and manage blog posts.');

-- Experience Table
CREATE TABLE experience (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  description TEXT
);

-- Contact Table
CREATE TABLE contact (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255),
  github_url VARCHAR(255)
);

-- ===== ABOUT PAGE =====
CREATE TABLE IF NOT EXISTS about (
  id INT AUTO_INCREMENT PRIMARY KEY,
  story TEXT NOT NULL,
  what_i_do TEXT NOT NULL,
  years_learning VARCHAR(10) DEFAULT '2+',
  projects_built VARCHAR(10) DEFAULT '10+',
  technologies VARCHAR(10) DEFAULT '5+',
  learning_mode VARCHAR(10) DEFAULT '24/7'
);

-- Insert default about content
INSERT INTO about (story, what_i_do, years_learning, projects_built, technologies, learning_mode)
VALUES (
  'I''m a passionate full-stack developer based in Tanzania with a strong focus on backend development and systems architecture. My journey into tech started with a curiosity about how things work behind the scenes. What drives me is the challenge of building scalable, efficient systems that solve real-world problems. I believe in writing clean, maintainable code and constantly learning new technologies.',
  'Backend Development: Building robust APIs, database architecture, and server-side logic using Node.js, Express, and MySQL.|Full-Stack Projects: Creating end-to-end web applications with modern frameworks and best practices.|Problem Solving: Tackling complex challenges with efficient algorithms and scalable solutions.',
  '2+',
  '10+',
  '5+',
  '24/7'
);

-- Insert default values

INSERT INTO experience (title, description) VALUES
('Professional Practice & Continuous Learning', ''),
('Practical Learning', 'Backend systems, Android development, databases, networking fundamentals.');

INSERT INTO contact (email, github_url) VALUES
('your-email@example.com', 'https://github.com/NizariIddi');
