USE [TripAdvisor]
GO
/****** Object:  StoredProcedure [dbo].[spGetBooked]    Script Date: 4/10/2024 10:41:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spGetBooked]
	@email VARCHAR(50)
AS
BEGIN
	SELECT 
		bookedId,
		t.id tripId,
		t.name,
		t.photoPath,
		checkin,
		checkout,
		adults,
		bookedHour,
		total,
		created
	FROM [TripAdvisor].[dbo].[Booked] b
		INNER JOIN [dbo].[Trips] t
		ON b.tripId = t.id
	WHERE email = @email
END
