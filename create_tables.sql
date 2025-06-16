-- Подключение к базе данных mydb
\connect mydb

-- Создание таблицы users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    preferences TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы chefs
CREATE TABLE chefs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    bio TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы recipes
CREATE TABLE recipes (
    id SERIAL PRIMARY KEY,
    chef_id INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    ingredients TEXT NOT NULL,
    instructions TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (chef_id) REFERENCES chefs(id) ON DELETE CASCADE
);

-- Создание таблицы workshops
CREATE TABLE workshops (
    id SERIAL PRIMARY KEY,
    chef_id INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    date TIMESTAMP NOT NULL,
    video_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (chef_id) REFERENCES chefs(id) ON DELETE CASCADE
);

-- Создание таблицы subscriptions
CREATE TABLE subscriptions (
    user_id INTEGER NOT NULL,
    chef_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, chef_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (chef_id) REFERENCES chefs(id) ON DELETE CASCADE
);

-- Создание таблицы workshop_attendance
CREATE TABLE workshop_attendance (
    user_id INTEGER NOT NULL,
    workshop_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, workshop_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (workshop_id) REFERENCES workshops(id) ON DELETE CASCADE
);

-- Добавление комментариев
COMMENT ON TABLE users IS 'Таблица для хранения информации о пользователях платформы';
COMMENT ON TABLE chefs IS 'Таблица для хранения информации о кулинарных мастерах';
COMMENT ON TABLE recipes IS 'Таблица для хранения рецептов, созданных мастерами';
COMMENT ON TABLE workshops IS 'Таблица для хранения информации о мастер-классах';
COMMENT ON TABLE subscriptions IS 'Таблица для отслеживания подписок пользователей на мастеров';
COMMENT ON TABLE workshop_attendance IS 'Таблица для отслеживания участия пользователей в мастер-классах';

-- Тестовые данные
INSERT INTO users (name, email, preferences) VALUES
('John Doe', 'john@example.com', 'Italian cuisine'),
('Jane Smith', 'jane@example.com', 'Vegan cuisine');

INSERT INTO chefs (name, bio) VALUES
('Chef Gordon', 'Expert in Italian dishes'),
('Chef Anna', 'Specializes in vegan recipes');

INSERT INTO recipes (chef_id, title, ingredients, instructions) VALUES
(1, 'Spaghetti Carbonara', 'Pasta, eggs, cheese', 'Cook pasta, mix with eggs and cheese'),
(2, 'Vegan Salad', 'Lettuce, tomatoes, cucumber', 'Chop and mix ingredients');

INSERT INTO workshops (chef_id, title, date, video_url) VALUES
(1, 'Italian Pasta Masterclass', '2025-07-01 10:00:00', 'http://example.com/video1'),
(2, 'Vegan Cooking', '2025-07-02 12:00:00', 'http://example.com/video2');

INSERT INTO subscriptions (user_id, chef_id) VALUES
(1, 1),
(2, 2);

INSERT INTO workshop_attendance (user_id, workshop_id) VALUES
(1, 1),
(2, 2);
