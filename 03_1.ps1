<#
--- Day 3: Lobby ---
You descend a short staircase, enter the surprisingly vast lobby, and are quickly cleared by the security checkpoint. When you get to the main elevators, however, you discover that each one has a red light above it: they're all offline.

"Sorry about that," an Elf apologizes as she tinkers with a nearby control panel. "Some kind of electrical surge seems to have fried them. I'll try to get them online soon."

You explain your need to get further underground. "Well, you could at least take the escalator down to the printing department, not that you'd get much further than that without the elevators working. That is, you could if the escalator weren't also offline."

"But, don't worry! It's not fried; it just needs power. Maybe you can get it running while I keep working on the elevators."

There are batteries nearby that can supply emergency power to the escalator for just such an occasion. The batteries are each labeled with their joltage rating, a value from 1 to 9. You make a note of their joltage ratings (your puzzle input). For example:

987654321111111
811111111111119
234234234234278
818181911112111
The batteries are arranged into banks; each line of digits in your input corresponds to a single bank of batteries. Within each bank, you need to turn on exactly two batteries; the joltage that the bank produces is equal to the number formed by the digits on the batteries you've turned on. For example, if you have a bank like 12345 and you turn on batteries 2 and 4, the bank would produce 24 jolts. (You cannot rearrange batteries.)

You'll need to find the largest possible joltage each bank can produce. In the above example:

In 987654321111111, you can make the largest joltage possible, 98, by turning on the first two batteries.
In 811111111111119, you can make the largest joltage possible by turning on the batteries labeled 8 and 9, producing 89 jolts.
In 234234234234278, you can make 78 by turning on the last two batteries (marked 7 and 8).
In 818181911112111, the largest joltage you can produce is 92.
The total output joltage is the sum of the maximum joltage from each bank, so in this example, the total output joltage is 98 + 89 + 78 + 92 = 357.

There are many batteries in front of you. Find the maximum joltage possible from each bank; what is the total output joltage?
#>

param (
    # Filepath containing the battery joltage ratings
    [Parameter(Mandatory)]
    [string]$Path
)

$Batteries = Get-Content -Path $Path

$TotalJoltage = 0

foreach ($Bank in $Batteries) {
    # Make an array of numbers
    $BankArray = $Bank.ToCharArray() | Foreach-Object { [int]$_.ToString() }
    # Find the max value in the array except the last element
    $Battery1 = [int]($BankArray[0..($BankArray.Count-2)] | Measure-Object -Maximum).Maximum
    # Find the index of the max value
    $Battery1Index = $BankArray.IndexOf($Battery1)
    # Find the max value in the remaining part of the array
    $Battery2 = [int]($BankArray[($Battery1Index+1)..($BankArray.Count-1)] | Measure-Object -Maximum).Maximum
    Write-Output "$($Battery1) $($Battery2)"
    $TotalJoltage += 10 * $Battery1 + $Battery2
}

Write-Output "Total output joltage: $($TotalJoltage)"