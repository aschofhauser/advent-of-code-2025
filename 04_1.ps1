<#
--- Day 4: Printing Department ---
You ride the escalator down to the printing department. They're clearly getting ready for Christmas; they have lots of large rolls of paper everywhere, and there's even a massive printer in the corner (to handle the really big print jobs).

Decorating here will be easy: they can make their own decorations. What you really need is a way to get further into the North Pole base while the elevators are offline.

"Actually, maybe we can help with that," one of the Elves replies when you ask for help. "We're pretty sure there's a cafeteria on the other side of the back wall. If we could break through the wall, you'd be able to keep moving. It's too bad all of our forklifts are so busy moving those big rolls of paper around."

If you can optimize the work the forklifts are doing, maybe they would have time to spare to break through the wall.

The rolls of paper (@) are arranged on a large grid; the Elves even have a helpful diagram (your puzzle input) indicating where everything is located.

For example:

..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
The forklifts can only access a roll of paper if there are fewer than four rolls of paper in the eight adjacent positions. If you can figure out which rolls of paper the forklifts can access, they'll spend less time looking and more time breaking down the wall to the cafeteria.

In this example, there are 13 rolls of paper that can be accessed by a forklift (marked with x):

..xx.xx@x.
x@@.@.@.@@
@@@@@.x.@@
@.@@@@..@.
x@.@@@@.@x
.@@@@@@@.@
.@.@.@.@@@
x.@@@.@@@@
.@@@@@@@@.
x.x.@@@.x.
Consider your complete diagram of the paper roll locations. How many rolls of paper can be accessed by a forklift?
#>

param (
    # Filepath containing the battery joltage ratings
    [Parameter(Mandatory)]
    [string]$Path
)

$Diagram = Get-Content -Path $Path

$AccessibleRollCount = 0

for ($y = 0; $y -lt $Diagram.Count; $y++) {
    for ($x = 0; $x -lt $Diagram[$y].Length; $x++) {
        $AdjacentRollCount = 0
        if ($Diagram[$y][$x] -eq '@') {
            for ($i = [math]::Max($y-1, 0); $i -le [math]::Min($y+1, $Diagram.Count-1); $i++) {
                for ($j = [math]::Max($x-1, 0); $j -le [math]::Min($x+1, $Diagram[$y].Length-1); $j++) {
                    if ($Diagram[$i][$j] -eq '@') {
                        $AdjacentRollCount++
                    }
                }
            }
        }
        if ($AdjacentRollCount -eq 0) { Write-Host "." -NoNewline }
        elseif ($AdjacentRollCount -le 4) { $AccessibleRollCount++; Write-Host "x" -NoNewline }
        else { Write-Host '@' -NoNewline }
    }
    Write-Host ''
}

Write-Output "$($AccessibleRollCount) rolls of paper can be accessed"
