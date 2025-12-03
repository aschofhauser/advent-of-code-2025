<#
--- Part Two ---
The clerk quickly discovers that there are still invalid IDs in the ranges in your list. Maybe the young Elf was doing other silly patterns as well?

Now, an ID is invalid if it is made only of some sequence of digits repeated at least twice. So, 12341234 (1234 two times), 123123123 (123 three times), 1212121212 (12 five times), and 1111111 (1 seven times) are all invalid IDs.

From the same example as before:

11-22 still has two invalid IDs, 11 and 22.
95-115 now has two invalid IDs, 99 and 111.
998-1012 now has two invalid IDs, 999 and 1010.
1188511880-1188511890 still has one invalid ID, 1188511885.
222220-222224 still has one invalid ID, 222222.
1698522-1698528 still contains no invalid IDs.
446443-446449 still has one invalid ID, 446446.
38593856-38593862 still has one invalid ID, 38593859.
565653-565659 now has one invalid ID, 565656.
824824821-824824827 now has one invalid ID, 824824824.
2121212118-2121212124 now has one invalid ID, 2121212121.
Adding up all the invalid IDs in this example produces 4174379265.

What do you get if you add up all of the invalid IDs using these new rules?
#>

param (
    # Filepath containing the product ID ranges
    [Parameter(Mandatory)]
    [string]$Path
)

$Content = Get-Content -Path $Path

$Ranges = $Content -split ','

$InvalidCounter = 0
$InvalidSum = 0

foreach ($Range in $Ranges) {
    [decimal]$Min, [decimal]$Max = $Range -split '-'
    for ($id = $Min; $id -le $Max; $id++) {
        $IdString = $id.ToString()
        # Cut id in all possible lengths
        for ($parts = 2; $parts -le $IdString.Length; $parts++) {
            if ($IdString.Length % $parts -eq 0) {
                $IdSubstrings = for ($i = 0; $i -lt $parts; $i++) {
                    $IdString.Substring($i * $IdString.Length/$parts, $IdString.Length/$parts)
                }
                # Are all the array elements the same?
                if (@($IdSubstrings | Get-Unique).Count -eq 1) {
                    Write-Output "$IdString invalid"
                    $InvalidCounter++
                    $InvalidSum += $id
                    break # go to next id (to not count invalid ids more times)
                }
            }
        }
    }
}

Write-Output "Sum of invalid IDs: $InvalidSum"