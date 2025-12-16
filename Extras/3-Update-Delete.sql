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
