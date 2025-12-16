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
