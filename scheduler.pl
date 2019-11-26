:- use_module(library(clpfd)).
:- consult(examscheduler).

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

schedule_courses_to_rooms([],_,[]).
schedule_courses_to_rooms([Course | CT], Rooms, [Result | RT]) :-
    course(Course),
    schedule_course_into_room(Course, Rooms, Result),
    schedule_courses_to_rooms(CT, Rooms, RT).

% case that course fit in a room, and room is big enough + has time slot
schedule_course_into_room(Course, [Room | _ ], Result) :-
    course_fit_in_room(Course, Room),
    room_has_available_day(Room),
    room_has_available_time(Room),
    create_room_course_pair(Course, Room, Result).

% case that course fits in room and has available day, but no available time
schedule_course_into_room(Course, [Room | RT], Result) :-
    course_fit_in_room(Course, Room),
    room_has_available_day(Room),
    schedule_course_into_room(Course, RT, Result).

% case that course fits in room, but has no available days
schedule_course_into_room(Course, [Room | RT], Result) :-
    course_fit_in_room(Course, Room),
    schedule_course_into_room(Course, RT, Result).
    
% case that course doesnt fit in the room
schedule_course_into_room(Course, [ _ | RT], Result) :-
    schedule_course_into_room(Course, RT, Result).

create_room_course_pair(Course, Room, prop(Course, has_exam_in, Room)).

schedule(Courses, Rooms, Result) :-
    sort_courses(Courses, Scourses),
    sort_rooms(Rooms, Srooms),
    schedule_courses_to_rooms(Scourses, Srooms, Result).