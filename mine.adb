with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;

with Board; use Board;
with Cell;  use Cell;

procedure Mine is
    Board: Board_Type(14, 16);
    Input: Character;
    Running: Boolean := True;
    FirstOpen: Boolean := True;

    procedure ClearCLI is
       
    begin
        Put(ESC & "[2J");
    end ClearCLI;

begin

    while Running loop
        ClearCLI;
        Put(Board);

        Get_Immediate(Input);

        case Input is
            when 'q' => exit;
            when 'w' => BoardMoveCursor(Board, Up);
            when 'a' => BoardMoveCursor(Board, Left);
            when 's' => BoardMoveCursor(Board, Down);
            when 'd' => BoardMoveCursor(Board, Right);
            when 'f' => BoardPlaceFlag(Board);
            when ' ' =>
                if not CellIsFlagged(BoardGetCellAtCursor(Board)) then
                    
                    if FirstOpen then
                        BoardRandomize(Board);
                        FirstOpen := False;
                    end if;

                    BoardOpenAtCursor(Board);
                    

                    if CellIsMine(BoardGetCellAtCursor(Board)) then
                        BoardOpenAllCells(Board);
                        ClearCLI;

                        Put(Board);
                        Put_Line("YOU LOST!  Press (r) to RESTART or (q) to QUIT");

                        loop
                            Get_Immediate(Input);

                            case Input is
                                when 'q' => 
                                    Running := False;
                                    exit;
                                when 'r' => 
                                    BoardCloseAllCells(Board);
                                    FirstOpen := True;
                                    exit;
                                when others => null;
                            end case;
                        end loop;
                    
                    end if;
                end if;
            when others => null;
        end case;
    end loop;
end Mine;

