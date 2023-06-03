# soko-pascal
uses GraphABC;

const
  EmptyCell = ' ';
  Wall = '#';
  Player = '@';
  Box = '$';
  Target = '.';

var
  level: array[1..5] of string =
    ('#####',
     '#   #',
     '# $ #',
     '#.@ #',
     '#####');
  playerX, playerY: integer;

procedure InitializeLevel;
var
  i, j: integer;
begin
  for i := 1 to Length(level) do
  begin
    for j := 1 to Length(level[i]) do
    begin
      if level[i][j] = Player then
      begin
        playerX := i;
        playerY := j;
        Exit;
      end;
    end;
  end;
end;

procedure DrawLevel;
var
  i: integer;
begin
  ClearWindow;
  for i := 1 to Length(level) do
  begin
    TextOut(0, 20 * (i - 1), level[i]);
  end;
end;

procedure ProcessInput(input: char);
var
  newX, newY: integer;
begin
  newX := playerX;
  newY := playerY;

  case input of
    'w': Dec(newX);
    's': Inc(newX);
    'a': Dec(newY);
    'd': Inc(newY);
  else
    Exit;
  end;

  if level[newX][newY] = EmptyCell then
  begin
    level[playerX][playerY] := EmptyCell;
    level[newX][newY] := Player;
    playerX := newX;
    playerY := newY;
  end
  else if level[newX][newY] = Box then
  begin
    var boxNewX := newX + (newX - playerX);
    var boxNewY := newY + (newY - playerY);

    if level[boxNewX][boxNewY] = EmptyCell then
    begin
      level[playerX][playerY] := EmptyCell;
      level[newX][newY] := Player;
      level[boxNewX][boxNewY] := Box;
      playerX := newX;
      playerY := newY;
    end;
  end;

  DrawLevel;
end;

begin
  InitializeLevel;
  DrawLevel;

  repeat
    ProcessInput(ReadKey);
  until False;
end.
