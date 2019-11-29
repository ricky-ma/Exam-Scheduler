% Database of Courses
% only Winter 2019 Term 1 courses w/ final exams listed
% no work-term placements, research seminars, directed studies, thesis

% :- discontiguous prop/3.

course(cs100).
course(cs103).
course(cs110).
course(cs121).
course(cs203).
course(cs210).
course(cs213).
course(cs221).
course(cs302).
course(cs304).
course(cs310).
course(cs311).
course(cs312).
course(cs313).
course(cs314).
course(cs317).
course(cs319).
course(cs320).
course(cs322).
course(cs340).
course(cs344).
course(cs404).
course(cs410).
course(cs415).
course(cs420).
course(cs421).
course(cs422).
course(cs424).
course(cs425).
course(cs427).
course(cs430).

room(dmp100).
room(dmp310).
room(dmp111).
room(srcA).
room(srcB).
room(srcC).

prop(cs100, enrolled, 290).
prop(cs103, enrolled, 459).
prop(cs110, enrolled, 774).
prop(cs121, enrolled, 455).
prop(cs203, enrolled, 27).
prop(cs210, enrolled, 615).
prop(cs213, enrolled, 233).
prop(cs221, enrolled, 305).
prop(cs302, enrolled, 99).
prop(cs304, enrolled, 337).
prop(cs310, enrolled, 334).
prop(cs311, enrolled, 120).
prop(cs312, enrolled, 124).
prop(cs313, enrolled, 241).
prop(cs314, enrolled, 75).
prop(cs317, enrolled, 168).
prop(cs319, enrolled, 32).
prop(cs320, enrolled, 285).
prop(cs322, enrolled, 186).
prop(cs340, enrolled, 179).
prop(cs344, enrolled, 119).
prop(cs404, enrolled, 102).
prop(cs404, enrolled, 147).
prop(cs415, enrolled, 59).
prop(cs420, enrolled, 55).
prop(cs421, enrolled, 74).
prop(cs422, enrolled, 98).
prop(cs424, enrolled, 46).
prop(cs424, enrolled, 69).
prop(cs427, enrolled, 74).
prop(cs430, enrolled, 117).

prop(dmp100, capacity, 800).
prop(dmp310, capacity, 160).
prop(dmp111, capacity, 200).
prop(srcA, capacity, 300).

% avail(Room, Day, Times) is true if Room is available at Times on Day
/*
avail(dmp100, [[1, [0830, 1200, 1530, 1900]],
               [2, [0830, 1200, 1530, 1900]],
               [3, [0830, 1200, 1530, 1900]],
               [4, [0830, 1200, 1530, 1900]],
               [5, [0830, 1200, 1530, 1900]]]).
*/
avail(dmp100, [[1, [0830, 1200, 1530, 1900]]]).

avail(dmp310, [[1, [0830, 1200, 1530, 1900]],
               [2, [0830, 1200, 1530, 1900]],
               [3, [0830, 1200, 1530, 1900]],
               [4, [0830, 1200, 1530, 1900]],
               [5, [0830, 1200, 1530, 1900]]]).

avail(dmp111, [[1, [0830, 1200, 1530, 1900]],
               [2, [0830, 1200, 1530, 1900]],
               [3, [0830, 1200, 1530, 1900]],
               [4, [0830, 1200, 1530, 1900]],
               [5, [0830, 1200, 1530, 1900]]]).

avail(srcA, [[1, [0830, 1200, 1530, 1900]],
               [2, [0830, 1200, 1530, 1900]],
               [3, [0830, 1200, 1530, 1900]],
               [4, [0830, 1200, 1530, 1900]],
               [5, [0830, 1200, 1530, 1900]]]).

time(0830).
time(1200).
time(1530).
time(1900).

day(X) :- X =< 18.

/*
% avail_day_time(Room, Day, Time) is true if there is Room is availale during Time on Day.
avail_day_time(dmp100, 1, 0830).
avail_day_time(dmp100, 1, 1200).
avail_day_time(dmp100, 1, 1530).
avail_day_time(dmp100, 1, 1900).

avail_day_time(dmp100, 2, 0830).
avail_day_time(dmp100, 2, 1200).
avail_day_time(dmp100, 2, 1530).
avail_day_time(dmp100, 2, 1900).

avail_day_time(dmp100, 3, 0830).
avail_day_time(dmp100, 3, 1200).
avail_day_time(dmp100, 3, 1530).
avail_day_time(dmp100, 3, 1900).

avail_day_time(dmp100, 4, 0830).
avail_day_time(dmp100, 4, 1200).
avail_day_time(dmp100, 4, 1530).
avail_day_time(dmp100, 4, 1900).

avail_day_time(dmp100, 5, 0830).
avail_day_time(dmp100, 5, 1200).
avail_day_time(dmp100, 5, 1530).
avail_day_time(dmp100, 5, 1900).

avail_day_time(dmp100, 6, 0830).
avail_day_time(dmp100, 6, 1200).
avail_day_time(dmp100, 6, 1530).
avail_day_time(dmp100, 6, 1900).

% below is an example input of room_day_time
% an array of [Room, Day, Time]
% for Room is availale during Time on Day.
[
    [dmp100, 1, 0830],
    [dmp100, 1, 1200},
    [dmp100, 1, 1530],
    [dmp100, 1, 1900],
    [dmp100, 2, 0830],
    [dmp100, 2, 1200},
    [dmp100, 2, 1530],
    [dmp100, 2, 1900],
    [dmp100, 3, 0830],
    [dmp100, 3, 1200},
    [dmp100, 3, 1530],
    [dmp100, 3, 1900],
    [dmp100, 4, 0830],
    [dmp100, 4, 1200},
    [dmp100, 4, 1530],
    [dmp100, 4, 1900],
    [dmp100, 5, 0830],
    [dmp100, 5, 1200},
    [dmp100, 5, 1530],
    [dmp100, 5, 1900],
    
    [dmp111, 1, 0830],
    [dmp111, 1, 1200},
    [dmp111, 1, 1530],
    [dmp111, 1, 1900],
    [dmp111, 2, 0830],
    [dmp111, 2, 1200},
    [dmp111, 2, 1530],
    [dmp111, 2, 1900],
    [dmp111, 3, 0830],
    [dmp111, 3, 1200},
    [dmp111, 3, 1530],
    [dmp111, 3, 1900],
    [dmp111, 4, 0830],
    [dmp111, 4, 1200},
    [dmp111, 4, 1530],
    [dmp111, 4, 1900],
    [dmp111, 5, 0830],
    [dmp111, 5, 1200},
    [dmp111, 5, 1530],
    [dmp111, 5, 1900],
    
    [dmp310, 1, 0830],
    [dmp310, 1, 1200},
    [dmp310, 1, 1530],
    [dmp310, 1, 1900],
    [dmp310, 2, 0830],
    [dmp310, 2, 1200},
    [dmp310, 2, 1530],
    [dmp310, 2, 1900],
    [dmp310, 3, 0830],
    [dmp310, 3, 1200},
    [dmp310, 3, 1530],
    [dmp310, 3, 1900],
    [dmp310, 4, 0830],
    [dmp310, 4, 1200},
    [dmp310, 4, 1530],
    [dmp310, 4, 1900],
    [dmp310, 5, 0830],
    [dmp310, 5, 1200},
    [dmp310, 5, 1530],
    [dmp310, 5, 1900],

    [srcA, 1, 0830],
    [srcA, 1, 1200},
    [srcA, 1, 1530],
    [srcA, 1, 1900],
    [srcA, 2, 0830],
    [srcA, 2, 1200},
    [srcA, 2, 1530],
    [srcA, 2, 1900],
    [srcA, 3, 0830],
    [srcA, 3, 1200},
    [srcA, 3, 1530],
    [srcA, 3, 1900],
    [srcA, 4, 0830],
    [srcA, 4, 1200},
    [srcA, 4, 1530],
    [srcA, 4, 1900],
    [srcA, 5, 0830],
    [srcA, 5, 1200},
    [srcA, 5, 1530],
    [srcA, 5, 1900],
]
*/


% prop(day, valid, [2,3,4,5,6,9,10,11,12,13,16,17,18]).