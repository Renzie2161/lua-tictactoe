local player1 = "X"
local player2 = "O"
local current_player = player1
local reason = ""
local failure = false
local endgame = false
local row
local col
local Board = {
    {" ", " ", " "},
    {" ", " ", " "},
    {" ", " ", " "}
}
local function printBoard()
    print("---|---|---")
    for i = 1, 3 do
        print(" " .. Board[i][1] .. " | " .. Board[i][2] .. " | " .. Board[i][3])
        print("---|---|---")
    end
end
local function CheckMove(row, col)
    if row < 1 or row > 3 then reason = "Please insert a number from 1 to 3" failure = true return false end
    if col < 1 or col > 3 then reason = "Please insert a number from 1 to 3" failure = true return false end
    if Board[row][col] ~= " " then reason = "Please choose an empty space" failure = true return false end
    return true
end
local function CheckWin(plr)
    for j = 1, 3 do
        if Board[j][1] == plr and Board[j][2] == plr and Board[j][3] == plr then return true end
        if Board[1][j] == plr and Board[2][j] == plr and Board[3][j] == plr then return true end
        if Board[1][1] == plr and Board[2][2] == plr and Board[3][3] == plr then return true end
        if Board[1][3] == plr and Board[2][2] == plr and Board[3][1] == plr then return true end
    end
    return false
end
local function CheckDraw()
    for j = 1, 3 do
        for k = 1, 3 do
            if Board[j][k] == " " then
                return false
            end
        end
    end
    return true
end
local function Move(plr, row, col)
    if CheckMove(row, col) then
        Board[row][col] = plr
        if CheckWin(plr) then
            printBoard()
            endgame = true
            print(current_player .. " wins!")
        end
        if CheckDraw() then
            printBoard()
            endgame = true
            print("It's a Draw!")
        end
        if current_player == player1 then
            current_player = player2
        else
            current_player = player1
        end
    end
end
local function Prompt()
    print(current_player .. " enter a row(1-3): ")
    row = tonumber(io.read())
    if row == nil then reason = "Please insert a number" failure = true return false end
    print(current_player .. " enter a column(1-3): ")
    col = tonumber(io.read())
    if col == nil then reason = "Please insert a number" failure = true return false end
    return true
end
while not endgame do

    printBoard()
    if failure then
        print(current_player .. ": " .. reason)
        failure = false
        reason = ""
    else
        print(current_player .. "'s turn!")
    end

    if Prompt() then
        Move(current_player, row, col)
    end

end