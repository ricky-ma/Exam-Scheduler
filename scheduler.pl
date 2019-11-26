/* 
pivoting_XXX and sort_by_YYY uses quicksort to sort
the enrollment and room size in ascending order
so when we schedule them in rooms we can miximize room uses
by using the smallest room for a course

This is a modified quicksort from:
http://kti.mff.cuni.cz/~bartak/prolog/sorting.html
*/

:- consult(examscheduler).

pivoting_course(prop(_, _, _),[],[],[]).
pivoting_course(prop(Course, enrolled, Size),[X|T],[X|L],G):-
    X=< Size,
    pivoting_course(prop(Course, enrolled, Size),T,L,G).
pivoting_course(prop(Course, enrolled, Size),[X|T],L,[X|G]):-
    X>Size,
    pivoting_course(prop(Course, enrolled, Size),T,L,G).

sort_by_enrollment([], Acc, Acc).
sort_by_enrollment([prop(Course, enrolled, Size) | T], Acc, Sorted) :-
    course(Course),
    pivoting_course(prop(Course, enrolled, Size), T, L1, L2),
    sort_by_enrollment(L1, Acc, Sorted1),
    sort_by_enrollment(L2, [prop(Course, enrolled, Size)|Sorted1], Sorted).

pivoting_rooms(prop(_, _, _),[],[],[]).
pivoting_rooms(prop(Room, capacity, Size),[X|T],[X|L],G):-
    X=< Size,
    pivoting_rooms(prop(Room, capacity, Size),T,L,G).
pivoting_rooms(prop(Room, capacity, Size),[X|T],L,[X|G]):-
    X>Size,
    pivoting_rooms(prop(Room, capacity, Size),T,L,G).

sort_by_capacity([], Acc, Acc).
sort_by_capacity([prop(Room, capacity, Size)| T], Acc, Sorted) :-
    room(Room),
    pivoting_rooms(prop(Room, capacity, Size), T, L1, L2),
    sort_by_capacity(L1, Acc, Sorted1),
    sort_by_capacity(L2, [prop(Room, capacity, Size)|Sorted1], Sorted).



course_fit_in_room(Course, Room) :-
    room(Room),
    prop(Room, capacity, Rsize),
    course(Course),
    prop(Course, enrolled, Csize),
    Csize =< Rsize.

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

schedule_course_into_room([], _, []).
% case that course fit in a room, and room is big enough + has time slot
schedule_course_into_room([Course|CT], [Room|RT], [CR|CRT]) :-
    course_fit_in_room(Course, Room),
    room_has_available_day(Room),
    room_has_available_time(Room),
    create_room_course_pair(Course, Room, CR),
    schedule_course_into_room(CT, [Room|RT], CRT).

% case that course fits in room and has available day, but no available time
schedule_course_into_room([Course|CT], [Room|RT], Result) :-
    course_fit_in_room(Course, Room),
    room_has_available_day(Room),
    schedule_course_into_room([Course|CT], RT, Result).

% case that course fits in room, but has no available days
schedule_course_into_room([Course|CT], [Room|RT], Result) :-
    course_fit_in_room(Course, Room),
    schedule_course_into_room([Course|CT], RT, Result).
    
% case that course doesnt fit in the room
schedule_course_into_room(Courses, [_|RT], Result) :-
    schedule_course_into_room(Courses, RT, Result).

create_room_course_pair(Course, Room, prop(Course, has_exam_in, Room)).
