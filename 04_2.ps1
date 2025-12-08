<#
--- Part Two ---
Now, the Elves just need help accessing as much of the paper as they can.

Once a roll of paper can be accessed by a forklift, it can be removed. Once a roll of paper is removed, the forklifts might be able to access more rolls of paper, which they might also be able to remove. How many total rolls of paper could the Elves remove if they keep repeating this process?

Starting with the same example as above, here is one way you could remove as many rolls of paper as possible, using highlighted @ to indicate that a roll of paper is about to be removed, and using x to indicate that a roll of paper was just removed:

Initial state:
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

Remove 13 rolls of paper:
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

Remove 12 rolls of paper:
.......x..
.@@.x.x.@x
x@@@@...@@
x.@@@@..x.
.@.@@@@.x.
.x@@@@@@.x
.x.@.@.@@@
..@@@.@@@@
.x@@@@@@@.
....@@@...

Remove 7 rolls of paper:
..........
.x@.....x.
.@@@@...xx
..@@@@....
.x.@@@@...
..@@@@@@..
...@.@.@@x
..@@@.@@@@
..x@@@@@@.
....@@@...

Remove 5 rolls of paper:
..........
..x.......
.x@@@.....
..@@@@....
...@@@@...
..x@@@@@..
...@.@.@@.
..x@@.@@@x
...@@@@@@.
....@@@...

Remove 2 rolls of paper:
..........
..........
..x@@.....
..@@@@....
...@@@@...
...@@@@@..
...@.@.@@.
...@@.@@@.
...@@@@@x.
....@@@...

Remove 1 roll of paper:
..........
..........
...@@.....
..x@@@....
...@@@@...
...@@@@@..
...@.@.@@.
...@@.@@@.
...@@@@@..
....@@@...

Remove 1 roll of paper:
..........
..........
...x@.....
...@@@....
...@@@@...
...@@@@@..
...@.@.@@.
...@@.@@@.
...@@@@@..
....@@@...

Remove 1 roll of paper:
..........
..........
....x.....
...@@@....
...@@@@...
...@@@@@..
...@.@.@@.
...@@.@@@.
...@@@@@..
....@@@...

Remove 1 roll of paper:
..........
..........
..........
...x@@....
...@@@@...
...@@@@@..
...@.@.@@.
...@@.@@@.
...@@@@@..
....@@@...
Stop once no more rolls of paper are accessible by a forklift. In this example, a total of 43 rolls of paper can be removed.

Start with your original diagram. How many rolls of paper in total can be removed by the Elves and their forklifts?
#>

param (
    # Filepath containing the battery joltage ratings
    [Parameter(Mandatory)]
    [string]$Path
)

$Diagram = Get-Content -Path $Path

$TotalAccessibleRollCount = 0

do {
    $CurrentAccessibleRollCount = 0
    for ($y = 0; $y -lt $Diagram.Count; $y++) {
        for ($x = 0; $x -lt $Diagram[$y].Length; $x++) {
            $AdjacentRollCount = 0
            if ($Diagram[$y][$x] -eq '@') {
                for ($i = [math]::Max($y-1, 0); $i -le [math]::Min($y+1, $Diagram.Count-1); $i++) {
                    for ($j = [math]::Max($x-1, 0); $j -le [math]::Min($x+1, $Diagram[$y].Length-1); $j++) {
                        if ($Diagram[$i][$j] -eq '@' -or $Diagram[$i][$j] -eq 'x') {
                            $AdjacentRollCount++
                        }
                    }
                }
            }
            if ($AdjacentRollCount -eq 0) {
                #Write-Host "." -NoNewline
            }
            elseif ($AdjacentRollCount -le 4) {
                $CurrentAccessibleRollCount++
                $Diagram[$y] = $Diagram[$y].Remove($x,1).Insert($x,'x')
                #Write-Host "x" -NoNewline
            }
            else {
                #Write-Host '@' -NoNewline
            }
        }
        #Write-Host ''
    }
    $TotalAccessibleRollCount += $CurrentAccessibleRollCount
    Write-Output "$($CurrentAccessibleRollCount) rolls of paper can be removed"
    # Remove rolls
    for ($y = 0; $y -lt $Diagram.Count; $y++) {
        for ($x = 0; $x -lt $Diagram[$y].Length; $x++) {
            if ($Diagram[$y][$x] -eq 'x') {
                $Diagram[$y] = $Diagram[$y].Remove($x,1).Insert($x,'.')
            }
        }
    }
}
while ($CurrentAccessibleRollCount -gt 0)

Write-Output "$($TotalAccessibleRollCount) rolls of paper can be removed in total"
