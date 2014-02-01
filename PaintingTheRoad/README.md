# [Painting the road](http://www.hackerearth.com/problem/algorithm/painting-the-road/)

## Description
There is a kingdom, that has a long straight road of length L meters and width 0. Coordinate x on the road denotes point that is at x meters from the start of the road. That is coordinate 0 denotes beginning of the road and coordinate L denotes end of the road. The road has to be painted with color. There are K proposals, Each proposal is of the form a, b, c which means that the road can be painted from coordinate a to coordinate b for the cost c. Note that some part of road can be painted multiple times and it is still considered to be painted.

The king wants to know if the whole road can be painted and if possible, also wants to know the minimum cost that is required to paint the entire road.

## Input
First line of the input is the number of test cases T. It is followed by T test cases.In each test case first line has two space separated integers, the length of the road L and the number of proposals K. It is followed by K lines, which are K proposals, each proposal is 3 space separated integers a b and c.

## Output
For each test case output a single integer, that is minimum cost required to paint the enitre road. If it is impossible to paint the entire road, print -1.

## Constraints
1 <= T <= 10

1 <= L <= 256

1 <= K <= 512

0 <= a < b <= L

1 <= c <= 1000

## Strategy
I think the best bet is to go dynamic programming.
So crunch out an array where the the entry `arr[(i,j)]` will stand for the minimum cost of painting the road till length `j` if you only use the first `i` probosals.
For this to work it's important that the Proposals are sorted on the toCoord, as we start at roads end and work our way backwards, we can never revisit proposals further along the way once we rejected them - so we have to consider those first.