CREATE PROCEDURE addAbonent3
	@id_abonent int,
	@name varchar(50),
	@surename varchar(50),
	@fathername varchar(50),
	@address varchar(50)
AS
INSERT INTO Абоненты (id_абонента, Имя, Фамилия, Отчество, Адрес) VALUES (@id_abonent, @name, @surename, @fathername, @address);

exec addAbonent3 @id_abonent = 27, @name = 'Сергей', @surename = 'Аверин', @fathername = 'Викторович', @address = 'г. Омск, ул. Ленина, 5,24';