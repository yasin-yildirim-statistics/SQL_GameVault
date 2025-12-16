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