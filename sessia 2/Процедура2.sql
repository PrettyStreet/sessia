CREATE PROCEDURE deleteAbonent
	@id_abonent int
as
DELETE FROM �������� where id_�������� = @id_abonent;

exec deleteAbonent @id_abonent = 12;
