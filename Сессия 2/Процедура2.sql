CREATE PROCEDURE deleteAbonent
	@id_abonent int
as
DELETE FROM Абоненты where id_абонента = @id_abonent;

exec deleteAbonent @id_abonent = 12;
