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

INSERT INTO developers (company_name, country, founded_year)
VALUES
('CD Projekt Red', 'Poland', 1994),
('Rockstar Games', 'USA', 1998),
('Bethesda Game Studios', 'USA', 1986),
('Ubisoft', 'France', 1986),
('Capcom', 'Japan', 1979);

INSERT INTO genres (name, description)
VALUES
('RPG', 'Rol yapma oyunları; oyuncuların karakter gelişimine odaklandığı tür.'),
('Open World', 'Açık dünya; oyuncunun geniş bir haritada serbestçe dolaşabildiği tür.'),
('Horror', 'Korku; oyuncuyu germeyi ve korkutmayı amaçlayan tür.'),
('FPS', 'Birinci şahıs nişancı; karakterin gözünden oynanan aksiyon türü.'),
('Action-Adventure', 'Aksiyon-Macera; hem dövüş hem de bulmaca/hikaye unsurları içeren tür.');

-- Mevcut oyunları temizlemek istersen: TRUNCATE TABLE games CASCADE;

INSERT INTO games (title, price, release_date, rating, developer_id)
VALUES
('The Witcher 3: Wild Hunt', 29.99, '2015-05-19', 9.8, 1), -- CD Projekt Red
('Cyberpunk 2077', 59.99, '2020-12-10', 8.5, 1),          -- CD Projekt Red
('Grand Theft Auto V', 39.99, '2013-09-17', 9.5, 2),      -- Rockstar Games
('Red Dead Redemption 2', 59.99, '2018-10-26', 9.7, 2),   -- Rockstar Games
('The Elder Scrolls V: Skyrim', 39.99, '2011-11-11', 9.3, 3), -- Bethesda
('Starfield', 69.99, '2023-09-06', 7.5, 3),               -- Bethesda
('Assassin''s Creed Valhalla', 59.99, '2020-11-10', 8.0, 4), -- Ubisoft
('Far Cry 6', 49.99, '2021-10-07', 7.0, 4),               -- Ubisoft
('Resident Evil 4 REMAKE', 49.99, '2021-05-07', 9.3, 5),   -- Capcom (Yeni)
('Street Fighter 6', 59.99, '2023-06-02', 9.2, 5);        -- Capcom (Yeni)

INSERT INTO games_genres (game_id, genre_id)
VALUES
-- The Witcher 3 (Hem RPG hem Open World)
(1, 1), (1, 2),
-- Cyberpunk 2077 (RPG, Open World, FPS)
(2, 1), (2, 2), (2, 4),
-- Grand Theft Auto V (Open World, Action-Adventure)
(3, 2), (3, 5),
-- Red Dead Redemption 2 (Open World, Action-Adventure)
(4, 2), (4, 5),
-- Skyrim (RPG, Open World)
(5, 1), (5, 2),
-- Resident Evil 4 REMAKE (Horror, Action-Adventure)
(9, 3), (9, 5),
-- Street Fighter 6 (Action-Adventure - Not: Dövüş türü eklemediğimiz için en yakını bu)
(10, 5);

--1.	İndirim Zamanı: Tüm oyunların fiyatını %10 düşüren bir güncelleme sorgusu yazın.
UPDATE games SET price = price * 0.90;

SELECT
    title,
    price AS "Yeni Fiyat",
    (price / 0.90) AS "Eski Fiyat", -- İndirimden önceki hali
    ((price / 0.90) - price) AS "Yapılan İndirim"
FROM games;

--2.	Hata Düzeltme: Bir oyunun puanını (rating) güncelleyin (Örn: 8.5'i 9.0 yapın).
UPDATE games
SET rating = 9.0
WHERE title = 'Cyberpunk 2077';

UPDATE games
SET rating = 9.0
WHERE id = 2; -- Cyberpunk 2077'nin ID'si 2

--3.	Kaldırma: Veritabanından bir oyunu tamamen silin.
-- (Dikkat: İlişkili tablolarda hata almamak için önce ara tablodaki kaydı silmeniz gerekebilir veya CASCADE yapısını hatırlayın).

-- CASCADE yapısı zaten kullanıldığı için;
DELETE FROM games
WHERE title = 'Far Cry 6';

-- CASCADE yapısı kullanılmasaydı
-- Önce ara tablodaki ilişkileri temizle
DELETE FROM games_genres
WHERE game_id = (SELECT id FROM games WHERE title = 'Far Cry 6');

-- Sonra ana tablodan oyunu siliyoruz
DELETE FROM games
WHERE title = 'Far Cry 6';

-- 1.	Tüm Oyunlar Listesi: Oyunun adı, Fiyatı ve Geliştirici Firmanın Adını yan yana getirin (JOIN kullanın).
SELECT
    g.title AS "Oyun Adı",
    g.price AS "Fiyatı",
    d.company_name AS "Geliştirici Firma"
FROM games g
JOIN developers d ON g.developer_id = d.id;

-- 2.	Kategori Filtresi: Sadece "RPG" türündeki oyunların adını ve puanını listeleyin (Many-to-Many JOIN).

SELECT
    g.title AS "Oyun Adı",
    g.rating AS "Puanı"
FROM games g
JOIN games_genres gg ON g.id = gg.game_id
JOIN genres gn ON gg.genre_id = gn.id
WHERE gn.name = 'RPG';

-- yada id le yapabiliriz
SELECT g.title, g.rating
FROM games g
JOIN games_genres gg ON g.id = gg.game_id
WHERE gg.genre_id = 1;

--3.	Fiyat Analizi: Fiyatı 500 TL üzerinde olan oyunları pahalıdan ucuza doğru sıralayın.
SELECT
    title AS "Oyun Adı",
    price AS "Fiyat"
FROM games
WHERE price > 12 --500 tl yaklaşık 12 dolar
ORDER BY price DESC;

--4.	Arama: İçinde "War" kelimesi geçen oyunları bulun (LIKE).
SELECT
    title AS "Oyun Adı",
    price AS "Fiyatı",
    rating AS "Puanı"
FROM games
WHERE title LIKE '%War%';

--alternatif olarak
SELECT
    title AS "Oyun Adı",
    price AS "Fiyatı",
    rating AS "Puanı"
FROM games
WHERE title ilike '%evil%';