program bubbleSort;

const numbersLength = 100;

procedure bubbleSort(var numbersList: Array of Integer);
var
	i, j, temporary: Integer;

begin
	for i := numbersLength downto 0 do
		for j := 0 to i - 1 do
			if numbersList[j] > numbersList[j + 1] then
				begin
					temporary := numbersList[j];
					numbersList[j] := numbersList[j + 1];
					numbersList[j + 1] := temporary;
				end;
end;

procedure generateRandomNumbers(var numbersList: Array of Integer);
var
	i: Integer;
begin
	Randomize;
	for i := 0 to Trunc(numbersLength/2) do numbersList[i] := Random(numbersLength)
end;

var
	numbersList: Array[0..numbersLength] of Integer;
	i: Integer;
begin
	generateRandomNumbers(numbersList);
	bubbleSort(numbersList);
	for i := Trunc(numbersLength/2) to numbersLength - 1 do Write(numbersList[i], ', ');
	WriteLn();
end.




