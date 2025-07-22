SELECT *
FROM Rooms
WHERE (has_tv, has_internet, has_kitchen, has_air_con) IN (
		SELECT has_tv,
			has_internet,
			has_kitchen,
			has_air_con
		FROM Rooms
		WHERE id = 11
	)