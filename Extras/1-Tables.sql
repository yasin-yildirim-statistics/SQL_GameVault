-- 1. Developers (Geliştiriciler) Tablosu
CREATE TABLE developers (
    id SERIAL PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    founded_year INTEGER
);

-- 2. Games (Oyunlar) Tablosu
CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    price DECIMAL(10, 2),
    release_date DATE,
    rating DECIMAL(3, 1), -- Örn: 8.5
    developer_id INTEGER,
    -- Foreign Key Tanımlaması (One-to-Many)
    CONSTRAINT fk_developer
        FOREIGN KEY(developer_id)
        REFERENCES developers(id)
        ON DELETE SET NULL
);

-- 3. Genres (Türler) Tablosu
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

-- 4. Games_Genres (Ara Tablo - Many-to-Many)
CREATE TABLE games_genres (
    id SERIAL PRIMARY KEY,
    game_id INTEGER,
    genre_id INTEGER,
    -- Foreign Key Tanımlamaları
    CONSTRAINT fk_game
        FOREIGN KEY(game_id)
        REFERENCES games(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_genre
        FOREIGN KEY(genre_id)
        REFERENCES genres(id)
        ON DELETE CASCADE
);
