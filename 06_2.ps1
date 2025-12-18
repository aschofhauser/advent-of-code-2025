<#
--- Part Two ---
The big cephalopods come back to check on how things are going. When they see that your grand total doesn't match the one expected by the worksheet, they realize they forgot to explain how to read cephalopod math.

Cephalopod math is written right-to-left in columns. Each number is given in its own column, with the most significant digit at the top and the least significant digit at the bottom. (Problems are still separated with a column consisting only of spaces, and the symbol at the bottom of the problem is still the operator to use.)

Here's the example worksheet again:

123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
Reading the problems right-to-left one column at a time, the problems are now quite different:

The rightmost problem is 4 + 431 + 623 = 1058
The second problem from the right is 175 * 581 * 32 = 3253600
The third problem from the right is 8 + 248 + 369 = 625
Finally, the leftmost problem is 356 * 24 * 1 = 8544
Now, the grand total is 1058 + 3253600 + 625 + 8544 = 3263827.

Solve the problems on the math worksheet again. What is the grand total found by adding together all of the answers to the individual problems?
#>

param (
    # Filepath containing the math worksheet
    [Parameter(Mandatory)]
    [string]$Path
)

$WorkSheet = Get-Content -Path $Path

$Operations = $WorkSheet[-1]

$Numbers = $WorkSheet[0..($WorkSheet.Count-2)]

$GrandTotal = 0

$ProblemNumbers = @()
for ($i=$Operations.Length-1; $i -ge 0; $i--) {
    $Number = ""
    foreach ($Line in $Numbers) {
        $n = $Line.Substring($i, 1)
        if ($n -notmatch '\s') {$Number += $n}
    }
    $ProblemNumbers += $Number
    if ($Operations[$i] -notmatch '\s') {
        $Problem = $ProblemNumbers -join "$($Operations[$i])"
        $Problem
        $GrandTotal += Invoke-Expression $Problem
        $i-- # Next column should be empty
        $ProblemNumbers = @()
    }
}

Write-Output "Grand total: $($GrandTotal)"
