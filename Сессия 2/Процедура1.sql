CREATE PROCEDURE addAbonent3
	@id_abonent int,
	@name varchar(50),
	@surename varchar(50),
	@fathername varchar(50),
	@address varchar(50)
AS
INSERT INTO �������� (id_��������, ���, �������, ��������, �����) VALUES (@id_abonent, @name, @surename, @fathername, @address);

exec addAbonent3 @id_abonent = 27, @name = '������', @surename = '������', @fathername = '����������', @address = '�. ����, ��. ������, 5,24';