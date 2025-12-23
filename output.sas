begin_version
3
end_version
begin_metric
1
end_metric
38
begin_variable
var0
-1
2
Atom estus-unlocked(e2)
NegatedAtom estus-unlocked(e2)
end_variable
begin_variable
var1
-1
2
Atom estus-unlocked(e3)
NegatedAtom estus-unlocked(e3)
end_variable
begin_variable
var2
-1
2
Atom last-rested-bonfire(firelink)
NegatedAtom last-rested-bonfire(firelink)
end_variable
begin_variable
var3
-1
2
Atom last-rested-bonfire(mid-camp)
NegatedAtom last-rested-bonfire(mid-camp)
end_variable
begin_variable
var4
-1
2
Atom has-active-boss(boss-lair)
NegatedAtom has-active-boss(boss-lair)
end_variable
begin_variable
var5
-1
2
Atom player-current-level(pl0)
Atom player-current-level(pl1)
end_variable
begin_variable
var6
-1
2
Atom player-max-hp(hp2)
Atom player-max-hp(hp3)
end_variable
begin_variable
var7
-1
2
Atom player-dead()
NegatedAtom player-dead()
end_variable
begin_variable
var8
-1
2
Atom at-player(firelink)
NegatedAtom at-player(firelink)
end_variable
begin_variable
var9
-1
2
Atom at-player(long-road)
NegatedAtom at-player(long-road)
end_variable
begin_variable
var10
-1
2
Atom at-player(boss-lair)
NegatedAtom at-player(boss-lair)
end_variable
begin_variable
var11
-1
2
Atom at-player(mid-camp)
NegatedAtom at-player(mid-camp)
end_variable
begin_variable
var12
-1
2
Atom estus-full(e1)
NegatedAtom estus-full(e1)
end_variable
begin_variable
var13
-1
2
Atom estus-full(e2)
NegatedAtom estus-full(e2)
end_variable
begin_variable
var14
-1
2
Atom estus-full(e3)
NegatedAtom estus-full(e3)
end_variable
begin_variable
var15
-1
2
Atom player-souls(s0)
NegatedAtom player-souls(s0)
end_variable
begin_variable
var16
-1
2
Atom player-souls(s6)
NegatedAtom player-souls(s6)
end_variable
begin_variable
var17
-1
2
Atom is-alive(mob1)
NegatedAtom is-alive(mob1)
end_variable
begin_variable
var18
-1
2
Atom weakened(mob1)
NegatedAtom weakened(mob1)
end_variable
begin_variable
var19
-1
2
Atom player-souls(s1)
NegatedAtom player-souls(s1)
end_variable
begin_variable
var20
-1
2
Atom player-souls(s2)
NegatedAtom player-souls(s2)
end_variable
begin_variable
var21
-1
2
Atom is-alive(mob2)
NegatedAtom is-alive(mob2)
end_variable
begin_variable
var22
-1
2
Atom weakened(mob2)
NegatedAtom weakened(mob2)
end_variable
begin_variable
var23
-1
2
Atom player-souls(s3)
NegatedAtom player-souls(s3)
end_variable
begin_variable
var24
-1
2
Atom player-souls(s4)
NegatedAtom player-souls(s4)
end_variable
begin_variable
var25
-1
2
Atom player-souls(s5)
NegatedAtom player-souls(s5)
end_variable
begin_variable
var26
-1
2
Atom is-alive(mob3)
NegatedAtom is-alive(mob3)
end_variable
begin_variable
var27
-1
2
Atom weakened(mob3)
NegatedAtom weakened(mob3)
end_variable
begin_variable
var28
-1
2
Atom player-hp(hp0)
NegatedAtom player-hp(hp0)
end_variable
begin_variable
var29
-1
2
Atom player-hp(hp1)
NegatedAtom player-hp(hp1)
end_variable
begin_variable
var30
-1
2
Atom player-hp(hp2)
NegatedAtom player-hp(hp2)
end_variable
begin_variable
var31
-1
2
Atom player-hp(hp3)
NegatedAtom player-hp(hp3)
end_variable
begin_variable
var32
-1
2
Atom boss-current-phase(lair-boss, bp2)
NegatedAtom boss-current-phase(lair-boss, bp2)
end_variable
begin_variable
var33
-1
2
Atom boss-current-phase(lair-boss, bp0)
NegatedAtom boss-current-phase(lair-boss, bp0)
end_variable
begin_variable
var34
-1
2
Atom boss-current-phase(lair-boss, bp1)
NegatedAtom boss-current-phase(lair-boss, bp1)
end_variable
begin_variable
var35
-1
2
Atom is-alive(lair-boss)
NegatedAtom is-alive(lair-boss)
end_variable
begin_variable
var36
-1
2
Atom has-boss-soul(lair-boss)
NegatedAtom has-boss-soul(lair-boss)
end_variable
begin_variable
var37
-1
2
Atom deposited-soul(lair-boss)
NegatedAtom deposited-soul(lair-boss)
end_variable
0
begin_state
1
1
0
1
0
0
0
1
0
1
1
1
0
1
1
0
1
0
1
1
1
0
1
1
1
1
0
1
1
1
0
1
0
1
1
0
1
1
end_state
begin_goal
2
35 1
37 0
end_goal
103
begin_operator
attack-boss lair-boss boss-lair hp1 hp0 bp1 bp0
2
10 0
35 0
5
0 33 -1 0
0 34 0 1
0 7 1 0
0 28 -1 0
0 29 0 1
5
end_operator
begin_operator
attack-boss lair-boss boss-lair hp1 hp0 bp2 bp1
2
10 0
35 0
5
0 34 -1 0
0 32 0 1
0 7 1 0
0 28 -1 0
0 29 0 1
5
end_operator
begin_operator
attack-boss lair-boss boss-lair hp2 hp1 bp1 bp0
3
10 0
35 0
7 1
4
0 33 -1 0
0 34 0 1
0 29 -1 0
0 30 0 1
5
end_operator
begin_operator
attack-boss lair-boss boss-lair hp2 hp1 bp2 bp1
3
10 0
35 0
7 1
4
0 34 -1 0
0 32 0 1
0 29 -1 0
0 30 0 1
5
end_operator
begin_operator
attack-boss lair-boss boss-lair hp3 hp2 bp1 bp0
3
10 0
35 0
7 1
4
0 33 -1 0
0 34 0 1
0 30 -1 0
0 31 0 1
5
end_operator
begin_operator
attack-boss lair-boss boss-lair hp3 hp2 bp2 bp1
3
10 0
35 0
7 1
4
0 34 -1 0
0 32 0 1
0 30 -1 0
0 31 0 1
5
end_operator
begin_operator
attack-minor mob1 long-road hp1 hp0
2
9 0
17 0
4
0 7 1 0
0 28 -1 0
0 29 0 1
0 18 1 0
5
end_operator
begin_operator
attack-minor mob1 long-road hp2 hp1
3
9 0
17 0
7 1
3
0 29 -1 0
0 30 0 1
0 18 1 0
5
end_operator
begin_operator
attack-minor mob1 long-road hp3 hp2
3
9 0
17 0
7 1
3
0 30 -1 0
0 31 0 1
0 18 1 0
5
end_operator
begin_operator
attack-minor mob2 mid-camp hp1 hp0
2
11 0
21 0
4
0 7 1 0
0 28 -1 0
0 29 0 1
0 22 1 0
5
end_operator
begin_operator
attack-minor mob2 mid-camp hp2 hp1
3
11 0
21 0
7 1
3
0 29 -1 0
0 30 0 1
0 22 1 0
5
end_operator
begin_operator
attack-minor mob2 mid-camp hp3 hp2
3
11 0
21 0
7 1
3
0 30 -1 0
0 31 0 1
0 22 1 0
5
end_operator
begin_operator
attack-minor mob3 mid-camp hp1 hp0
2
11 0
26 0
4
0 7 1 0
0 28 -1 0
0 29 0 1
0 27 1 0
5
end_operator
begin_operator
attack-minor mob3 mid-camp hp2 hp1
3
11 0
26 0
7 1
3
0 29 -1 0
0 30 0 1
0 27 1 0
5
end_operator
begin_operator
attack-minor mob3 mid-camp hp3 hp2
3
11 0
26 0
7 1
3
0 30 -1 0
0 31 0 1
0 27 1 0
5
end_operator
begin_operator
deposit-soul lair-boss firelink
2
8 0
7 1
2
0 37 -1 0
0 36 0 1
10
end_operator
begin_operator
drink-estus e1 hp0 hp1 hp2
2
7 1
6 0
3
0 12 0 1
0 28 0 1
0 29 -1 0
5
end_operator
begin_operator
drink-estus e1 hp0 hp1 hp3
2
7 1
6 1
3
0 12 0 1
0 28 0 1
0 29 -1 0
5
end_operator
begin_operator
drink-estus e1 hp1 hp2 hp2
2
7 1
6 0
3
0 12 0 1
0 29 0 1
0 30 -1 0
5
end_operator
begin_operator
drink-estus e1 hp1 hp2 hp3
2
7 1
6 1
3
0 12 0 1
0 29 0 1
0 30 -1 0
5
end_operator
begin_operator
drink-estus e1 hp2 hp3 hp3
2
7 1
6 1
3
0 12 0 1
0 30 0 1
0 31 -1 0
5
end_operator
begin_operator
drink-estus e2 hp0 hp1 hp2
3
0 0
7 1
6 0
3
0 13 0 1
0 28 0 1
0 29 -1 0
5
end_operator
begin_operator
drink-estus e2 hp0 hp1 hp3
3
0 0
7 1
6 1
3
0 13 0 1
0 28 0 1
0 29 -1 0
5
end_operator
begin_operator
drink-estus e2 hp1 hp2 hp2
3
0 0
7 1
6 0
3
0 13 0 1
0 29 0 1
0 30 -1 0
5
end_operator
begin_operator
drink-estus e2 hp1 hp2 hp3
3
0 0
7 1
6 1
3
0 13 0 1
0 29 0 1
0 30 -1 0
5
end_operator
begin_operator
drink-estus e2 hp2 hp3 hp3
3
0 0
7 1
6 1
3
0 13 0 1
0 30 0 1
0 31 -1 0
5
end_operator
begin_operator
drink-estus e3 hp0 hp1 hp2
3
1 0
7 1
6 0
3
0 14 0 1
0 28 0 1
0 29 -1 0
5
end_operator
begin_operator
drink-estus e3 hp0 hp1 hp3
3
1 0
7 1
6 1
3
0 14 0 1
0 28 0 1
0 29 -1 0
5
end_operator
begin_operator
drink-estus e3 hp1 hp2 hp2
3
1 0
7 1
6 0
3
0 14 0 1
0 29 0 1
0 30 -1 0
5
end_operator
begin_operator
drink-estus e3 hp1 hp2 hp3
3
1 0
7 1
6 1
3
0 14 0 1
0 29 0 1
0 30 -1 0
5
end_operator
begin_operator
drink-estus e3 hp2 hp3 hp3
3
1 0
7 1
6 1
3
0 14 0 1
0 30 0 1
0 31 -1 0
5
end_operator
begin_operator
execute-enemy mob1 long-road s0 s1
2
9 0
7 1
4
0 17 0 1
0 15 0 1
0 19 -1 0
0 18 0 1
2
end_operator
begin_operator
execute-enemy mob1 long-road s1 s2
2
9 0
7 1
4
0 17 0 1
0 19 0 1
0 20 -1 0
0 18 0 1
2
end_operator
begin_operator
execute-enemy mob1 long-road s2 s3
2
9 0
7 1
4
0 17 0 1
0 20 0 1
0 23 -1 0
0 18 0 1
2
end_operator
begin_operator
execute-enemy mob1 long-road s3 s4
2
9 0
7 1
4
0 17 0 1
0 23 0 1
0 24 -1 0
0 18 0 1
2
end_operator
begin_operator
execute-enemy mob1 long-road s4 s5
2
9 0
7 1
4
0 17 0 1
0 24 0 1
0 25 -1 0
0 18 0 1
2
end_operator
begin_operator
execute-enemy mob1 long-road s5 s6
2
9 0
7 1
4
0 17 0 1
0 25 0 1
0 16 -1 0
0 18 0 1
2
end_operator
begin_operator
execute-enemy mob1 long-road s6 s6
3
9 0
7 1
16 0
2
0 17 0 1
0 18 0 1
2
end_operator
begin_operator
execute-enemy mob2 mid-camp s0 s1
2
11 0
7 1
4
0 21 0 1
0 15 0 1
0 19 -1 0
0 22 0 1
2
end_operator
begin_operator
execute-enemy mob2 mid-camp s1 s2
2
11 0
7 1
4
0 21 0 1
0 19 0 1
0 20 -1 0
0 22 0 1
2
end_operator
begin_operator
execute-enemy mob2 mid-camp s2 s3
2
11 0
7 1
4
0 21 0 1
0 20 0 1
0 23 -1 0
0 22 0 1
2
end_operator
begin_operator
execute-enemy mob2 mid-camp s3 s4
2
11 0
7 1
4
0 21 0 1
0 23 0 1
0 24 -1 0
0 22 0 1
2
end_operator
begin_operator
execute-enemy mob2 mid-camp s4 s5
2
11 0
7 1
4
0 21 0 1
0 24 0 1
0 25 -1 0
0 22 0 1
2
end_operator
begin_operator
execute-enemy mob2 mid-camp s5 s6
2
11 0
7 1
4
0 21 0 1
0 25 0 1
0 16 -1 0
0 22 0 1
2
end_operator
begin_operator
execute-enemy mob2 mid-camp s6 s6
3
11 0
7 1
16 0
2
0 21 0 1
0 22 0 1
2
end_operator
begin_operator
execute-enemy mob3 mid-camp s0 s1
2
11 0
7 1
4
0 26 0 1
0 15 0 1
0 19 -1 0
0 27 0 1
2
end_operator
begin_operator
execute-enemy mob3 mid-camp s1 s2
2
11 0
7 1
4
0 26 0 1
0 19 0 1
0 20 -1 0
0 27 0 1
2
end_operator
begin_operator
execute-enemy mob3 mid-camp s2 s3
2
11 0
7 1
4
0 26 0 1
0 20 0 1
0 23 -1 0
0 27 0 1
2
end_operator
begin_operator
execute-enemy mob3 mid-camp s3 s4
2
11 0
7 1
4
0 26 0 1
0 23 0 1
0 24 -1 0
0 27 0 1
2
end_operator
begin_operator
execute-enemy mob3 mid-camp s4 s5
2
11 0
7 1
4
0 26 0 1
0 24 0 1
0 25 -1 0
0 27 0 1
2
end_operator
begin_operator
execute-enemy mob3 mid-camp s5 s6
2
11 0
7 1
4
0 26 0 1
0 25 0 1
0 16 -1 0
0 27 0 1
2
end_operator
begin_operator
execute-enemy mob3 mid-camp s6 s6
3
11 0
7 1
16 0
2
0 26 0 1
0 27 0 1
2
end_operator
begin_operator
flee-boss boss-lair mid-camp lair-boss bp2
3
4 0
35 0
7 1
5
0 10 0 1
0 11 -1 0
0 33 -1 1
0 34 -1 1
0 32 -1 0
20
end_operator
begin_operator
kill-boss lair-boss boss-lair w1 e2 bp0
2
10 0
7 1
8
0 33 0 1
0 34 -1 1
0 32 -1 1
0 13 -1 0
0 0 1 0
0 4 -1 1
0 36 -1 0
0 35 0 1
100
end_operator
begin_operator
kill-boss lair-boss boss-lair w1 e3 bp0
2
10 0
7 1
8
0 33 0 1
0 34 -1 1
0 32 -1 1
0 14 -1 0
0 1 1 0
0 4 -1 1
0 36 -1 0
0 35 0 1
100
end_operator
begin_operator
level-up-stats firelink pl0 pl1 hp2 hp3 s1 s0
2
8 0
7 1
11
0 5 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
1 28 0 31 -1 0
1 29 0 31 -1 0
1 30 0 31 -1 0
1 31 0 31 -1 0
0 6 0 1
0 15 -1 0
0 19 0 1
10
end_operator
begin_operator
level-up-stats firelink pl0 pl1 hp2 hp3 s2 s1
2
8 0
7 1
11
0 5 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
1 28 0 31 -1 0
1 29 0 31 -1 0
1 30 0 31 -1 0
1 31 0 31 -1 0
0 6 0 1
0 19 -1 0
0 20 0 1
10
end_operator
begin_operator
level-up-stats firelink pl0 pl1 hp2 hp3 s3 s2
2
8 0
7 1
11
0 5 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
1 28 0 31 -1 0
1 29 0 31 -1 0
1 30 0 31 -1 0
1 31 0 31 -1 0
0 6 0 1
0 20 -1 0
0 23 0 1
10
end_operator
begin_operator
level-up-stats firelink pl0 pl1 hp2 hp3 s4 s3
2
8 0
7 1
11
0 5 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
1 28 0 31 -1 0
1 29 0 31 -1 0
1 30 0 31 -1 0
1 31 0 31 -1 0
0 6 0 1
0 23 -1 0
0 24 0 1
10
end_operator
begin_operator
level-up-stats firelink pl0 pl1 hp2 hp3 s5 s4
2
8 0
7 1
11
0 5 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
1 28 0 31 -1 0
1 29 0 31 -1 0
1 30 0 31 -1 0
1 31 0 31 -1 0
0 6 0 1
0 24 -1 0
0 25 0 1
10
end_operator
begin_operator
level-up-stats firelink pl0 pl1 hp2 hp3 s6 s5
2
8 0
7 1
11
0 5 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
1 28 0 31 -1 0
1 29 0 31 -1 0
1 30 0 31 -1 0
1 31 0 31 -1 0
0 6 0 1
0 25 -1 0
0 16 0 1
10
end_operator
begin_operator
level-up-stats mid-camp pl0 pl1 hp2 hp3 s1 s0
2
11 0
7 1
11
0 5 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
1 28 0 31 -1 0
1 29 0 31 -1 0
1 30 0 31 -1 0
1 31 0 31 -1 0
0 6 0 1
0 15 -1 0
0 19 0 1
10
end_operator
begin_operator
level-up-stats mid-camp pl0 pl1 hp2 hp3 s2 s1
2
11 0
7 1
11
0 5 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
1 28 0 31 -1 0
1 29 0 31 -1 0
1 30 0 31 -1 0
1 31 0 31 -1 0
0 6 0 1
0 19 -1 0
0 20 0 1
10
end_operator
begin_operator
level-up-stats mid-camp pl0 pl1 hp2 hp3 s3 s2
2
11 0
7 1
11
0 5 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
1 28 0 31 -1 0
1 29 0 31 -1 0
1 30 0 31 -1 0
1 31 0 31 -1 0
0 6 0 1
0 20 -1 0
0 23 0 1
10
end_operator
begin_operator
level-up-stats mid-camp pl0 pl1 hp2 hp3 s4 s3
2
11 0
7 1
11
0 5 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
1 28 0 31 -1 0
1 29 0 31 -1 0
1 30 0 31 -1 0
1 31 0 31 -1 0
0 6 0 1
0 23 -1 0
0 24 0 1
10
end_operator
begin_operator
level-up-stats mid-camp pl0 pl1 hp2 hp3 s5 s4
2
11 0
7 1
11
0 5 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
1 28 0 31 -1 0
1 29 0 31 -1 0
1 30 0 31 -1 0
1 31 0 31 -1 0
0 6 0 1
0 24 -1 0
0 25 0 1
10
end_operator
begin_operator
level-up-stats mid-camp pl0 pl1 hp2 hp3 s6 s5
2
11 0
7 1
11
0 5 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
1 28 0 31 -1 0
1 29 0 31 -1 0
1 30 0 31 -1 0
1 31 0 31 -1 0
0 6 0 1
0 25 -1 0
0 16 0 1
10
end_operator
begin_operator
move boss-lair mid-camp
2
4 1
7 1
2
0 10 0 1
0 11 -1 0
10
end_operator
begin_operator
move firelink long-road
1
7 1
2
0 8 0 1
0 9 -1 0
10
end_operator
begin_operator
move long-road firelink
1
7 1
2
0 8 -1 0
0 9 0 1
10
end_operator
begin_operator
move long-road mid-camp
1
7 1
2
0 9 0 1
0 11 -1 0
10
end_operator
begin_operator
move mid-camp boss-lair
1
7 1
2
0 10 -1 0
0 11 0 1
10
end_operator
begin_operator
move mid-camp long-road
1
7 1
2
0 9 -1 0
0 11 0 1
10
end_operator
begin_operator
respawn firelink hp2 s0
2
2 0
6 0
28
0 10 -1 1
0 8 -1 0
0 9 -1 1
0 11 -1 1
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 0
0 31 -1 1
0 15 -1 0
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn firelink hp2 s1
2
2 0
6 0
28
0 10 -1 1
0 8 -1 0
0 9 -1 1
0 11 -1 1
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 0
0 31 -1 1
0 15 -1 1
0 19 -1 0
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn firelink hp2 s2
2
2 0
6 0
28
0 10 -1 1
0 8 -1 0
0 9 -1 1
0 11 -1 1
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 0
0 31 -1 1
0 15 -1 1
0 19 -1 1
0 20 -1 0
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn firelink hp2 s3
2
2 0
6 0
28
0 10 -1 1
0 8 -1 0
0 9 -1 1
0 11 -1 1
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 0
0 31 -1 1
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 0
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn firelink hp2 s4
2
2 0
6 0
28
0 10 -1 1
0 8 -1 0
0 9 -1 1
0 11 -1 1
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 0
0 31 -1 1
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 0
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn firelink hp2 s5
2
2 0
6 0
28
0 10 -1 1
0 8 -1 0
0 9 -1 1
0 11 -1 1
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 0
0 31 -1 1
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 0
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn firelink hp2 s6
2
2 0
6 0
28
0 10 -1 1
0 8 -1 0
0 9 -1 1
0 11 -1 1
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 0
0 31 -1 1
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 0
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn firelink hp3 s0
2
2 0
6 1
28
0 10 -1 1
0 8 -1 0
0 9 -1 1
0 11 -1 1
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
0 31 -1 0
0 15 -1 0
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn firelink hp3 s1
2
2 0
6 1
28
0 10 -1 1
0 8 -1 0
0 9 -1 1
0 11 -1 1
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
0 31 -1 0
0 15 -1 1
0 19 -1 0
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn firelink hp3 s2
2
2 0
6 1
28
0 10 -1 1
0 8 -1 0
0 9 -1 1
0 11 -1 1
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
0 31 -1 0
0 15 -1 1
0 19 -1 1
0 20 -1 0
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn firelink hp3 s3
2
2 0
6 1
28
0 10 -1 1
0 8 -1 0
0 9 -1 1
0 11 -1 1
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
0 31 -1 0
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 0
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn firelink hp3 s4
2
2 0
6 1
28
0 10 -1 1
0 8 -1 0
0 9 -1 1
0 11 -1 1
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
0 31 -1 0
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 0
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn firelink hp3 s5
2
2 0
6 1
28
0 10 -1 1
0 8 -1 0
0 9 -1 1
0 11 -1 1
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
0 31 -1 0
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 0
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn firelink hp3 s6
2
2 0
6 1
28
0 10 -1 1
0 8 -1 0
0 9 -1 1
0 11 -1 1
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
0 31 -1 0
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 0
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn mid-camp hp2 s0
2
3 0
6 0
28
0 10 -1 1
0 8 -1 1
0 9 -1 1
0 11 -1 0
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 0
0 31 -1 1
0 15 -1 0
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn mid-camp hp2 s1
2
3 0
6 0
28
0 10 -1 1
0 8 -1 1
0 9 -1 1
0 11 -1 0
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 0
0 31 -1 1
0 15 -1 1
0 19 -1 0
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn mid-camp hp2 s2
2
3 0
6 0
28
0 10 -1 1
0 8 -1 1
0 9 -1 1
0 11 -1 0
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 0
0 31 -1 1
0 15 -1 1
0 19 -1 1
0 20 -1 0
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn mid-camp hp2 s3
2
3 0
6 0
28
0 10 -1 1
0 8 -1 1
0 9 -1 1
0 11 -1 0
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 0
0 31 -1 1
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 0
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn mid-camp hp2 s4
2
3 0
6 0
28
0 10 -1 1
0 8 -1 1
0 9 -1 1
0 11 -1 0
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 0
0 31 -1 1
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 0
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn mid-camp hp2 s5
2
3 0
6 0
28
0 10 -1 1
0 8 -1 1
0 9 -1 1
0 11 -1 0
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 0
0 31 -1 1
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 0
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn mid-camp hp2 s6
2
3 0
6 0
28
0 10 -1 1
0 8 -1 1
0 9 -1 1
0 11 -1 0
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 0
0 31 -1 1
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 0
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn mid-camp hp3 s0
2
3 0
6 1
28
0 10 -1 1
0 8 -1 1
0 9 -1 1
0 11 -1 0
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
0 31 -1 0
0 15 -1 0
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn mid-camp hp3 s1
2
3 0
6 1
28
0 10 -1 1
0 8 -1 1
0 9 -1 1
0 11 -1 0
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
0 31 -1 0
0 15 -1 1
0 19 -1 0
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn mid-camp hp3 s2
2
3 0
6 1
28
0 10 -1 1
0 8 -1 1
0 9 -1 1
0 11 -1 0
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
0 31 -1 0
0 15 -1 1
0 19 -1 1
0 20 -1 0
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn mid-camp hp3 s3
2
3 0
6 1
28
0 10 -1 1
0 8 -1 1
0 9 -1 1
0 11 -1 0
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
0 31 -1 0
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 0
0 24 -1 1
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn mid-camp hp3 s4
2
3 0
6 1
28
0 10 -1 1
0 8 -1 1
0 9 -1 1
0 11 -1 0
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
0 31 -1 0
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 0
0 25 -1 1
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn mid-camp hp3 s5
2
3 0
6 1
28
0 10 -1 1
0 8 -1 1
0 9 -1 1
0 11 -1 0
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
0 31 -1 0
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 0
0 16 -1 1
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
respawn mid-camp hp3 s6
2
3 0
6 1
28
0 10 -1 1
0 8 -1 1
0 9 -1 1
0 11 -1 0
1 35 0 33 -1 1
1 35 0 34 -1 1
1 35 0 32 -1 0
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 7 0 1
0 28 -1 1
0 29 -1 1
0 30 -1 1
0 31 -1 0
0 15 -1 1
0 19 -1 1
0 20 -1 1
0 23 -1 1
0 24 -1 1
0 25 -1 1
0 16 -1 0
1 17 0 18 -1 1
1 21 0 22 -1 1
1 26 0 27 -1 1
200
end_operator
begin_operator
rest firelink
2
8 0
7 1
39
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 2 -1 0
0 3 -1 1
1 6 0 28 -1 1
1 6 1 28 -1 1
1 6 0 29 -1 1
1 6 1 29 -1 1
2 28 0 6 0 30 -1 0
2 29 0 6 0 30 -1 0
2 30 0 6 0 30 -1 0
2 31 0 6 0 30 -1 0
5 28 1 29 1 30 0 31 1 6 1 30 -1 1
4 28 1 29 1 30 0 6 1 30 -1 1
4 28 1 30 0 31 1 6 1 30 -1 1
3 28 1 30 0 6 1 30 -1 1
4 29 1 30 0 31 1 6 1 30 -1 1
3 29 1 30 0 6 1 30 -1 1
3 30 0 31 1 6 1 30 -1 1
2 30 0 6 1 30 -1 1
2 28 0 6 1 31 -1 0
2 29 0 6 1 31 -1 0
2 30 0 6 1 31 -1 0
2 31 0 6 1 31 -1 0
5 28 1 29 1 30 1 31 0 6 0 31 -1 1
4 28 1 29 1 31 0 6 0 31 -1 1
4 28 1 30 1 31 0 6 0 31 -1 1
3 28 1 31 0 6 0 31 -1 1
4 29 1 30 1 31 0 6 0 31 -1 1
3 29 1 31 0 6 0 31 -1 1
3 30 1 31 0 6 0 31 -1 1
2 31 0 6 0 31 -1 1
1 17 1 18 -1 1
1 21 1 22 -1 1
1 26 1 27 -1 1
60
end_operator
begin_operator
rest mid-camp
2
11 0
7 1
39
0 12 -1 0
1 0 0 13 -1 0
1 1 0 14 -1 0
0 17 -1 0
0 21 -1 0
0 26 -1 0
0 2 -1 1
0 3 -1 0
1 6 0 28 -1 1
1 6 1 28 -1 1
1 6 0 29 -1 1
1 6 1 29 -1 1
2 28 0 6 0 30 -1 0
2 29 0 6 0 30 -1 0
2 30 0 6 0 30 -1 0
2 31 0 6 0 30 -1 0
5 28 1 29 1 30 0 31 1 6 1 30 -1 1
4 28 1 29 1 30 0 6 1 30 -1 1
4 28 1 30 0 31 1 6 1 30 -1 1
3 28 1 30 0 6 1 30 -1 1
4 29 1 30 0 31 1 6 1 30 -1 1
3 29 1 30 0 6 1 30 -1 1
3 30 0 31 1 6 1 30 -1 1
2 30 0 6 1 30 -1 1
2 28 0 6 1 31 -1 0
2 29 0 6 1 31 -1 0
2 30 0 6 1 31 -1 0
2 31 0 6 1 31 -1 0
5 28 1 29 1 30 1 31 0 6 0 31 -1 1
4 28 1 29 1 31 0 6 0 31 -1 1
4 28 1 30 1 31 0 6 0 31 -1 1
3 28 1 31 0 6 0 31 -1 1
4 29 1 30 1 31 0 6 0 31 -1 1
3 29 1 31 0 6 0 31 -1 1
3 30 1 31 0 6 0 31 -1 1
2 31 0 6 0 31 -1 1
1 17 1 18 -1 1
1 21 1 22 -1 1
1 26 1 27 -1 1
60
end_operator
0
