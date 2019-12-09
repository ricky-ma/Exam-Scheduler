:- use_module(library(clpfd)).
:- consult(database).

getCourseInfo([],[]).
getCourseInfo([Course|T], [prop(Course, enrolled, E)|RT]) :-
    prop(Course, enrolled, E),
    getCourseInfo(T, RT).

getCourseName([],[]).
getCourseName([prop(Course, enrolled, _) | T], [Course | RT]) :-
    getCourseName(T, RT).

sort_courses(Courses, SortedNames) :-
    getCourseInfo(Courses, Res),
    sort(3, @=<, Res, Sorted),
    getCourseName(Sorted, SortedNames).

getRoomInfo([],[]).
getRoomInfo([Room|T],[prop(Room, capacity, E)|RT]) :-
    prop(Room, capacity, E),
    getRoomInfo(T,RT).

getRoomName([],[]).
getRoomName([prop(Room,capacity,_)|T], [Room|RT]) :-
    getRoomName(T, RT).

sort_rooms(Rooms, SortedNames) :-
   getRoomInfo(Rooms, Res),
   sort(3, @=<, Res, Sorted),
   getRoomName(Sorted, SortedNames).


course_fit_in_room(Course, Room) :-
    room(Room),
    prop(Room, capacity, Rsize),
    course(Course),
    prop(Course, enrolled, Csize),
    Csize #=< Rsize.

room_has_available_day(Room) :-
    room(Room),
    prop(Room, day, DayList),
    length(DayList, Len),
    Len > 0.

room_has_available_time(Room) :-
    room(Room),
    prop(Room, time, TimeList),
    length(TimeList, Len),
    Len > 0.

myflatten([],[]).
myflatten([List|Rest], FlatList) :-
    append(List, FlatList0, FlatList),
    myflatten(Rest, FlatList0).


get_RDT([], []).
get_RDT([Room | RT], [FresAllDays | RDTs]) :-
    room(Room),
    avail(Room, DTs),
    get_RDT_all_days(Room, DTs, ResAllDays),
    myflatten(ResAllDays, FresAllDays),
    get_RDT(RT, RDTs).

get_RDT_all_days(_, [], []).
get_RDT_all_days(Room, [[Day, Times] | DTs], [Res1Day | ResAllDays]) :-
    getRDT_one_day(Room, Day, Times, Res1Day),
    get_RDT_all_days(Room, DTs, ResAllDays).

getRDT_one_day(_, _, [], []).
getRDT_one_day(Room, Day, [T | Times], [Res1Time | Res1Day]) :-
    getRDT_one_time(Room, Day, T, Res1Time),
    getRDT_one_day(Room, Day, Times, Res1Day).

getRDT_one_time(Room, Day, Time, [Room, Day, Time]).

schedule_courses_to_rooms([],_,[]).
schedule_courses_to_rooms([Course | CT], RDTs, [Result | RT]) :-
    schedule_course_into_room(Course, RDTs, Result, NRDTs),
    schedule_courses_to_rooms(CT, NRDTs, RT).

schedule_course_into_room(Course, [[Room, Day, Time] | RT], Result, RT) :-
    course_fit_in_room(Course, Room),
    create_room_course_pair(Course, Room, Day, Time, Result).

schedule_course_into_room(Course, [RDT | RT], Result, [RDT | NRT]) :-
    schedule_course_into_room(Course, RT, Result, NRT).

create_room_course_pair(Course, Room, Day, Time, scheduled(Course, Room, Day, Time)).

% TESTS
% schedule([cs311, cs312, cs313, cs322, cs340, cs344, cs404, cs410, cs430], [dmp100], R).
% schedule([cs210, cs213, cs221, cs302, cs304, cs310, cs311, cs312, cs313, cs322, cs340, cs344, cs404, cs410, cs430], [dmp100, dmp310, dmp111], R).
% schedule([cs210, cs213, cs221, cs302, cs304, cs310, cs311, cs312, cs313, cs322, cs340, cs344, cs404, cs410, cs430], [dmp100, dmp310, dmp111, srcA], R).
% schedule([cs100, cs103, cs110, cs121, cs203, cs210, cs213, cs221, cs302, cs304, cs310, cs311, cs312, cs313, cs314, cs317, cs319, cs320, cs322, cs340, cs344, cs404, cs410, cs415, cs420, cs421, cs422, cs424, cs425, cs427, cs430], [dmp100, dmp310, dmp111, srcA, srcB, srcC], R).

schedule(Courses, Rooms, Result) :-
    sort_courses(Courses, Scourses),
    sort_rooms(Rooms, Srooms),
    get_RDT(Srooms, RDTs),
    myflatten(RDTs, CleanRDTs),
    schedule_courses_to_rooms(Scourses, CleanRDTs, Result).

schedule_naive(Courses, Rooms, Result) :-
    get_RDT(Rooms, RDTs),
    myflatten(RDTs, CleanRDTs),
    schedule_courses_to_rooms(Courses, CleanRDTs, Result).