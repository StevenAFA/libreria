USE [TripAdvisor]
GO

/****** Object:  StoredProcedure [dbo].[InsertBooked]    Script Date: 6/3/2024 19:11:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spSaveBooked]
	@tripId INT,
	@email VARCHAR (50),
	@checkin DATETIME,
	@checkout DATETIME,
	@adults INT,
	@bookedHour VARCHAR (50),
	@total DECIMAL
AS
BEGIN
	INSERT INTO [dbo].[Booked] ([tripId],[email],[checkin],[checkout],[adults],[bookedHour],[total],[created])
	VALUES (@tripId, @email, @checkin, @checkout, @adults, @bookedHour, @total, GETDATE())
END
GO


